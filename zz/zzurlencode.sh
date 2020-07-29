# ----------------------------------------------------------------------------
# http://en.wikipedia.org/wiki/Percent-encoding
# Codifica o texto como %HH, para ser usado numa URL (a/b → a%2Fb).
# Obs.: Por padrão, letras, números e _.~- não são codificados (RFC 3986)
#
# Opções:
#   -t, --todos  Codifica todos os caracteres, sem exceção
#   -n STRING    Informa caracteres adicionais que não devem ser codificados
#
# Uso: zzurlencode [texto]
# Ex.: zzurlencode http://www            # http%3A%2F%2Fwww
#      zzurlencode -n : http://www       # http:%2F%2Fwww
#      zzurlencode -t http://www         # %68%74%74%70%3A%2F%2F%77%77%77
#      zzurlencode -t -n w/ http://www   # %68%74%74%70%3A//www
#
# Autor: Guilherme Magalhães Gall <gmgall (a) gmail com>
# Desde: 2013-03-19
# Versão: 4
# Licença: GPL
# Requisitos: zzmaiusculas
# Tags: texto, conversão
# ----------------------------------------------------------------------------
zzurlencode ()
{
	zzzz -h urlencode "$1" && return

	local resultado undo

	# RFC 3986, unreserved - Estes nunca devem ser convertidos (exceto se --all)
	local nao_converter='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.~-'

	while test -n "$1"
	do
		case "$1" in
			-t | --todos | -a | --all)
				nao_converter=''
				shift
			;;
			-n)
				if test -z "$2"
				then
					zztool erro 'Faltou informar o valor da opção -n'
					return 1
				fi

				nao_converter="$nao_converter$2"
				shift
				shift
			;;
			--) shift; break;;
			-*) zztool erro "Opção inválida: $1"; return 1;;
			*) break;;
		esac
	done

	# Codifica todos os caracteres, sem exceção
	# foo → %66%6F%6F
	resultado=$(
		if test -n "$1"
		then printf %s "$*"  # texto via argumentos
		else cat -           # texto via STDIN
		fi |
		# Usa o comando od para descobrir o valor hexa de cada caractere.
		# É portável e suporta UTF-8, decompondo cada caractere em seus bytes.
		od -v -A n -t x1 |
		# Converte os números hexa para o formato %HH, sem espaços
		tr -d ' \n\t' |
		sed 's/../%&/g' |
		zzmaiusculas
	)

	# Há caracteres protegidos, que não devem ser convertidos?
	if test -n "$nao_converter"
	then
		# Desfaz a conversão de alguns caracteres (usando magia)
		#
		# Um sed é aplicado no resultado original "desconvertendo"
		# alguns dos %HH de volta para caracteres normais. Mas como
		# fazer isso somente para os caracteres de $nao_converter?
		#
		# É usada a própria zzurlencode para codificar a lista dos
		# protegidos, e um sed formata esse resultado, compondo outro
		# script sed, que será aplicado no resultado original trocando
		# os %HH por \xHH.
		#
		# $ zzurlencode -t -- "ab" | sed 's/%\(..\)/s,&,\\\\x\1,g; /g'
		# s,%61,\\x61,g; s,%62,\\x62,g;
		#
		# Essa string manipulada será mostrada pelo printf %b, que
		# expandirá os \xHH tornando-os caracteres normais novamente.
		# Ufa! :)
		#
		undo=$(zzurlencode -t -- "$nao_converter" | sed 's/%\(..\)/s,&,\\\\x\1,g; /g')
		printf '%b\n' $(echo "$resultado" | sed "$undo")
	else
		printf '%s\n' "$resultado"
	fi
}

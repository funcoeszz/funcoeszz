# ----------------------------------------------------------------------------
# https://cep.guiamais.com.br
# Busca o CEP de qualquer rua de qualquer cidade do país ou vice-versa.
# Pode-se fornecer apenas o CEP, ou o endereço com estado.
# Uso: zzcep <endereço estado| CEP>
# Ex.: zzcep Rua Santa Ifigênia, São Paulo, SP
#      zzcep 01310-000
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-11-08
# Versão: 4
# Requisitos: zzzz zztool zzsemacento zzminusculas zzxml zzjuntalinhas zzcolunar zztrim zzpad
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzcep ()
{
	zzzz -h cep "$1" && return

	local end cepend pagina1 pages ultima url2 logradouro bairro cidade cep
	local url='https://cep.guiamais.com.br'

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso cep; return 1; }

	# Testando se parametro é o CEP
	if echo "$1" | grep -E '^[0-9]{5}-[0-9]{3}$' > /dev/null
	then
		end=0
		cepend="$1"
	else
		end=1
		cepend=$(echo "$*" | zzsemacento | zzminusculas | sed 's/, */-/g' | zztool sedurl)
	fi

	# A primeira página ou endereço das várias páginas
	pagina1=$(zztool source "${url}/busca?word=${cepend}")

	if echo "$pagina1" | grep 'sr-only' >/dev/null
	then
		ultima=$(echo "$pagina1" | sed -n '/<ul/,/ul>/{/\/busca\//{$d;s/.*page=//;s/".*//;p;}}' | sort -n | tail -n 1)
		url2=$(echo "$pagina1" | sed -n '/<ul/,/ul>/{/\/busca\//{s/.*href="//;s/page=.*/page=/;p;q;}}')
		for pages in $(seq $ultima)
		do
			zztool source "${url}${url2}${pages}"
		done
	else
		echo "$pagina1"
	fi |
		zzxml --tag th --tag td |
		zzjuntalinhas -i '<td' -f '</td>' -d ' ' |
		zzjuntalinhas -i '<th' -f '</th>' -d ' ' |
		sed 's|> </a>|> - </a>|g' |
		zzxml --untag |
		if test "$end" -eq 1
		then
			awk 'NR % 5 != 4' |
			zzcolunar -s '|' -z 4
		else
			awk 'NR % 5 != 4 && NR % 5 != 0' |
			zzcolunar -s '|' -z 3
		fi |
		sed '2,$ { /LOGRADOURO/d; }' |
		zztrim |
		tr -s ' ' |
		while IFS="|" read -r logradouro bairro cidade cep
		do
			echo "$cep $(zzpad 65 $logradouro) $(zzpad 25 $bairro) $(zzpad 30 $cidade) $cep"
		done |
		zztrim |
		if test "$end" -eq 1
		then
			sort -n |
			sed 's/[^[:blank:]]* //'
		else
			cat -
		fi
}

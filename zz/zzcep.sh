# ----------------------------------------------------------------------------
# http://www.achecep.com.br
# Busca o CEP de qualquer rua de qualquer cidade do país ou vice-versa.
# Pode-se fornecer apenas o CEP, ou o estado com endereço.
# Uso: zzcep <estado endereço | CEP>
# Ex.: zzcep SP Rua Santa Ifigênia
#      zzcep 01310-000
#
# Autor: Aurélio Marinho Jargas, www.aurelio.net
# Desde: 2000-11-08
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzcep ()
{
	zzzz -h cep "$1" && return

	local r e query
	local url='http://www.achecep.com.br'

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso cep; return; }

	# Testando se parametro é o CEP
	echo "$1" | tr -d '-' | grep -E '[0-9]{8}' > /dev/null
	if test $? -eq 0
	then
		query=$(echo "q=$1" | tr -d '-')
	fi

	# Conferindo se é sigla do Estado e endereço
	if test -z $query && test -n "$2"
	then
		echo $1 | grep -E '[a-zA-Z]{2}' > /dev/null
		if test $? -eq 0
		then
			e="$1"
			shift
			r=$(echo "$*"| sed "$ZZSEDURL")
			query="uf=${e}&q=$r"
		else
			zztool uso cep; return;
		fi
	fi

	# Testando se formou a query string
	test -n "$query" || { zztool uso cep; return; }

	echo "$query" | $ZZWWWPOST "$url" |
	sed -n '/^[[:blank:]]*CEP/,/^[[:blank:]]*$/p'| sed 's/^ *//g;$d'
}

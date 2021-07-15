#!/bin/bash
# 2011-05-20
# Aurelio Jargas
#
# Verificações de indentação nas funções.
# Procura por espaços em branco em lugares errados.


cd "$(dirname "$0")/.." || exit 1  # go to repo root

exit_code=0

eco() {
    echo -e "\033[36;1m$*\033[m"
}

check() {  # $1=name, $2=wrong
	if test -n "$2"
	then
		eco ----------------------------------------------------------------
		eco "* $1"
		echo "$2"
		exit_code=1
	fi
}

check "Linha que inicia com um espaço" "$(
	grep -r '^ ' zz/ |
	grep -v '^zz/zzpalpite.sh: /g'  # caso válido, sed multilinha
)"

check "Linha com Tab e espaço misturados" "$(
	grep -r '	 ' zz/ |
	# [\t ]: Dentro de colchetes, é regex
	grep -Fv '[	 ]' |
	# Em sed para substituição
	grep -Fv "sed 's" |
	# Falso-positivo: regex com espaços e tabs
	grep -v '^zz/zzloteria.sh:.*s/'
)"

check "Linha com Tabs ou espaços inúteis no final" "$(
	grep -r -E '[^ 	][ 	]+$' zz/ |
	grep -v '^zz/zzxml.sh:.*Foo $'  # exceção, usado num comentário
)"

check "Linhas vazias, mas com brancos" "$(
	grep -r -E '^[	 ]+$' zz/
)"


exit $exit_code

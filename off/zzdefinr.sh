# ----------------------------------------------------------------------------
# http://definr.com
# Busca o significado de um termo, palavra ou expressão no site Definr.
# Uso: zzdefinr termo
# Ex.: zzdefinr headphone
#      zzdefinr in force
#
# Autor: Felipe Arruda <felipemiguel (a) gmail com>
# Desde: 2008-08-15
# Versão: 1
# Tags: internet, dicionário
# ----------------------------------------------------------------------------
# DESATIVADA: 2020-12-22 Site foi descontinuado (veja issue #599)
zzdefinr ()
{
	zzzz -h definr "$1" && return

	test -n "$1" || { zztool -e uso definr; return 1; }

	local word=$(echo "$*" | sed 's/ /%20/g')

	zztool source "http://definr.com/$word" |
		sed '
			/<div id="meaning">/,/<\/div>/!d
			s/<[^>]*>//g
			s/&nbsp;/ /g
			/^$/d'
}

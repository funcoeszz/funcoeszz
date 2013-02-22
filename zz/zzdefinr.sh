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
# Licença: GPL
# ----------------------------------------------------------------------------
zzdefinr ()
{
	zzzz -h definr "$1" && return

	[ "$1" ] || { zztool uso definr; return 1; }

	local word=$(echo "$*" | sed 's/ /%20/g')

	$ZZWWWHTML "http://definr.com/$word" |
		sed '
			/<div id="meaning">/,/<\/div>/!d
			s/<[^>]*>//g
			s/&nbsp;/ /g
			/^$/d'
}

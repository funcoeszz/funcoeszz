# ----------------------------------------------------------------------------
# http://www.cinemais.com.br
# Busca horários das sessões dos filmes no site do Cinemais.
# Sem argumento lista as cidades com os códigos dos cinemas.
#
# Uso: zzcinemais [código cidade]
# Ex.: zzcinemais 9
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2008-08-25
# Versão: 9
# Licença: GPLv2
# Requisitos: zzecho zzjuntalinhas zztrim zzutf8 zzxml
# Tags: cinema
# ----------------------------------------------------------------------------
zzcinemais ()
{
	zzzz -h cinemais "$1" && return

	local cidades codigo
	local url='http://www.cinemais.com.br/programacao'

	cidades=$(
		zztool source -o "ISO-8859-1" "$url" |
		zztool texto_em_iso |
		sed -n '/cliclabeProg/,/cliclabeProg/p' |
		zzxml --notag script --tag li |
		zztrim |
		zzjuntalinhas -i '<li' -f '</li>' -d '' |
		sed 's/.*id="//; s/">/ - /; s/<.*//' |
		sort -n
	)

	if test -z "$1"
	then
		echo "$cidades"
		return
	fi

	zztool testa_numero "$1" || { zztool -e uso cinemais; return 1; }

	codigo="$1"

	# Especificando User Agent na opçãp -u "Mozilla/5.0"
	zzecho -N -l ciano $(echo "$cidades" | grep "^${codigo} - "| sed 's/^[0-9][0-9]* - //')
	zztool source  -o "ISO-8859-1" -u "Mozilla/5.0" "${url}/cinema.php?cc=${codigo}" 2>/dev/null |
	zztool texto_em_iso |
	zzutf8 |
	grep -E '(<td><a href|<td><small|[0-9] a [0-9])' |
	zztrim |
	sed 's/<[^>]*>//g;s/Programa.* - //' |
	awk '{print}; NR%2==1 {print ""}' |
	sed '$d'
}

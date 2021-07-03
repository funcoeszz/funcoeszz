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
# Versão: 11
# Requisitos: zzzz zztool zzecho zzjuntalinhas zztrim zzutf8 zzxml
# Tags: internet, cinema
# ----------------------------------------------------------------------------
# DESATIVADA: 2021-07-03 Site mudou, quebrou tudo.
zzcinemais ()
{
	zzzz -h cinemais "$1" && return

	local cidades
	local codigo="$1"
	local url='http://www.cinemais.com.br/programacao'

	cidades=$(
		zztool source "$url" |
		zztool texto_em_iso |
		sed -n '/cliclabeProg/,/cliclabeProg/p' |
		zzxml --notag script --tag li |
		zztrim |
		zzjuntalinhas -i '<li' -f '</li>' -d '' |
		sed 's/.*id="//; s/">/ - /; s/<.*//' |
		sort -n
	)

	if test -z "$codigo"
	then
		echo "$cidades"
		return
	fi

	if ! zztool testa_numero "$codigo"
	then
		zztool -e uso cinemais
		return 1
	fi

	if ! echo "$cidades" | grep "^${codigo} - " >/dev/null
	then
		zztool erro "Não encontrei o cinema ${codigo}"
		return 1
	fi

	# Especificando User Agent na opçãp -u "Mozilla/5.0"
	zzecho -N -l ciano $(echo "$cidades" | grep "^${codigo} - " | sed 's/^[0-9][0-9]* - //')
	zztool source -u "Mozilla/5.0" "${url}/cinema.php?cc=${codigo}" 2>/dev/null |
	zztool texto_em_iso |
	grep -E '(<td><a href|<td><small|[0-9] a [0-9])' |
	zzutf8 |
	zztrim |
	sed 's/<[^>]*>//g;s/Programa.* - //' |
	awk '{print}; NR%2==1 {print ""}' |
	sed '$d'
}

# ----------------------------------------------------------------------------
# http://www.cinemais.com.br
# Busca horários das sessões dos filmes no site do Cinemais.
# Cidades disponíveis:
#   Uberaba                -   9
#   Patos de Minas         -  11
#   Guaratingueta          -  21
#   Anapolis               -  32
#   Resende                -  33
#   Monte Carlos           -  34
#   Juiz de Fora           -  35
#   Ituiutaba              -  36
#   Araxá                  -  37
#   Lorena                 -  38
#
# Uso: zzcinemais [cidade]
# Ex.: zzcinemais milenium
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2008-08-25
# Versão: 8
# Licença: GPLv2
# Requisitos: zzecho zzsemacento zzminusculas zztrim zzutf8
# Tags: cinema
# ----------------------------------------------------------------------------
zzcinemais ()
{
	zzzz -h cinemais "$1" && return

	test -n "$1" || { zztool -e uso cinemais; return 1; }

	local cidade cidades codigo

	cidade=$(echo "$*" | zzsemacento | zzminusculas | zztrim | sed 's/ /_/g')

	cidades="9:uberaba:Uberaba  - MG
	11:patos_de_minas:Patos de Minas - MG
	21:guaratingueta:Guaratinguetá - SP
	32:anapolis:Anápolis - GO
	33:resende:Resende - RJ
	34:monte_carlos:Montes Claros - MG
	35:juiz_de_fora:Juiz de Fora - MG
	36:ituiutaba:Ituiutaba - MG
	37:araxa:Araxá - MG
	38:lorena:Lorena - SP"

	codigo=$(echo "$cidades" | grep "${cidade}:" 2>/dev/null | cut -f 1 -d ":")

	# Especificando User Agent na opçãp -u "Mozilla/5.0"
	if test -n "$codigo"
	then
		zzecho -N -l ciano $(echo "$cidades" | grep "${cidade}:" | cut -f 3 -d ":")
		zztool source -u "Mozilla/5.0" "http://www.cinemais.com.br/programacao/cinema.php?cc=$codigo" 2>/dev/null |
		zzutf8 |
		grep -E '(<td><a href|<td><small|[0-9] a [0-9])' |
		zztrim |
		sed 's/<[^>]*>//g;s/Programa.* - //' |
		awk '{print}; NR%2==1 {print ""}' | sed '$d'
	fi
}

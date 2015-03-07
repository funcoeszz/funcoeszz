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
#
# Uso: zzcinemais [cidade]
# Ex.: zzcinemais milenium
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2008-08-25
# Versão: 7
# Licença: GPLv2
# Requisitos: zzecho zzsemacento zzminusculas zztrim
# ----------------------------------------------------------------------------
zzcinemais ()
{
	zzzz -h cinemais "$1" && return

	test -n "$1" || { zztool uso cinemais; return 1; }

	local cidade cidades codigo

	cidade=$(echo "$*" | zzsemacento | zzminusculas | zztrim | sed 's/ /_/g')

	cidades="9:uberaba:Uberaba  - MG
	11:patos_de_minas:Patos de Minas - MG
	21:guaratingueta:Guaratinguetá - SP
	32:anapolis:Anápolis - GO
	33:resende:Resende - RJ
	34:monte_carlos:Montes Claros - MG
	35:juiz_de_fora:Juiz de Fora - MG"

	codigo=$(echo "$cidades" | grep "${cidade}:" 2>/dev/null | cut -f 1 -d ":")

	# Necessário fazer uso do argumento -useragent="Mozilla/5.0", pois o site se recusa a funcionar com lynx, links, curl e w3m.
	# Uma ridícula implementação do site :( ( Desculpe pelo protesto! )
	if test -n "$codigo"
	then
		zzecho -N -l ciano $(echo "$cidades" | grep "${cidade}:" | cut -f 3 -d ":")
		$ZZWWWHTML -useragent="Mozilla/5.0" "http://www.cinemais.com.br/programacao/cinema.php?cc=$codigo" 2>/dev/null |
		if test $ZZUTF -eq 1
		then
			zztool texto_em_iso
		else
			cat -
		fi |
		grep -E '(<td><a href|<td><small)' |
		zztrim |
		sed 's/<[^>]*>//g' |
		awk '{print}; NR%2==0 {print ""}' | sed '$d'
	fi
}

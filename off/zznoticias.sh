# ----------------------------------------------------------------------------
# http://noticias.correioweb.com.br
# Busca notícias sobre assuntos diversos na internet.
# Se não informado um argumento, o padrão é "mun".
# Uso: zznoticias [ bra | mun | eco | pol | esp ]
# Ex.: zznoticias bra
#      zznoticias eco
#
# Autor: Frederico Freire Boaventura <anonymous (a) galahad com br>
# Desde: 2005-04-02
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2010-12-22 URL parece ok, mas o filtro está quebrado.
zznoticias ()
{
	zzzz -h noticias $1 && return

	local h d m y a URL

	h=`date +%H`
	d=`date +%d | sed 's/^0//'`
	m=`date +%m | sed 's/^0//'`
	y=`date +%Y`

	a=${1:-"mun"}
	a=$(echo $a | sed 's/bra/Brasil/;s/mun/Mundo/;s/eco/Economia/;s/pol/Politica/;s/esp/Esportes/')
	[ "$h" == "00" ] && d=$(($d-1))
	
	URL="http://noticias.correioweb.com.br/ultimas.htm?notas=$a&dia_novo=$d&novo_mes=$m&novo_ano=$y"
	
	$ZZWWWDUMP "$URL" |
		sed '
			s/^  \+//g
			/^.\([0-9]\)/!d
			/^.\([0-9][h\|\/]\)/!d'
	echo -en "\nfonte: $URL\n"
}

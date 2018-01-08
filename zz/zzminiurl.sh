# ----------------------------------------------------------------------------
# Encurta uma URL utilizando o google ("https://goo.gl/").
# Caso a URL já seja encurtada, será exibida a URL completa.
# Obs.: Se a URL não tiver protocolo no início, será colocado http://
# Uso: zzminiurl URL
# Ex.: zzminiurl http://www.funcoeszz.net
#      zzminiurl www.funcoeszz.net         # O http:// no início é opcional
#      zzminiurl https://goo.gl/yz4cb9
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2010-04-26
# Versão: 6
# Licença: GPL
# ----------------------------------------------------------------------------
zzminiurl ()
{
	zzzz -h miniurl "$1" && return

	test -n "$1" || { zztool -e uso miniurl; return 1; }

	local url="$1"
	local prefixo='http://'
	local urlencurtador='https://www.googleapis.com/urlshortener/v1/url?key=AIzaSyAutIDVbN_3CmtxpunVnXruLYYAXs5e9Sw'
	local urlexpansor="https://www.googleapis.com/urlshortener/v1/url?key=AIzaSyAutIDVbN_3CmtxpunVnXruLYYAXs5e9Sw&shortUrl"
	local contenttype='Content-Type: application/json'
	local parametro="{\"longUrl\": \"$url\"}"
	local urlcurta
	local urlcompara

	# Se o usuário não informou o protocolo, adiciona o padrão
	echo "$url" | egrep '^(https?|ftp|mms)://' >/dev/null || url="$prefixo$url"

	urlcompara=$(echo "$url" | sed 's/\(.*\:\/\/\)\(goo\.gl\).*/\2/')
	urlcurta=$(curl -s "$urlencurtador" -H "$contenttype" -d "$parametro" 2>/dev/null)

	if test "$urlcompara" == 'goo.gl'
	then
		curl -s "$urlexpansor=$url" | sed -n '/"longUrl"/ {s/.*\(http[^"]*\)".*/\1/g; p; }'
	else
		echo "$urlcurta" | sed -n '/"id"/ {s/.*\(http[^"]*\)".*/\1/g; p;}'
	fi
}

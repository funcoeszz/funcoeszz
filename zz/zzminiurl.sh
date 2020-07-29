# ----------------------------------------------------------------------------
# Encurta uma URL utilizando o bit.ly ("https://bit.ly/").
# Caso a URL já seja encurtada, será exibida a URL completa.
# Obs.: Se a URL não tiver protocolo no início, será colocado http://
# Uso: zzminiurl URL
# Ex.: zzminiurl http://www.funcoeszz.net
#      zzminiurl www.funcoeszz.net         # O http:// no início é opcional
#      zzminiurl http://bit.ly/2qysTH4
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2010-04-26
# Versão: 7
# Licença: GPL
# Tags: internet, url
# ----------------------------------------------------------------------------
zzminiurl ()
{
	zzzz -h miniurl "$1" && return

	test -n "$1" || { zztool -e uso miniurl; return 1; }

	local url="$1"
	local prefixo='http://'
	local urlEncurtador='https://api-ssl.bitly.com/v3/shorten?access_token=f158450fee1fd865e57a85cb466d217f2e355fb9&longUrl'
	local urlExpansor='https://api-ssl.bitly.com/v3/expand?access_token=f158450fee1fd865e57a85cb466d217f2e355fb9&shortUrl'
	local urlCompara=$(echo "$url" | sed 's/\(.*\:\/\/\)\(bit\.ly\).*/\2/')

	# Se o usuário não informou o protocolo, adiciona o padrão.
	echo "$url" | egrep '^(https?|ftp|mms)://' >/dev/null || url="$prefixo$url"

	# Testa se a URL já é encurtada, se sim, expande, senão, encurta.
	if test 'bit.ly' = "$urlCompara"
	then
		curl -s ${urlExpansor}=${url} | sed -n '/"long_url"/ {s/.*\(http[^"]*\)".*/\1/g; p; }' && echo
	else
		curl -s ${urlEncurtador}=${url} | sed 's/.*"url":"\(.*\)","h.*/\1/' && echo
	fi
}

# ----------------------------------------------------------------------------
# Encurta uma URL utilizando o site http://migre.me ou http://is.gd
# Obs.: Se a URL não tiver protocolo no início, será colocado http://
# Uso: zzminiurl URL
# Ex.: zzminiurl http://www.funcoeszz.net
#      zzminiurl www.funcoeszz.net         # O http:// no início é opcional
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2010-04-26
# Versão: 5
# Licença: GPL
# Requisitos: zztestar
# ----------------------------------------------------------------------------
zzminiurl ()
{
	zzzz -h miniurl "$1" && return

	test -n "$1" || { zztool -e uso miniurl; return 1; }

	local url="$1"
	local prefixo='http://'
	local shorturl

	# Se o usuário não informou o protocolo, adiciona o padrão
	echo "$url" | egrep '^(https?|ftp|mms)://' >/dev/null || url="$prefixo$url"

	if   zztestar url_ok "http://migre.me"
	then
		shorturl=$(zztool source "http://migre.me/api.txt?url=$url" 2>/dev/null)
	elif zztestar url_ok "http://is.gd"
	then
		shorturl=$(
			curl -L -s --data "url=$url" http://is.gd/create.php |
			grep 'short_url' |
			grep -o 'value="[^"]*"' |
			cut -f 2 -d \"
		)
	fi

	test -n "$shorturl" && echo "$shorturl
}

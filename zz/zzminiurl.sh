# ----------------------------------------------------------------------------
# http://migre.me
# Encurta uma URL utilizando o site migre.me.
# Obs.: Se a URL não tiver protocolo no início, será colocado http://
# Uso: zzminiurl URL
# Ex.: zzminiurl http://www.funcoeszz.net
#      zzminiurl www.funcoeszz.net         # O http:// no início é opcional
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2010-04-26
# Versão: 4
# Licença: GPL
# ----------------------------------------------------------------------------
zzminiurl ()
{
	zzzz -h miniurl "$1" && return

	[ "$1" ] || { zztool uso miniurl; return 1; }

	local url="$1"
	local prefixo='http://'

	# Se o usuário não informou o protocolo, adiciona o padrão
	echo "$url" | egrep '^(https?|ftp|mms)://' >/dev/null || url="$prefixo$url"

	$ZZWWWHTML "http://migre.me/api.txt?url=$url" 2>/dev/null
	echo
}

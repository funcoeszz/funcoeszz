# ----------------------------------------------------------------------------
# Mostra se o IP informado está em alguma blacklist.
# Uso: zzblist IP
# Ex.: zzblist 200.199.198.197
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2008-10-16
# Versão: 4
# Licença: GPL
# ----------------------------------------------------------------------------
zzblist ()
{
	zzzz -h blist "$1" && return

	local URL="http://addgadgets.com/ip_blacklist/index.php?ipaddr="
	local ip="$1"
	local lista

	test -n "$1" || { zztool uso blist; return 1; }

	zztool -e testa_ip "$ip" || return 1

	lista=$(
		$ZZWWWDUMP "${URL}${ip}" |
		grep 'Listed' |
		sed '/ahbl\.org/d;/=/d;/ *Not/d'
	)

	if test $(echo "$lista" | sed '/^ *$/d' | zztool num_linhas) -eq 0
	then
		zztool eco "O IP não está em nenhuma blacklist"
	else
		zztool eco "O IP está na(s) seguinte(s) blacklist"
		echo "$lista" | sed 's/ *Listed//'
	fi
}

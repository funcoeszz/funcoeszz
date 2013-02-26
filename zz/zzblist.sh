# ----------------------------------------------------------------------------
# Mostra se o IP informado está em alguma blacklist (SBL, PBL e XBL).
# Uso: zzblist IP
# Ex.: zzblist 200.199.198.197
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2008-10-16
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
zzblist ()
{
	zzzz -h blist "$1" && return

	local URL="http://www.spamblock.com.br/rblcheck.php?ip="
	local ip="$1"

	[ "$1" ] || { zztool uso blist; return 1; }

	zztool -e testa_ip "$ip" || return 1

	$ZZWWWDUMP "$URL$ip" | sed -n '
		/[Rr]elat.rio/ p
		/O IP /,/^$/ p'
}

# ----------------------------------------------------------------------------
# Mostra se o IP passado está em alguma blacklist  (SBL, PBL e XBL).
# Uso: zzblist IP
# Ex.: zzblist 200.199.198.197
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2008-10-16
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzblist ()
{
	zzzz -h blist "$1" && return

	[ "$1" ] || { zztool uso blist; return 1; }

	local URL="http://www.spamblock.com.br/rblcheck.php?ip="

	zztool -e testa_ip "$1" || return 1

	$ZZWWWDUMP "$URL"$1 | grep [Rr]elat.rio
	$ZZWWWDUMP "$URL"$1 | sed -n '/O IP /,/^$/p'
}

# ----------------------------------------------------------------------------
# http://en.wikipedia.org/wiki/Percent-encoding
# Decodifica textos no formato %HH, geralmente usados em URLs (%40 → @).
#
# Uso: zzurldecode [texto]
# Ex.: zzurldecode '%73%65%67%72%65%64%6F'
#      echo 'http%3A%2F%2F' | zzurldecode
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2014-03-14
# Versão: 2
# Licença: GPL
# Tags: texto, conversão
# ----------------------------------------------------------------------------
zzurldecode ()
{
	zzzz -h urldecode "$1" && return

	# Converte os %HH para \xHH, que são expandidos pelo printf %b
	printf '%b\n' $(
		zztool multi_stdin "$@" |
		sed 's/%\([0-9A-Fa-f]\{2\}\)/\\x\1/g'
	)

}

# ----------------------------------------------------------------------------
# http://www.poupatempo.sp.gov.br
# Mostra a agenda dos postos Poupatempo Móveis.
# Uso: zzppt
# Ex.: zzppt
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2007-11-30
# Versão: 1.1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2010-12-22 URL funciona, mas não traz datas ou agenda.
zzppt ()
{
	zzzz -h ppt $1 && return

	local URL="http://www.poupatempo.sp.gov.br/posto_movel/unidades.asp?mostrar="

	zztool eco "=== Grande São Paulo I ==="
	$ZZWWWDUMP "$URL"g1 | sed -n '/\([Uu]nidade temporariamente\)/,/[Dd]isque [Pp]oupatempo\:/p ; /\([Dd]e [0-9][0-9] de \)/,/[Dd]isque [Pp]oupatempo\:/p ; /\([Dd]e [0-9][0-9] a \)/,/[Dd]isque [Pp]oupatempo\:/p'

	zztool eco "=== Grande São Paulo II ==="
	$ZZWWWDUMP "$URL"g2 | sed -n '/\([Uu]nidade temporariamente\)/,/[Dd]isque [Pp]oupatempo\:/p ; /\([Dd]e [0-9][0-9] de \)/,/[Dd]isque [Pp]oupatempo\:/p ; /\([Dd]e [0-9][0-9] a \)/,/[Dd]isque [Pp]oupatempo\:/p'

	zztool eco "=== Grande São Paulo III ==="
	$ZZWWWDUMP "$URL"g3 | sed -n '/\([Uu]nidade temporariamente\)/,/[Dd]isque [Pp]oupatempo\:/p ; /\([Dd]e [0-9][0-9] de \)/,/[Dd]isque [Pp]oupatempo\:/p ; /\([Dd]e [0-9][0-9] a \)/,/[Dd]isque [Pp]oupatempo\:/p'

	zztool eco "=== Móvel Interior 1 - Registro ==="
	$ZZWWWDUMP "$URL"i1 | sed -n '/\([Uu]nidade temporariamente\)/,/[Dd]isque [Pp]oupatempo\:/p ; /\([Dd]e [0-9][0-9] de \)/,/[Dd]isque [Pp]oupatempo\:/p ; /\([Dd]e [0-9][0-9] a \)/,/[Dd]isque [Pp]oupatempo\:/p'

	zztool eco "=== Móvel Interior 2 - Sorocaba ==="
	$ZZWWWDUMP "$URL"i2 | sed -n '/\([Uu]nidade temporariamente\)/,/[Dd]isque [Pp]oupatempo\:/p ; /\([Dd]e [0-9][0-9] de \)/,/[Dd]isque [Pp]oupatempo\:/p ; /\([Dd]e [0-9][0-9] a \)/,/[Dd]isque [Pp]oupatempo\:/p'

	zztool eco "=== Móvel Interior 3 - Marília ==="
	$ZZWWWDUMP "$URL"i3 | sed -n '/\([Uu]nidade temporariamente\)/,/[Dd]isque [Pp]oupatempo\:/p ; /\([Dd]e [0-9][0-9] de \)/,/[Dd]isque [Pp]oupatempo\:/p ; /\([Dd]e [0-9][0-9] a \)/,/[Dd]isque [Pp]oupatempo\:/p'

	zztool eco "=== Móvel Interior 4 - Araçatuba ==="
	$ZZWWWDUMP "$URL"i4 | sed -n '/\([Uu]nidade temporariamente\)/,/[Dd]isque [Pp]oupatempo\:/p ; /\([Dd]e [0-9][0-9] de \)/,/[Dd]isque [Pp]oupatempo\:/p ; /\([Dd]e [0-9][0-9] a \)/,/[Dd]isque [Pp]oupatempo\:/p'
}

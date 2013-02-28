# ----------------------------------------------------------------------------
# http://wwwtios.cs.utwente.nl/traduk/
# Dicionário de Esperanto em inglês, português e alemão.
# Possui busca por palavra nas duas direções. O padrão é português-esperanto.
# Uso: zzdicesperanto [idioma] palavra
# Ex.: zzdicesperanto disquete
#      zzdicesperanto EO-PT espero
#
# Autor: Fernando Aires <fernandoaires (a) gmail com>
# Co-Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2005-05-20
# Versão: 3
# Licença: GPL
# Requisitos: zzstr2hexa
# ----------------------------------------------------------------------------
# DESATIVADA: 2013-02-28 Parou de funcionar (issue #54)
zzdicesperanto ()
{
	zzzz -h dicesperanto "$1" && return

	[ "$1" ] || { zztool uso dicesperanto; return 1; }

	local L='PT-EO'
	local I='DE-EO EN-EO EO-DE EO-EN EO-PT PT-EO '
	local pesquisa

	[ "${I% $1 *}" != "$I" ] && L=$1 && shift

	pesquisa="$(zzstr2hexa $1 | tr ' ' '%' | sed 's/%$//;s/^/%/')"

	$ZZWWWDUMP "http://wwwtios.cs.utwente.nl/traduk/$L/Traduku/?$pesquisa" |
		grep -v ^THE_ |
		grep -v ___ |
		grep -v /cxefpagxo\] |
		grep -v Traduku:\ $1
}

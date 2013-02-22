# ----------------------------------------------------------------------------
# http://sourceforge.net
# Ranking das linguagens de programação, pelo núm. de projetos no SourceForge.
# Uso: zzranking
# Ex.: zzranking
#
# Autor: Cesar Gimenes <crgimenes (a) terra com br>
# Desde: 2005-11-03
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2010-12-22 URL não encontrada (404)
zzranking ()
{
	zzzz -h ranking $1 && return

	local URL="http://sourceforge.net/softwaremap/trove_list.php?form_cat=160"

	$ZZWWWDUMP "$URL" |
		grep projects\) |
  		sed -r 's@ {9}(.*)\(([0-9]*) projects\)@\2\t\1@' |
  		sort -r -n |
  		sed -n '1,20p'

	# TODO: Parâmetro para mostrar o ranking completo.
}

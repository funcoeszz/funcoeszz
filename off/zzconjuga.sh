# ----------------------------------------------------------------------------
# http://www.verba.org
# Exibe todas as conjugações de um verbo.
# Uso: zzconjuga verbo
# Ex.: zzconjuga propalar
#
# Autor: Leslie Harlley Watter <leslie (a) watter org>
# Desde: 2003-08-05
# Versão: 2
# Licença: GPL
# Nota: Colaboração de José Inácio Coelho <jinacio (a) yahoo com>
# ----------------------------------------------------------------------------
# DESATIVADA: 2010-12-22 "This domain is for sale." :(
zzconjuga ()
{
	zzzz -h conjuga $1 && return

	[ "$1" ] || { zztool uso conjuga; return; }

	$ZZWWWDUMP "http://www.verba.org/owa-v/verba_dba.verba_pt.select_page?query_verba=$1" |
  		sed '1,/^   Idioma:/d' |
		sed 's/\[[0-9]\{1,\}\]//g' |
		sed '/^Refer/,$d' |
  		sed 's/Tradução// ; s/Definição+Contexto//';
}

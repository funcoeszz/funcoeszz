# ----------------------------------------------------------------------------
# http://finance.yahoo.com
# Busca a cotação de uma ação no Yahoo!.
# Uso: zzystock código
# Ex.: zzystock SCOXQ.PK
#
# Autor: Eustáquio Rangel "TaQ" <eustaquiorangel (a) yahoo com>
# Desde: 2004-11-05
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2010-12-22 URL e dados ok, mas o filtro precisa ser refeito.
zzystock ()
{
	zzzz -h ystock $1 && return

	local URL='http://finance.yahoo.com/q?s='

	[ "$1" ] || { zztool uso ystock; return; }

	$ZZWWWDUMP "$URL$1" | egrep "*\($1\)"
}

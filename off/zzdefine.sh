# ----------------------------------------------------------------------------
# http://www.google.com
# Retorno da função "define:" do Google.
# Idiomas disponíveis: en pt es de fr it. O idioma padrão é "all".
# Uso: zzdefine [idioma] palavra_ou_sigla
# Ex.: zzdefine imho
#      zzdefine pt imho
#
# Autor: Fernando Aires <fernandoaires (a) gmail com>
# Desde: 2005-05-23
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2013-02-28 Parou de funcionar (issue #53)
zzdefine ()
{
	zzzz -h define "$1" && return

	[ "$1" ] || { zztool uso define; return 1; }

	local L='all' I='en pt es de fr it all '

	[ "${I% $1 *}" != "$I" ] && L=$1 && shift

	$ZZWWWDUMP -width=78 "http://www.google.com/search?q=define:$1&hl=pt-br&ie=UTF-8&defl=$L" |
		sed '1, /^ *Web$/ d' |
		sed '/Encontrar definições de imho em:/,$ d' |
		sed '/Página Inicial do Google/,$ d'
}

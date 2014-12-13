# ----------------------------------------------------------------------------
# http://... - vários
# Busca as últimas notícias sobre linux em sites em inglês.
# Obs.: Cada site tem uma letra identificadora que pode ser passada como
#       parâmetro, para informar quais sites você quer pesquisar:
#
#          S)lashDot          Linux T)oday
#          O)S News           Linux W)eekly News
#
# Uso: zzlinuxnews [sites]
# Ex.: zzlinuxnews
#      zzlinuxnews ts
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2002-11-07
# Versão: 4
# Licença: GPL
# Requisitos: zzfeed
# ----------------------------------------------------------------------------
zzlinuxnews ()
{
	zzzz -h linuxnews "$1" && return

	local url limite
	local n=5
	local sites='stwo'

	limite="sed ${n}q"

	[ "$1" ] && sites="$1"

	# Slashdot
	if zztool grep_var s "$sites"
	then
		url='http://rss.slashdot.org/Slashdot/slashdot'
		echo
		zztool eco "* SlashDot ($url):"
		zzfeed -n $n "$url"
	fi

	# Linux Today
	if zztool grep_var t "$sites"
	then
		url='http://linuxtoday.com/backend/biglt.rss'
		echo
		zztool eco "* Linux Today ($url):"
		zzfeed -n $n "$url"
	fi

	# LWN
	if zztool grep_var w "$sites"
	then
		url='http://lwn.net/Articles'
		echo
		zztool eco "* Linux Weekly News - ($url):"
		$ZZWWWHTML "$url" |
			sed '/class="Headline"/!d;s/^ *//;s/<[^>]*>//g' |
			$limite
	fi

	# OS News
	if zztool grep_var o "$sites"
	then
		url='http://www.osnews.com/files/recent.xml'
		echo
		zztool eco "* OS News - ($url):"
		zzfeed -n $n "$url"
	fi
}

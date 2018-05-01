# ----------------------------------------------------------------------------
# Busca as últimas notícias sobre Linux em sites em inglês.
# Obs.: Cada site tem uma letra identificadora que pode ser passada como
#       parâmetro, para informar quais sites você quer pesquisar:
#
#          S)lashDot            Linux T)oday
#          O)S News             Linux W)eekly News
#          Linux I)nsider       Linux N)ews
#          Linux J)ournal       X) LXer Linux News
#
# Uso: zzlinuxnews [sites]
# Ex.: zzlinuxnews
#      zzlinuxnews ts
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2002-11-07
# Versão: 6
# Licença: GPL
# Requisitos: zzfeed
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzlinuxnews ()
{
	zzzz -h linuxnews "$1" && return

	local url limite
	local n=5
	local sites='stwoxijn'

	limite="sed ${n}q"

	test -n "$1" && sites="$1"

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
		url='http://www.linuxtoday.com/backend/biglt.rss'
		echo
		zztool eco "* Linux Today ($url):"
		zzfeed -n $n "$url"
	fi

	# LWN
	if zztool grep_var w "$sites"
	then
		url='http://lwn.net/headlines/newrss'
		echo
		zztool eco "* Linux Weekly News - ($url):"
		zzfeed -n $n "$url"
	fi

	# OS News
	if zztool grep_var o "$sites"
	then
		url='http://www.osnews.com/files/recent.xml'
		echo
		zztool eco "* OS News - ($url):"
		zzfeed -n $n "$url"
	fi

	# LXer Linux News
	if zztool grep_var x "$sites"
	then
		url='http://lxer.com/module/newswire/headlines.rss'
		echo
		zztool eco "*  LXer Linux News- ($url):"
		zzfeed -n $n "$url"
	fi

	# Linux Insider
	if zztool grep_var i "$sites"
	then
		url='http://www.linuxinsider.com/perl/syndication/rssfull.pl'
		echo
		zztool eco "* Linux Insider - ($url):"
		zzfeed -n $n "$url"
	fi

	# Linux Journal
	if zztool grep_var j "$sites"
	then
		url='http://feeds.feedburner.com/linuxjournalcom'
		echo
		zztool eco "* Linux Journal - ($url):"
		zzfeed -n $n "$url"
	fi

	# Linux News
	if zztool grep_var n "$sites"
	then
		url='https://www.linux.com/feeds/all-content'
		echo
		zztool eco "* Linux News - ($url):"
		zzfeed -n $n "$url"
	fi
}

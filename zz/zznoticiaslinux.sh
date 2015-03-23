# ----------------------------------------------------------------------------
# Busca as últimas notícias sobre Linux em sites nacionais.
# Obs.: Cada site tem uma letra identificadora que pode ser passada como
#       parâmetro, para informar quais sites você quer pesquisar:
#
#         B)r Linux            N)otícias linux
#         V)iva o Linux        U)nder linux
#
# Uso: zznoticiaslinux [sites]
# Ex.: zznoticiaslinux
#      zznoticiaslinux yn
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2001-12-17
# Versão: 5
# Licença: GPL
# Requisitos: zzfeed
# ----------------------------------------------------------------------------
zznoticiaslinux ()
{
	zzzz -h noticiaslinux "$1" && return

	local url limite
	local n=5
	local sites='byvucin'

	limite="sed ${n}q"

	test -n "$1" && sites="$1"

	# Viva o Linux
	if zztool grep_var v "$sites"
	then
		url='http://www.vivaolinux.com.br/index.rdf'
		echo
		zztool eco "* Viva o Linux ($url):"
		zzfeed -n $n "$url"
	fi

	# Br Linux
	if zztool grep_var b "$sites"
	then
		url='http://br-linux.org/feed/'
		echo
		zztool eco "* BR-Linux ($url):"
		zzfeed -n $n "$url"
	fi

	# UnderLinux
	if zztool grep_var u "$sites"
	then
		url='https://under-linux.org/external.php?do=rss&type=newcontent'
		echo
		zztool eco "* UnderLinux ($url):"
		zzfeed -n $n "$url"
	fi

	# Notícias Linux
	if zztool grep_var n "$sites"
	then
		url='http://feeds.feedburner.com/NoticiasLinux'
		echo
		zztool eco "* Notícias Linux ($url):"
		zzfeed -n $n "$url"
	fi
}

# ----------------------------------------------------------------------------
# Busca as últimas notícias sobre Linux em sites nacionais.
# Obs.: Cada site tem uma letra identificadora que pode ser passada como
#       parâmetro, para informar quais sites você quer pesquisar:
#
#         B)r Linux            D)iolinux
#         V)iva o Linux        U)nder linux
#         E)spírito Livre
#
# Uso: zznoticiaslinux [sites]
# Ex.: zznoticiaslinux
#      zznoticiaslinux bv
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2001-12-17
# Versão: 10
# Licença: GPL
# Requisitos: zzfeed
# ----------------------------------------------------------------------------
zznoticiaslinux ()
{
	zzzz -h noticiaslinux "$1" && return

	local url limite
	local n=5
	local sites='bdvue'

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
		url='https://under-linux.org/external.php?do=rss&type=newcontent&sectionid=1&days=120'
		echo
		zztool eco "* UnderLinux ($url):"
		zzfeed -n $n "$url"
	fi

	# Diolinux
	if zztool grep_var d "$sites"
	then
		url='http://www.diolinux.com.br/feeds/posts/default/'
		echo
		zztool eco "* Diolinux ($url):"
		zzfeed -n $n "$url"
	fi

	# Espírito Livre
	if zztool grep_var e "$sites"
	then
		url='http://www.revista.espiritolivre.org/feed/'
		echo
		zztool eco "* Espírito Livre ($url):"
		zzfeed -n $n "$url"
	fi

}

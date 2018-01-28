# ----------------------------------------------------------------------------
# Busca as últimas notícias sobre Linux em sites nacionais.
# Obs.: Cada site tem uma letra identificadora que pode ser passada como
#       parâmetro, para informar quais sites você quer pesquisar:
#
#         B) Br-Linux             C) Canal Tech
#         D) Diolinux             L) Linux Descomplicado
#         Z) Linuxbuzz
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
	local sites='bcdlz'

	limite="sed ${n}q"

	test -n "$1" && sites="$1"

	# Br Linux
	if zztool grep_var b "$sites"
	then
		url='http://br-linux.org/feed/'
		echo
		zztool eco "* BR-Linux ($url):"
		zzfeed -n $n "$url"
	fi

	# Canal Tech
	if zztool grep_var c "$sites"
	then
		url='https://canaltech.com.br/rss/linux/'
		echo
		zztool eco "* Canal Tech ($url):"
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

	# Linux Descomplicado
	if zztool grep_var l "$sites"
	then
		url='https://www.linuxdescomplicado.com.br/category/noticias/feed'
		echo
		zztool eco "* Linux Descomplicado ($url):"
		zzfeed -n $n "$url"
	fi

	# Linuxbuzz
	if zztool grep_var z "$sites"
	then
		url='http://www.linuxbuzz.com.br/feeds/posts/default?alt=rss'
		echo
		zztool eco "* Linuxbuzz ($url):"
		zzfeed -n $n "$url"
	fi
}

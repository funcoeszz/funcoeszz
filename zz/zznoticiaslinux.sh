# ----------------------------------------------------------------------------
# http://... - vários
# Busca as últimas notícias sobre Linux em sites nacionais.
# Obs.: Cada site tem uma letra identificadora que pode ser passada como
#       parâmetro, para informar quais sites você quer pesquisar:
#
#         Y)ahoo Linux         B)r Linux
#         V)iva o Linux        U)nder linux
#         N)otícias linux
#
# Uso: zznoticiaslinux [sites]
# Ex.: zznoticiaslinux
#      zznoticiaslinux yn
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2001-12-17
# Versão: 3
# Licença: GPL
# Requisitos: zzfeed zzxml
# ----------------------------------------------------------------------------
zznoticiaslinux ()
{
	zzzz -h noticiaslinux "$1" && return

	local url limite
	local n=5
	local sites='byvucin'

	limite="sed ${n}q"

	[ "$1" ] && sites="$1"

	# Yahoo
	if zztool grep_var y "$sites"
	then
		url='http://br.noticias.yahoo.com/rss/linux'
		echo
		zztool eco "* Yahoo Linux ($url):"
		zzfeed -n $n "$url"
	fi

	# Viva o Linux
	if zztool grep_var v "$sites"
	then
		url='http://www.vivaolinux.com.br'
		echo
		zztool eco "* Viva o Linux ($url):"

		$ZZWWWHTML "$url/index.rdf" |
			zztool texto_em_iso |
			zzxml --tag title --untag --unescape |
			sed '1,2 d' |
			$limite
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
		$ZZWWWHTML "$url" |
			zztool texto_em_iso |
			zzxml --tag title --untag --unescape |
			sed 1d |
			$limite
	fi
}

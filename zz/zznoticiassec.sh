# ----------------------------------------------------------------------------
# Busca as últimas notícias em sites especializados em segurança.
# Obs.: Cada site tem uma letra identificadora que pode ser passada como
#       parâmetro, para informar quais sites você quer pesquisar:
#
#       C)ERT/CC            Linux T)oday - Security
#       Linux S)ecurity     Security F)ocus
#
# Uso: zznoticiassec [sites]
# Ex.: zznoticiassec
#      zznoticiassec cft
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2003-07-13
# Versão: 4
# Licença: GPL
# Requisitos: zzfeed
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zznoticiassec ()
{
	zzzz -h noticiassec "$1" && return

	local url limite
	local n=5
	local sites='sctf'

	limite="sed ${n}q"

	test -n "$1" && sites="$1"

	# Linux Security
	if zztool grep_var s "$sites"
	then
		url='http://www.linuxsecurity.com/linuxsecurity_advisories.rdf'
		echo
		zztool eco "* Linux Security ($url):"
		zzfeed -n $n "$url"
	fi

	# CERT/CC
	if zztool grep_var c "$sites"
	then
		url='http://www.us-cert.gov/channels/techalerts.rdf'
		echo
		zztool eco "* CERT/CC ($url):"
		zzfeed -n $n "$url"
	fi

	# Linux Today - Security
	if zztool grep_var t "$sites"
	then
		url='http://feeds.feedburner.com/linuxtoday/linux/'
		echo
		zztool eco "* Linux Today - Security ($url):"
		zzfeed -n $n "$url"
	fi

	# Security Focus
	if zztool grep_var f "$sites"
	then
		url='http://www.securityfocus.com/bid/'
		echo
		zztool eco "* SecurityFocus Vulns Archive ($url):"
		zztool dump "$url" |
			sed -n '
				/^ *\([0-9]\{4\}-[0-9][0-9]-[0-9][0-9]\)/ {
					G
					s/^ *//
					s/\n//p
				}
				h' |
			$limite
	fi
}

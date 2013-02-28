# ----------------------------------------------------------------------------
# http://... - vários
# Mostra os últimos 5 avisos de segurança de sistemas de Linux/UNIX.
# Suportados: Debian FreeBSD Gentoo Mandriva Slackware Suse Ubuntu.
# Uso: zzsecurity [distros]
# Ex.: zzsecutiry
#      zzsecurity mandriva
#      zzsecurity debian gentoo
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2004-12-23
# Versão: 5
# Licença: GPL
# Requisitos: zzminusculas zzxml zzfeed
# ----------------------------------------------------------------------------
zzsecurity ()
{
	zzzz -h security "$1" && return

	local url limite distros
	local n=5
	local ano=$(date '+%Y')
	local distros='debian freebsd gentoo mandriva slackware suse ubuntu'

	limite="sed ${n}q"

	[ "$1" ] && distros=$(echo $* | zzminusculas)

	# Debian
	if zztool grep_var debian "$distros"
	then
		url='http://www.debian.org'
		echo
		zztool eco '** Atualizações Debian woody'
		echo "$url"
		$ZZWWWDUMP "$url" |
			sed -n '
				/Security Advisories/,/_______/ {
					/\[[0-9]/ s/^ *//p
				}' |
			$limite
	fi

	# Slackware
	if zztool grep_var slackware "$distros"
	then
		echo
		zztool eco '** Atualizações Slackware'
		url="http://www.slackware.com/security/list.php?l=slackware-security&y=$ano"
		echo "$url"
		$ZZWWWDUMP "$url" |
			sed '
				/[0-9]\{4\}-[0-9][0-9]/!d
				s/\[sla.*ty\]//
				s/^  *//' |
			$limite
	fi

	# Gentoo
	if zztool grep_var gentoo "$distros"
	then
		echo
		zztool eco '** Atualizações Gentoo'
		url='http://www.gentoo.org/security/en/index.xml'
		echo "$url"
		$ZZWWWDUMP "$url" |
			sed -n '
				s/^  *//
				/^GLSA/, /^$/ !d
				/[0-9]\{4\}/ {
					s/\([-0-9]* \) *[a-zA-Z]* *\(.*[^ ]\)  *[0-9][0-9]* *$/\1\2/
					p
				}' |
			$limite
	fi

	# Mandriva
	if zztool grep_var mandriva "$distros"
	then
		echo
		zztool eco '** Atualizações Mandriva'
		url='http://www.mandriva.com/en/support/security/advisories/feed/'
		echo "$url"
		zzfeed -n $n "$url"
	fi

	# Suse
	if zztool grep_var suse "$distros"
	then
		echo
		zztool eco '** Atualizações Suse'
		url='https://www.suse.com/support/update/'
		echo "$url"
		$ZZWWWDUMP "$url" |
			grep 'SUSE-SU' |
			sed 's/\(.*\) \([A-Z].. .., ....\)$/\2\1/ ; s/  *$//' |
			$limite
	fi

	# FreeBSD
	if zztool grep_var freebsd "$distros"
	then
		echo
		zztool eco '** Atualizações FreeBSD'
		url='http://www.freebsd.org/security/advisories.rdf'
		echo "$url"
		$ZZWWWDUMP "$url" |
			zzxml --tag title --untag --unescape |
			sed 1d |
			$limite
	fi

	# Ubuntu
	if zztool grep_var ubuntu "$distros"
	then
		url='http://www.ubuntu.com/usn/rss.xml'
		echo
		zztool eco '** Atualizações Ubuntu'
		echo "$url"
		zzfeed -n $n "$url"
	fi
}

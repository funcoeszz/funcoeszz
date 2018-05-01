# ----------------------------------------------------------------------------
# Mostra os últimos 5 avisos de segurança de sistemas de Linux/UNIX.
# Suportados:
#  Debian, Ubuntu, FreeBSD, NetBSD, Gentoo, Arch, Mageia,
#  Slackware, Suse, OpenSuse, Fedora.
# Uso: zzsecurity [distros]
# Ex.: zzsecurity
#      zzsecurity mageia
#      zzsecurity debian gentoo
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2004-12-23
# Versão: 12
# Licença: GPL
# Requisitos: zzminusculas zzfeed zztac zzdata zzdatafmt
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzsecurity ()
{
	zzzz -h security "$1" && return

	local url limite distros
	local n=5
	local ano=$(date '+%Y')
	local distros='debian freebsd gentoo slackware suse opensuse ubuntu arch mageia netbsd fedora'

	limite="sed ${n}q"

	test -n "$1" && distros=$(echo $* | zzminusculas)

	# Debian
	if zztool grep_var debian "$distros"
	then
		url='http://www.debian.org'
		echo
		zztool eco '** Atualizações Debian'
		echo "$url"
		zztool dump "$url" |
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
		zztool dump "$url" |
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
		zztool dump "$url" |
			sed -n '
				s/^  *//
				/^GLSA/, /^$/ !d
				/[0-9]\{4\}/ {
					s/\([-0-9]* \) *[a-zA-Z]* *\(.*[^ ]\)  *[0-9][0-9]* *$/\1\2/
					p
				}' |
			$limite
	fi

	# Suse
	if zztool grep_var suse "$distros" || zztool grep_var opensuse "$distros"
	then
		echo
		zztool eco '** Atualizações Suse'
		url='https://www.suse.com/support/update/'
		echo "$url"
		zztool dump "$url" |
			grep 'SUSE-SU' |
			sed 's/^.*\(SUSE-SU\)/ \1/;s/\(.*\) \([A-Z].. .., ....\)$/\2\1/ ; s/  *$//' |
			$limite

		echo
		zztool eco '** Atualizações Opensuse'
		url="http://lists.opensuse.org/opensuse-updates/$(zzdata hoje - 1m | zzdatafmt -f AAAA-MM) http://lists.opensuse.org/opensuse-updates/$(zzdatafmt -f AAAA-MM hoje)"
		echo "$url"
		zztool dump $url |
			grep 'SUSE-SU' |
			sed 's/^ *\* //;s/ [0-9][0-9]:[0-9][0-9]:[0-9][0-9] GMT/,/;s/  *$//' |
			zztac |
			$limite
	fi

	# FreeBSD
	if zztool grep_var freebsd "$distros"
	then
		echo
		zztool eco '** Atualizações FreeBSD'
		url='http://www.freebsd.org/security/advisories.rdf'
		echo "$url"
		zzfeed -n $n "$url"
	fi

	# NetBSD
	if zztool grep_var netbsd "$distros"
	then
		echo
		zztool eco '** Atualizações NetBSD'
		url='http://ftp.netbsd.org/pub/NetBSD/packages/vulns/pkg-vulnerabilities'
		echo "$url"
		zztool dump "$url" |
			sed '1,27d;/#CHECKSUM /,$d;s/ *https*:.*//' |
			zztac |
			$limite
	fi

	# Ubuntu
	if zztool grep_var ubuntu "$distros"
	then
		url='https://usn.ubuntu.com/rss.xml'
		echo
		zztool eco '** Atualizações Ubuntu'
		echo "$url"
		zzfeed -n $n "$url"
	fi

	# Fedora
	if zztool grep_var fedora "$distros"
	then
		echo
		zztool eco '** Atualizações Fedora'
		url='http://lwn.net/Alerts/Fedora/'
		echo "$url"
		zztool dump "$url" |
			grep 'FEDORA-' |
			sed 's/^ *//' |
			$limite
	fi

	# Arch
	if zztool grep_var arch "$distros"
	then
		url="https://security.archlinux.org/"
		echo
		zztool eco '** Atualizações Archlinux'
		echo "$url"
		zztool dump "$url" |
			awk '/ AVG-/{++i;print"";sub(/^ */,"")};i>=6{exit}i;' |
			sed '/AVG.* CVE/ {s/ CVE/\n   CVE/}'
	fi
}

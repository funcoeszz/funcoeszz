# ----------------------------------------------------------------------------
# http://rpmfind.net/linux
# Procura por pacotes RPM em várias distribuições de Linux.
# Obs.: A arquitetura padrão de procura é a i386.
# Uso: zzrpmfind pacote [distro] [arquitetura]
# Ex.: zzrpmfind sed
#      zzrpmfind lilo mandr i586
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2002-02-22
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzrpmfind ()
{
	zzzz -h rpmfind "$1" && return

	local url='http://rpmfind.net/linux/rpm2html/search.php'
	local pacote=$1
	local distro=$2
	local arquitetura=${3:-i386}

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso rpmfind; return 1; }

	# Faz a consulta e filtra o resultado
	zztool eco 'ftp://rpmfind.net/linux/'
	$ZZWWWLIST "$url?query=$pacote&submit=Search+...&system=$distro&arch=$arquitetura" |
		sed -n '/ftp:\/\/rpmfind/ s@^[^A-Z]*/linux/@  @p' |
		sort
}

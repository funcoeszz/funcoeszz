# ----------------------------------------------------------------------------
# Mostra o seu número IP (externo) na Internet.
# Uso: zzipinternet
# Ex.: zzipinternet
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2005-09-01
# Versão: 6
# Licença: GPL
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzipinternet ()
{
	zzzz -h ipinternet "$1" && return

	local url='http://ipaddress.com/'

	# O resultado já vem pronto!
	zztool source "$url" | sed -n '/My IPv4 Address/{s/<[^>]*>//g;s/.*ss//;p;}'
}

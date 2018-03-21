# ----------------------------------------------------------------------------
# Mostra o seu número IP (externo) na Internet.
# Uso: zzipinternet
# Ex.: zzipinternet
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2005-09-01
# Versão: 5
# Licença: GPL
# ----------------------------------------------------------------------------
zzipinternet ()
{
	zzzz -h ipinternet "$1" && return

	local url='http://ipaddress.com/'

	# O resultado já vem pronto!
	zztool dump "$url" | sed -n 's/.*Your IP .ddress is: //p'
}

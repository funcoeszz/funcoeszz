# ----------------------------------------------------------------------------
# http://www.getip.com
# Mostra o seu número IP (externo) na Internet.
# Uso: zzipinternet
# Ex.: zzipinternet
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2005-09-01
# Versão: 4
# Licença: GPL
# ----------------------------------------------------------------------------
zzipinternet ()
{
	zzzz -h ipinternet "$1" && return

	local url='http://www.getip.com'

	# O resultado já vem pronto!
	$ZZWWWDUMP "$url" | sed -n 's/^Current IP: //p'
}

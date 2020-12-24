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

	# O resultado já vem pronto!
	zztool source 'http://api.ipaddress.com/myip' | zztool nl_eof
}

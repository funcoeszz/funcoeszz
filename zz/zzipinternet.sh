# ----------------------------------------------------------------------------
# Mostra o seu número IP (externo) na Internet.
# Com argumento '-6' mostra o IPv6 externo.
# Uso: zzipinternet [-6]
# Ex.: zzipinternet
#      zzipinternet -6
#
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2005-09-01
# Versão: 7
# Requisitos: zzzz zztool
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzipinternet ()
{
	zzzz -h ipinternet "$1" && return

	# Verifica parametro para ipv6
	if test 'x-6' = "x$1" 
	then
		# Retorna IPv6
		zztool source 'https://api64.ipify.org' | zztool nl_eof
	else
		# Retorna IPv4
		# O resultado já vem pronto!
		zztool source 'http://api.ipaddress.com/myip' | zztool nl_eof
	fi
}

# ----------------------------------------------------------------------------
# Mostra os MAC address disponíveis.
# Uso: zzmacaddress
# Ex.: zzmacaddress
#
# Autor: Adriano Laureano, @sl4ureano
# Desde: 2018-10-09
# Versão: 2
# Requisitos: zzzz zztool
# Tags: sistema, consulta
# Nota: (ou) ip ifconfig
# ----------------------------------------------------------------------------
zzmacaddress ()
{
	zzzz -h macaddress "$1" && return

	if which ifconfig 1>/dev/null 2>&1
	then
		ifconfig | sed -n '/ HW\|ether /{s/.*\(\([0-9A-Fa-f]\{2\}:\)\{5\}[0-9A-Fa-f]\{2\}\).*/\1/;p;}'
	elif which ip 1>/dev/null 2>&1
	then
		ip address | awk '/ether/ {print $2}'
	else
		zztool erro "Necessário instalar ip ou ifconfig."
		return 1
	fi
}

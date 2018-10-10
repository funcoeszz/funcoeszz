# ----------------------------------------------------------------------------
# Mostra os MAC address disponiveis.
# Uso: zzmacaddress
# Ex.: zzmacaddress
#
# Autor: Adriano Laureano, @sl4ureano
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzmacaddress()
{
	zzzz -h macaddress "$1" && return

	ifconfig | awk '/ HW|ether / { match($0,"([0-9a-f]{2}:){5}[0-9a-f]{2}"); print substr($0,RSTART, RLENGTH) }'
}

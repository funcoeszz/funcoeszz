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
    ifconfig | awk '/ HW|ether / { print $NF }'
    
}

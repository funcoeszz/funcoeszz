# ----------------------------------------------------------------------------
# Mostra os MAC address disponiveis.
# Uso: zzmacadress
# Ex.: zzmacadress
#
# Autor: Adriano Laureano, @sl4ureano
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzmacadress()
{
    zzzz -h macadress "$1" && return

    local MAC=$(ifconfig -a | grep -Po 'HWaddr \K.*$')
    echo "$MAC"
    
}

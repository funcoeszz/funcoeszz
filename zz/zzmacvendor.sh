# ----------------------------------------------------------------------------
# zzmacvendor
# Mostra o fabricante do equipamento utilizando o endereço MAC
# Uso: zzmacvendor [MAC Address]
# Ex.: zzmacvendor 88:5A:92:C7:41:40
#      zzmacvendor 88-5A-92-C7-41-40
#
# Autor: Rafael S. Guimaraes, www.rafaelguimaraes.net
# Desde: 2016-02-03
# Versão: 1
# Licença: GPL
# Tags: data
# ----------------------------------------------------------------------------
zzmacvendor ()
{
        zzzz -h macvendor "$1" && return

        local mac="$1"
        # Validação
        zztool -e testa_mac $mac || return 1

        local url="http://www.macvendorlookup.com/api/v2/$mac/pipe"
        $ZZWWWDUMP "$url" |
        awk -F "|" '{printf "%18s %15s %15s\n", $5, $8, $9}'
}

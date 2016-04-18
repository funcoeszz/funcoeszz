# ----------------------------------------------------------------------------
# Mostra o fabricante do equipamento utilizando o endereço MAC.
#
# Uso: zzmacvendor <MAC Address>
# Ex.: zzmacvendor 88:5A:92:C7:41:40
#      zzmacvendor 88-5A-92-C7-41-40
#
# Autor: Rafael S. Guimaraes, www.rafaelguimaraes.net
# Desde: 2016-02-03
# Versão: 1
# Licença: GPL
# Requisitos: zztestar zztrim
# ----------------------------------------------------------------------------
zzmacvendor ()
{
	zzzz -h macvendor "$1" && return

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso macvendor; return 1; }

	local mac="$1"

	# Validação
	zztestar mac "$mac" || return 1

	local url="http://www.macvendorlookup.com/api/v2/$mac/pipe"
	zztool dump "$url" |
	awk -F "|" '{printf "%18s - %15s - %15s\n", $5, $8, $9}' |
	zztrim -l | tr -s ' '
}

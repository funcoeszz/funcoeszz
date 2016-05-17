# ----------------------------------------------------------------------------
# Mostra o fabricante do equipamento utilizando o endereço MAC.
#
# Uso: zzmacvendor <MAC Address>
# Ex.: zzmacvendor 88:5A:92:C7:41:40
#      zzmacvendor 88-5A-92-C7-41-40
#
# Autor: Rafael S. Guimaraes, www.rafaelguimaraes.net
# Desde: 2016-02-03
# Versão: 2
# Licença: GPL
# Requisitos: zztestar
# ----------------------------------------------------------------------------
zzmacvendor ()
{
	zzzz -h macvendor "$1" && return

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso macvendor; return 1; }

	local mac="$1"

	# Validação
	zztestar mac "$mac" || return 1

	mac=$(echo "$mac"  | tr -d ':-' | sed 's/^\(....\)\(....\)/\1\.\2\./')

	local url="http://www.macvendorlookup.com/api/v2/$mac/pipe"
	zztool dump "$url" |
	tr -s ' ' |
	awk -F "|" '{
		print "Fabricante: " $5
		print "Endereço:   " $8
		print "País:       " $9
	}'
}

# ----------------------------------------------------------------------------
# Mostra o fabricante do equipamento utilizando o endereço MAC.
#
# Uso: zzmacvendor <MAC Address>
# Ex.: zzmacvendor 88:5A:92:C7:41:40
#      zzmacvendor 88-5A-92-C7-41-40
#
# Autor: Rafael S. Guimaraes, www.rafaelguimaraes.net
# Desde: 2016-02-03
# Versão: 3
# Licença: GPL
# Requisitos: zztestar zzcut zzdominiopais
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzmacvendor ()
{
	zzzz -h macvendor "$1" && return

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso macvendor; return 1; }

	local mac="$1"
	local fab end pais linha

	# Validação
	zztestar -e mac "$mac" || return 1

	mac=$(echo "$mac"  | tr -d ':-')

	local url="https://macvendors.co/api/$mac/pipe"
	zztool source "$url" |
	tr -s ' "' '  ' |
	zzcut -f 1,3,6 -d "|" | tr '|' '\n' |
	sed '2{s/,[^,]*$//;}' |
	while read linha
	do
		if test -z "$fab"
		then
			fab="$linha"
			echo 'Fabricante:' $fab
			continue
		fi
		if test -z "$end"
		then
			end="$linha"
			echo 'Endereço:  ' $end
			continue
		fi
		if test -z "$pais"
		then
			pais="$linha"
			echo 'País:      ' $(zzdominiopais ".$pais" | sed 's/.*- //')
		fi
	done
}

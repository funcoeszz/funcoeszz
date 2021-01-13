# ----------------------------------------------------------------------------
# Consulta os endereços de rede a partir do IPv6 e do comprimento do prefixo.
# Obs.: Se não especificado, será usado o comprimento do prefixo de 64.
#       O comprimento do prefixo é um número entre 1 e 128.
#
# Uso: zzipv6 IPv6 [subnet]
# Ex.: zzipv6 fe80::4fae:e655:afc3:7d20 56
#      zzipv6 fe80:3cde:7d20:e655::afc3:/127
#      zzipv6 4fae:afc3:0:0:fe80:e655:3cde:7d20
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2021-01-13
# Versão: 1
# Licença: GPL
# Requisitos: zzjuntalinhas zztestar zzxml
# Tags: internet, ip
# ----------------------------------------------------------------------------
zzipv6 ()
{
	zzzz -h ipv6 "$1" && return

	# Verificação dos parâmetros
	test $# -eq 0 -o $# -gt 2 && { zztool -e uso ipv6; return 1; }

	local ipv6
	local subnet=64
	local url='https://www.calculator.net/ip-subnet-calculator.html'

	# Obtém ipv6 e subnet
	if zztool grep_var / "$1"
	then
		ipv6="${1%/*}"
		subnet="${1#*/}"
	else
		ipv6="$1"
		test $# -gt 1 && subnet="$2"
	fi

	# Validando ipv6
	zztestar ipv6 "$ipv6" || { zztool -e uso ipv6; return 1; }
	# Terminando ou começando com :: acrescenta um 0
	ipv6=$(echo "$ipv6" | sed 's/^::/0&/; s/::$/&0/')

	# Validando subnet
	zztestar numero $subnet || { zztool -e uso ipv6; return 1; }
	test $subnet -gt 0 -a $subnet -le 128 || { zztool -e uso ipv6; return 1; }

	# Consultando
	curl -L -s "${url}?c6subnet=${subnet}&c6ip=${ipv6}&ctype=ipv6&printit=0&x=54&y=18" |
		zzxml --tidy |
		sed -n '/IPv6 Subnet Calculator/,/<form /p' |
		zzxml --tag 'tr' |
		zzjuntalinhas -i '<td' -f 'td>' -d '' |
		zzjuntalinhas -i '<tr' -f 'tr>' -d '|' |
		zzxml --untag |
		awk -F '|' '{ gsub(/,/,"."); printf "%-19s %s\n", $2, $4 }'
}

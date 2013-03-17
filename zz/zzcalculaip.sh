# ----------------------------------------------------------------------------
# Calcula os endereços de rede e broadcast à partir do IP e máscara da rede.
# Obs.: Se não especificada, será usada a máscara padrão (RFC 1918) ou 24.
# Uso: zzcalculaip ip [netmask]
# Ex.: zzcalculaip 127.0.0.1 24
#      zzcalculaip 10.0.0.0/8
#      zzcalculaip 192.168.10.0 255.255.255.240
#      zzcalculaip 10.10.10.0
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2005-09-01
# Versão: 2
# Licença: GPL
# Requisitos: zzconverte
# ----------------------------------------------------------------------------
zzcalculaip ()
{
	zzzz -h calculaip "$1" && return

	local endereco mascara rede broadcast
	local mascara_binario mascara_decimal mascara_ip
	local i ip1 ip2 ip3 ip4 nm1 nm2 nm3 nm4 componente

	# Verificação dos parâmetros
	[ $# -eq 0 -o $# -gt 2 ] && { zztool uso calculaip; return 1; }

	# Obtém a máscara da rede (netmask)
	if zztool grep_var / "$1"
	then
		endereco=${1%/*}
		mascara="${1#*/}"
	else
		endereco=$1

		# Use a máscara informada pelo usuário ou a máscara padrão
		if [ $# -gt 1 ]
		then
			mascara=$2
		else
			# A máscara padrão é determinada pela RFC 1918 (valeu jonerworm)
			# http://tools.ietf.org/html/rfc1918
			#
			#   10.0.0.0    - 10.255.255.255  (10/8 prefix)
			#   172.16.0.0  - 172.31.255.255  (172.16/12 prefix)
			#   192.168.0.0 - 192.168.255.255 (192.168/16 prefix)
			#
			case "$1" in
				10.*        ) mascara=8  ;;
				172.1[6-9].*) mascara=12 ;;
				172.2?.*    ) mascara=12 ;;
				172.3[01].* ) mascara=12 ;;
				192.168.*   ) mascara=16 ;;
				127.*       ) mascara=8  ;;
				*           ) mascara=24 ;;
			esac
		fi
	fi

	# Verificações básicas
	if ! (
		zztool testa_ip $mascara || (
		zztool testa_numero $mascara && test $mascara -le 32))
	then
		echo "Máscara inválida: $mascara"
		return 1
	fi
	zztool -e testa_ip $endereco || return 1

	# Guarda os componentes da máscara em $1, $2, ...
	# Ou é um ou quatro componentes: 24 ou 255.255.255.0
	set - $(echo $mascara | tr . ' ')

	# Máscara no formato NN
	if [ $# -eq 1 ]
	then
		# Converte de decimal para binário
		# Coloca N números 1 grudados '1111111' (N=$1)
		# e completa com zeros à direita até 32, com pontos:
		# $1=12 vira 11111111.11110000.00000000.00000000
		mascara=$(printf "%$1s" 1 | tr ' ' 1)
		mascara=$(
			printf '%-32s' $mascara |
			tr ' ' 0 |
			sed 's/./&./24 ; s/./&./16 ; s/./&./8'
		)
	fi

	# Conversão de decimal para binário nos componentes do IP e netmask
	for i in 1 2 3 4
	do
		componente=$(echo $endereco | cut -d'.' -f $i)
		eval ip$i=$(printf '%08d' $(zzconverte db $componente))

		componente=$(echo $mascara | cut -d'.' -f $i)
		if [ "$2" ]
		then
			eval nm$i=$(printf '%08d' $(zzconverte db $componente))
		else
			eval nm$i=$componente
		fi
	done

	# Uma verificação na máscara depois das conversões
	mascara_binario=$nm1$nm2$nm3$nm4
	if ! (
		zztool testa_binario $mascara_binario &&
		test ${#mascara_binario} -eq 32)
	then
		echo 'Máscara inválida'
		return 1
	fi

	mascara_decimal=$(echo $mascara_binario | tr -d 0)
	mascara_decimal=${#mascara_decimal}
	mascara_ip=$((2#$nm1)).$((2#$nm2)).$((2#$nm3)).$((2#$nm4))

	echo "End. IP  : $endereco"
	echo "Mascara  : $mascara_ip = $mascara_decimal"

	rede=$(( ((2#$ip1$ip2$ip3$ip4)) & ((2#$nm1$nm2$nm3$nm4)) ))
	i=$(echo $nm1$nm2$nm3$nm4 | tr 01 10)
	broadcast=$(($rede | ((2#$i)) ))

	# Cálculo do endereço de rede
	endereco=""
	for i in 1 2 3 4
	do
		ip1=$((rede & 255))
		rede=$((rede >> 8))
		endereco="$ip1.$endereco"
	done

	echo "Rede     : ${endereco%.} / $mascara_decimal"

	# Cálculo do endereço de broadcast
	endereco=''
	for i in 1 2 3 4
	do
		ip1=$((broadcast & 255))
		broadcast=$((broadcast >> 8))
		endereco="$ip1.$endereco"
	done
	echo "Broadcast: ${endereco%.}"
}

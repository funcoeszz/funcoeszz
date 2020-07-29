# ----------------------------------------------------------------------------
# Monitora a utilização dos discos no Linux.
#
# Opções:
#   -n [número]    Quantidade de medições (padrão = 10; contínuo = 0)
#   -t [número]    Mostra apenas os discos mais utilizados
#   -i [segundos]  Intervalo em segundos entre as coletas
#   -d [discos]    Mostra apenas os discos que começam com a string passada
#                  O padrão é 'sd'
#   -o [trwT]      Ordena os discos por:
#                      t (tps)
#                      r (read/s)
#                      w (write/s)
#                      T (total/s = read/s+write/s)
#
# Obs.: Se não for usada a opção -t, é mostrada a soma da utilização
#       de todos os discos.
#
# Uso: zziostat [-t número] [-i segundos] [-d discos] [-o trwT]
# Ex.: zziostat
#      zziostat -n 15
#      zziostat -t 10
#      zziostat -i 5 -o T
#      zziostat -d emcpower
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2015-02-17
# Versão: 2
# Licença: GPL
# Tags: sistema, consulta
# Nota: requer iostat
# ----------------------------------------------------------------------------
zziostat ()
{
	zzzz -h iostat "$1" && return

	which iostat 1>/dev/null 2>&1 || { zztool erro "iostat não instalado"; return 1; }

	local top line cycle tps reads writes totals
	local delay=2
	local orderby='t'
	local disk='sd'
	local iteration=10
	local i=0

	# Opcoes de linha de comando
	while test "${1#-}" != "$1"
	do
		case "$1" in
			-n )
				shift
				iteration=$1
				zztool -e testa_numero $iteration || return 1
				test $iteration -eq 0 && unset iteration
				;;
			-t )
				shift
				top=$1
				zztool -e testa_numero $top || return 1
				;;
			-i )
				shift
				delay=$1
				zztool -e testa_numero $delay || return 1
				;;
			-d )
				shift
				disk=$1
				;;
			-o )
				shift
				orderby=$1
				if ! echo $orderby | grep -qs '^[rwtT]$'
				then
					zztool erro "Opção inválida '$orderby'"
					return 1
				fi
				;;
			* )
				zztool erro "Opção inválida $1"; return 1;;
		esac
		shift
	done

	# Coluna para ordenacao:
	# Device tps MB_read/s MB_wrtn/s MB_read MB_wrtn MB_total/s
	test 't' = "$orderby" && orderby=2
	test 'r' = "$orderby" && orderby=3
	test 'w' = "$orderby" && orderby=4
	test 'T' = "$orderby" && orderby=7

	# Executa o iostat, le a saida e agrupa cada "ciclo de execucao"
	# -d device apenas, -m mostra saida em MB/s
	iostat -d -m $delay $iteration |
	while read line
	do

		# Ignorando o cabeçalho do iostat, localizado nas 2 linhas iniciais
		if test $i -lt 2
		then
			i=$((i + 1))
			continue
		fi

		# faz o append da linha do iostat
		if test -n "$line"
		then
			cycle="$cycle
$line"
		# se for line for vazio, terminou de ler o ciclo de saida do iostat
		# mostra a saida conforme opcoes usadas
		else
			if test -n "$top"
			then
				clear
				date '+%d/%m/%y - %H:%M:%S'
				echo 'Device:            tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn        MB_total/s'
				echo "$cycle" |
					sed -n "/^${disk}[a-zA-Z]\+[[:blank:]]/p" |
					awk '{print $0"         "$3+$4}' |
					sort -k $orderby -r -n |
					head -$top
			else
				cycle=$(echo "$cycle" | sed -n "/^${disk}[a-zA-Z]\+[[:blank:]]/p")
				tps=$(echo "$cycle" | awk '{ sum += $2 } END { print sum }')
				reads=$(echo "$cycle" | awk '{ sum += $3 } END { print sum }')
				writes=$(echo "$cycle" | awk '{ sum += $4 } END { print sum }')
				totals=$(echo $reads $writes | awk '{print $1+$2}')
				echo "$(date '+%d/%m/%y - %H:%M:%S') TPS = $tps; Read = $reads MB/s; Write = $writes MB/s ; Total = $totals MB/s"
			fi

			# zera ciclo
			cycle=''
		fi
	done
}

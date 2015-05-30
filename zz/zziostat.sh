# ----------------------------------------------------------------------------
# zziostat
# Monitora a utilização dos discos para Linux usando o comando iostat
#
# Opções: -t [numero]	Mostra apenas os discos mais utilizados
#         -i [segundos]	Intervalo em segundos entre as coletas
#         -d [discos]	Mostra apenas os discos que comecam a string passada
#                   	O padrao é 'sd'
#         -o [trwT]	Ordena os dicos por:
#                  		t (tps)
#                    		r (read/s)
#                    		w (write/s)
#                    		T (total/s = read/s+write/s)
#
# Obs.: Se não for usada a opção -t, é mostrado a soma da utilização 
#       de todos os dicos
#
# Uso: zziostat [-t numero] [-i segundos] [-d discos] [-o trwT]
# Ex.: zziostat
#      zziostat -t 10
#      zziostat -i 5 -o T
#      zziostat -d emcpower
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2015-02-17
# Versão: 1
# Licença: GPL
# Requisitos: iostat
# ----------------------------------------------------------------------------
zziostat ()
{
	zzzz -h iostat "$1" && return

	local top delay=2 orderby='t' line cycle disk='sd'

	# Opcoes de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-t ) shift; top=$1
			     zztool testa_numero $top || { echo "Número inválido $top"; return 1; }
			     ;;
			-i ) shift; delay=$1
			     zztool testa_numero $delay || { echo "Número inválido $delay"; return 1; }
			     ;;
			-d ) shift; disk=$1
			     ;;
			-o ) shift; orderby=$1
			     if ! echo $orderby | grep -qs '^[rwtT]$'; then
			     	echo "Opção inválida '$orderby'"
				return 1
			     fi
			     ;;
			 * ) echo "Opção inválida $1"; return 1;;
		esac
		shift
	done

	# Coluna para ordenacao:
	# Device tps MB_read/s MB_wrtn/s MB_read MB_wrtn MB_total/s
	[ "$orderby" = "t" ] && orderby=2
	[ "$orderby" = "r" ] && orderby=3
	[ "$orderby" = "w" ] && orderby=4
	[ "$orderby" = "T" ] && orderby=7

	# Executa o iostat, le a saida e agrupa cada "ciclo de execucao"
	while read line; do
		# faz o append da linha do iostat
		if [ "$line" ]; then
			cycle="$cycle
$line"
		# se for line for vazio, terminou de ler o ciclo de saida do iostat
		# mostra a saida conforme opcoes usadas
		else
			if [ "$top" ]; then
				clear
				date '+%d/%m/%y - %H:%M:%S'
				echo 'Device:            tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn        MB_total/s'
				echo "$cycle" |
				    sed -n "/^${disk}[a-zA-Z]\+[[:blank:]]/p" |
				    awk '{print $0"         "$3+$4}' |
				    sort -k $orderby -r -n |
				    head -$top
			else
				local tps reads writes totals
				cycle=$(echo "$cycle" | sed -n "/^${disk}[a-zA-Z]\+[[:blank:]]/p")
				tps=$(echo "$cycle" | awk '{ sum += $2 } END { print sum }')
				reads=$(echo "$cycle" | awk '{ sum += $3 } END { print sum }')
				writes=$(echo "$cycle" | awk '{ sum += $4 } END { print sum }')
				totals=$(echo $reads $writes | awk '{print $1+$2}')
				echo "$(date '+%d/%m/%y - %H:%M:%S') TPS = $tps; Read = $reads MB/s; Write = $writes MB/s ; Total = $totals MB/s"
			fi
			cycle='' # zera ciclo
		fi
	done < <(iostat -d -m $delay) # -d device apenas, -m mostra saida em MB/s
}

# ----------------------------------------------------------------------------
# Mostra um cronômetro regressivo.
# Opções:
#   -n: Os números são ampliados para um formato de 5 linhas e 6 colunas.
#   -x char: Igual a -n, mas os números são compostos pelo caracter "char".
#
# Obs: Máximo de 99 horas.
#
# Uso: zztimer [-n|-x [char]] [[hh:]mm:]ss
# Ex.: zztimer 90         # Cronomêtro regressivo a partir de 1:30
#      zztimer 2:56
#      zztimer -n 1:7:23  # Formato ampliado do número
#      zztimer -x H 65    # Com números feito pela letra 'H'
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2016-01-25
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zztimer ()
{

	zzzz -h timer "$1" && return

	local opt str num

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso timer; return 1; }

	# Opções de exibição dos números
	while test "${1#-}" != "$1"
	do
		case "$1" in
		-n) opt='n'; shift ;;
		-x) opt='s'; str=$(echo "$2" | sed 's/.//2g'); shift; shift ;;
		-*) zztool erro "Opção inválida: $1"; return 1 ;;
		*) break;;
		esac
	done

	# Separando cada elemento de tempo hora, minutos e segundos
	# E ajustando minutos e segundos que extrapolem o limite de 60{min,s}
	set - $(
		echo "$1" |
		awk -F ':' '
		{
			seg  = $NF
			min  = (NF>2?(length($2)?$2:0):(NF==2?(length($1)?$1:0):0))
			hora = (NF>=3?(length($1)?$1:0):0)
			print (hora*(60**2)) + (min*60) + seg
		}'
	)

	if test $1 -lt 360000
	then
		num=$1
	else
		zztool erro "Valor $1 muito elevado."
		return 1
	fi

	while test $num -ge 0
	do
		# Marcando ponto para retorno do cursor
		tput sc

		# Exibindo os números do cronômetro
		echo "$num" |
		awk -v formato="$opt" '
		function formatar(hora,  i, j) {
			numero[0, 1] = numero[0, 5] = " 0000 "; numero[0, 2] = numero[0, 3] = numero[0, 4] = "0    0"
			numero[1, 1] = " 111  "; numero[1, 2] = numero[1, 3] = numero[1, 4] = "  11  "; numero[1, 5] = "111111"
			numero[2, 1] = " 2222 "; numero[2, 2] = "    22"; numero[2, 3] = "   22 "; numero[2, 4] = " 22   "; numero[2, 5] = "222222"
			numero[3, 1] = numero[3, 5] = "33333 "; numero[3, 2] =  numero[3, 4] = "     3"; numero[3, 3] = " 3333 "
			numero[4, 1] = "   44 "; numero[4, 2] = "  4 4 "; numero[4, 3] = " 4  4 "; numero[4, 4] = "444444"; numero[4, 5] = "    4 "
			numero[5, 1] = numero[5, 3] = "55555 "; numero[5, 2] = "5     "; numero[5, 4] = "     5"; numero[5, 5] = " 5555 "
			numero[6, 1] = numero[6, 5] = " 6666 "; numero[6, 2] = "6     "; numero[6, 3] = "66666 "; numero[6, 4] = "6    6"
			numero[7, 1] = "777777"; numero[7, 2] = "    7 "; numero[7, 3] = "   7  "; numero[7, 4] = "  7   "; numero[7, 5] = " 7    "
			numero[8, 1] = numero[8, 3] = numero[8, 5] = " 8888 "; numero[8, 2] = numero[8, 4] = "8    8"
			numero[9, 1] = numero[9, 5] = " 9999 "; numero[9, 2] = "9    9"; numero[9, 3] = " 99999"; numero[9, 4] = "     9"
			numero["x", 1] = numero["x", 3] = numero["x", 5] = "      "; numero["x", 2] = numero["x", 4] = "  #   "
			for (i=1; i<6; i++)
				print numero[substr(hora,1,1), i], numero[substr(hora,2,1), i], numero["x", i], numero[substr(hora,4,1), i], numero[substr(hora,5,1), i], numero["x", i], numero[substr(hora,7,1), i], numero[substr(hora,8,1), i]
		}
		{
			hh = $1/3600
			mm = ($1%3600)/60
			ss = ($1%3600)%60
			if (length(formato)) {
				formatar(sprintf("%02d:%02d:%02d\n", hh, mm, ss))
			}
			else
				printf "%02d:%02d:%02d\n", hh, mm, ss
		}' |
		if test -n "$str"
		then
			sed "s/[0-9#]/$str/g"
		else
			cat -
		fi

		# Temporizar
		sleep 1

		# Decrementar o contador
		num=$((num-1))

		# Reposicionar o cursor
		if test $num -ge 0
		then
			tput rc
			tput el
		fi
	done

}

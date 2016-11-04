# ----------------------------------------------------------------------------
# Mostra um cronômetro regressivo.
# Opções:
#   -n: Os números são ampliados para um formato de 5 linhas e 6 colunas.
#   -x char: Igual a -n, mas os números são compostos pelo caracter "char".
#   -y nums chars: Troca os nums por chars, igual ao comando 'y' no sed.
#      Obs.: nums e chars tem que ter a mesma quantidade de caracteres.
#   -c: Apenas converte o tempo em segundos.
#   -s: Aguarda o tempo como sleep, sem mostrar o cronômetro.
#   -p: Usa uma temporização mais precisa, porém usa mais recursos.
#   --center ou --centro: Mostra o cronomêtro centralizado no terminal.
#   --teste: Desabilita 'tput' e a centralização.
#
# Obs: Máximo de 99 horas.
#
# Uso: zztimer [-c|-s|-n|-x char|-y nums chars] [-p] [[hh:]mm:]ss
# Ex.: zztimer 90           # Cronomêtro regressivo a partir de 1:30
#      zztimer 2:56         # Cronometragem regressiva simples.
#      zztimer -c 2:22      # Exibe o tempo em segundos (no caso 142)
#      zztimer -s 5:34      # Exibe o tempo em segundos e aguarda o tempo.
#      zztimer --centro 20  # Centralizado horizontal e verticalmente
#      zztimer -n 1:7:23    # Formato ampliado do número
#      zztimer -x H 65      # Com números feito pela letra 'H'
#      zztimer -y 0123456789 9876543210 60  # Troca os números
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2016-01-25
# Versão: 4
# Licença: GPL
# ----------------------------------------------------------------------------
zztimer ()
{

	zzzz -h timer "$1" && return

	local opt str num seg char_para centro no_tput
	local prec='s'

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso timer; return 1; }

	# Opções de exibição dos números
	while test "${1#-}" != "$1"
	do
		case "$1" in
		-n) opt='n';  shift ;;
		-x) opt='x';  str=$(echo "$2" | sed 's/\(.\).*/\1/'); shift; shift ;;
		-y)
			opt='x';  str="$2"; char_para="$3";
			if test ${#str} -ne ${#char_para}
			then
				opt='n'
				unset str
				unset char_para
			fi
			shift; shift; shift
		;;
		-c) opt='c';  shift ;;
		-s) opt='s';  shift ;;
		-p) prec='p'; shift ;;
		--center | --centro) centro='1'; shift ;;
		--teste) no_tput='1'; shift ;;
		-*) zztool erro "Opção inválida: $1"; return 1 ;;
		*) break;;
		esac
	done

	echo "$1" | grep '^[0-9:]\{1,\}$' >/dev/null || { zztool erro "Entrada inválida"; return 1; }

	test -n "$no_tput" || unset centro

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
		test "$opt" = "c" && { echo $num; return; }
		test "$opt" = "s" && { echo $1; sleep $num; return; }
	else
		zztool erro "Valor $1 muito elevado."
		return 1
	fi

	# Restaurando terminal
	test -z "$no_tput" && tput reset

	# Centralizar?
	if test -n "$centro" && test -z "$no_tput"
	then
		if test -n "$opt"
		then
			tput cup $(tput lines | awk '{print int(($1 - 5) / 2)}') 0
			centro=$(tput cols | awk '{print int(($1 - 56) / 2)}')
		else
			tput cup $(tput lines | awk '{print int($1 / 2)}') $(tput cols | awk '{print int(($1 - 8) / 2)}')
		fi
	fi

	while test $num -ge 0
	do

		# Definindo segundo atual
		seg=$(date +%S)

		# Marcando ponto para retorno do cursor
		test -z "$no_tput" && tput sc

		# Exibindo os números do cronômetro
		echo "$num" |
		awk -v formato="$opt" -v desl="$centro" '
		function formatar(hora,  i, j, space) {
			space=(length(desl)>0?sprintf("%"desl"s"," "):"")
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
				print space numero[substr(hora,1,1), i], numero[substr(hora,2,1), i], numero["x", i], numero[substr(hora,4,1), i], numero[substr(hora,5,1), i], numero["x", i], numero[substr(hora,7,1), i], numero[substr(hora,8,1), i]
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
			if test "${#char_para}" -gt 0
			then
				sed "y/$str/$char_para/"
			else
				sed "s/[0-9#]/$str/g"
			fi
		else
			cat -
		fi

		# Temporizar ( p = mais preciso / s = usando sleep )
		if test "$prec" = 'p'
		then
			# Mais preciso, mas sobrecarrega o processamento
			while test "$seg" = $(date +%S);do :;done
		else
			# Menos preciso, porém mais leve ( padrão )
			sleep 1
		fi

		# Decrementar o contador
		num=$((num-1))

		# Reposicionar o cursor
		if test $num -ge 0
		then
			test -z "$no_tput" && tput rc
		fi
	done
}

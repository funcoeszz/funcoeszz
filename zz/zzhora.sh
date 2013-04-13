# ----------------------------------------------------------------------------
# Faz cálculos com horários.
# A opção -r torna o cálculo relativo à primeira data, por exemplo:
#   02:00 - 03:30 = -01:30 (sem -r) e 22:30 (com -r)
#
# Uso: zzhora [-r] hh:mm [+|- hh:mm] ...
# Ex.: zzhora 8:30 + 17:25        # preciso somar dois horários
#      zzhora 12:00 - agora       # quando falta para o almoço?
#      zzhora -12:00 + -5:00      # horas negativas!
#      zzhora 1000                # quanto é 1000 minutos?
#      zzhora -r 5:30 - 8:00      # que horas ir dormir para acordar às 5:30?
#      zzhora -r agora + 57:00    # e daqui 57 horas, será quando?
#      zzhora 1:00 + 2:00 + 3:00 - 4:00 - 0:30   # cálculos múltiplos
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-02-22
# Versão: 4
# Licença: GPL
# ----------------------------------------------------------------------------
zzhora ()
{
	zzzz -h hora "$1" && return

	local hhmm1 hhmm2 operacao hhmm1_orig hhmm2_orig
	local hh1 mm1 hh2 mm2 n1 n2 resultado parcial exitcode negativo
	local horas minutos dias horas_do_dia hh mm hh_dia extra
	local relativo=0
	local neg1=0
	local neg2=0

	# Opções de linha de comando
	if [ "$1" = '-r' ]
	then
		relativo=1
		shift
	fi

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso hora; return 1; }

	# Cálculos múltiplos? Exemplo: 1:00 + 2:00 + 3:00 - 4:00
	if test $# -gt 3
	then
		if test $relativo -eq 1
		then
			echo "A opção -r não suporta cálculos múltiplos"
			return 1
		fi

		# A zzhora continua simples, suportando apenas dois números
		# e uma única operação entre eles. O que fiz para suportar
		# múltiplos, é chamar a própria zzhora várias vezes, a cada
		# número novo, usando o resultado do cálculo anterior.
		#
		# Início  : parcial = $1
		# Rodada 1: parcial = zzhora $parcial $2 $3
		# Rodada 2: parcial = zzhora $parcial $4 $5
		# Rodada 3: parcial = zzhora $parcial $6 $7
		# e assim vai.
		#
		parcial="$1"
		shift

		# Daqui pra frente é de dois em dois: operador (+-) e a hora.
		# Se tiver um número ímpar de argumentos, tem algo errado.
		#
		if test $(($# % 2)) -eq 1
		then
			zztool uso hora
			return 1
		fi

		# Agora sim, vamos fazer o loop e calcular todo mundo
		while test $# -ge 2
		do
			resultado=$(zzhora "$parcial" "$1" "$2")
			exitcode=$?

			# Salva somente o horário. Ex: 02:59 (0d 2h 59m)
			parcial=$(echo "$resultado" | cut -d ' ' -f 1)

			# Esses dois já foram. Venham os próximos!
			shift
			shift
		done

		# Loop terminou, então já temos o total final.
		# Basta mostrar e encerrar, saindo com o exitcode retornado
		# pela execução da última zzhora. Vai que deu erro?
		#
		echo "$resultado"
		return $exitcode
	fi

	# Dados informados pelo usuário (com valores padrão)
	hhmm1="$1"
	operacao="${2:-+}"
	hhmm2="${3:-0}"
	hhmm1_orig="$hhmm1"
	hhmm2_orig="$hhmm2"

	# Somente adição e subtração são permitidas
	if test "$operacao" != '-' -a "$operacao" != '+'
	then
		echo "Operação inválida '$operacao'. Deve ser + ou -."
		return 1
	fi

	# Remove possíveis sinais de negativo do início
	hhmm1="${hhmm1#-}"
	hhmm2="${hhmm2#-}"

	# Guarda a informação de quem era negativo no início
	[ "$hhmm1" != "$hhmm1_orig" ] && neg1=1
	[ "$hhmm2" != "$hhmm2_orig" ] && neg2=1

	# Atalhos bacanas para a hora atual
	[ "$hhmm1" = 'agora' -o "$hhmm1" = 'now' ] && hhmm1=$(date +%H:%M)
	[ "$hhmm2" = 'agora' -o "$hhmm2" = 'now' ] && hhmm2=$(date +%H:%M)

	# Se as horas não foram informadas, coloca zero
	[ "${hhmm1#*:}" = "$hhmm1" ] && hhmm1="0:$hhmm1"
	[ "${hhmm2#*:}" = "$hhmm2" ] && hhmm2="0:$hhmm2"

	# Extrai horas e minutos para variáveis separadas
	hh1="${hhmm1%:*}"
	mm1="${hhmm1#*:}"
	hh2="${hhmm2%:*}"
	mm2="${hhmm2#*:}"

	# Retira o zero das horas e minutos menores que 10
	hh1="${hh1#0}"
	mm1="${mm1#0}"
	hh2="${hh2#0}"
	mm2="${mm2#0}"

	# Se tiver algo faltando, salva como zero
	hh1="${hh1:-0}"
	mm1="${mm1:-0}"
	hh2="${hh2:-0}"
	mm2="${mm2:-0}"

	# Validação dos dados
	if ! (zztool testa_numero "$hh1" && zztool testa_numero "$mm1")
	then
		echo "Horário inválido '$hhmm1_orig', deve ser HH:MM"
		return 1
	fi
	if ! (zztool testa_numero "$hh2" && zztool testa_numero "$mm2")
	then
		echo "Horário inválido '$hhmm2_orig', deve ser HH:MM"
		return 1
	fi

	# Os cálculos são feitos utilizando apenas minutos.
	# Então é preciso converter as horas:minutos para somente minutos.
	n1=$((hh1*60 + mm1))
	n2=$((hh2*60 + mm2))

	# Restaura o sinal para as horas negativas
	[ $neg1 -eq 1 ] && n1="-$n1"
	[ $neg2 -eq 1 ] && n2="-$n2"

	# Tudo certo, hora de fazer o cálculo
	resultado=$(($n1 $operacao $n2))

	# Resultado negativo, seta a flag e remove o sinal de menos "-"
	if [ $resultado -lt 0 ]
	then
		negativo='-'
		resultado="${resultado#-}"
	fi

	# Agora é preciso converter o resultado para o formato hh:mm

	horas=$((resultado/60))
	minutos=$((resultado%60))
	dias=$((horas/24))
	horas_do_dia=$((horas%24))

	# Restaura o zero dos minutos/horas menores que 10
	hh="$horas"
	mm="$minutos"
	hh_dia="$horas_do_dia"
	[ $hh -le 9 ] && hh="0$hh"
	[ $mm -le 9 ] && mm="0$mm"
	[ $hh_dia -le 9 ] && hh_dia="0$hh_dia"

	# Decide como mostrar o resultado para o usuário.
	#
	# Relativo:
	#   $ zzhora -r 10:00 + 48:00            $ zzhora -r 12:00 - 13:00
	#   10:00 (2 dias)                       23:00 (ontem)
	#
	# Normal:
	#   $ zzhora 10:00 + 48:00               $ zzhora -r 12:00 - 13:00
	#   58:00 (2d 10h 0m)                    -01:00 (0d 1h 0m)
	#
	if [ $relativo -eq 1 ]
	then

		# Relativo

		# Somente em resultados negativos o relativo é útil.
		# Para valores positivos não é preciso fazer nada.
		if [ "$negativo" ]
		then
			# Para o resultado negativo é preciso refazer algumas contas
			minutos=$(( (60-minutos) % 60))
			dias=$((horas/24 + (minutos>0) ))
			hh_dia=$(( (24 - horas_do_dia - (minutos>0)) % 24))
			mm="$minutos"

			# Zeros para dias e minutos menores que 10
			[ $mm -le 9 ] && mm="0$mm"
			[ $hh_dia -le 9 ] && hh_dia="0$hh_dia"
		fi

		# "Hoje", "amanhã" e "ontem" são simpáticos no resultado
		case $negativo$dias in
			1)
				extra='amanhã'
			;;
			-1)
				extra='ontem'
			;;
			0 | -0)
				extra='hoje'
			;;
			*)
				extra="$negativo$dias dias"
			;;
		esac

		echo "$hh_dia:$mm ($extra)"
	else

		# Normal

		echo "$negativo$hh:$mm (${dias}d ${horas_do_dia}h ${minutos}m)"
	fi
}

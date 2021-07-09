# ----------------------------------------------------------------------------
# Faz cálculos com horários.
# A opção -r torna o cálculo relativo à 0h da data atual, por exemplo:
#   02:00 - 03:30 = -01:30 (sem -r) e 22:30 (ontem: dd/mm/yyyy) (com -r)
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
# Versão: 6
# Requisitos: zzzz zztool
# Tags: tempo, cálculo
# ----------------------------------------------------------------------------
zzhora ()
{
	zzzz -h hora "$1" && return

	local parcial resultado negativo
	local horas minutos dias horas_do_dia hh mm hh_dia extra
	local relativo=0

	# Função auxiliar que normaliza parâmetro de hora e transforma em minutos
	zzhora_minutos_auxiliar() {
		local hhmm="${1:-0}"
		local hhmm_orig="$hhmm"
		local neg=0

		# Remove possíveis sinais de negativo do início
		hhmm="${hhmm#-}"

		# Guarda a informação de se era negativo no início
		test "$hhmm" != "$hhmm_orig" && neg=1

		# Atalhos bacanas para a hora atual
		test "$hhmm" = 'agora' -o "$hhmm" = 'now' && hhmm=$(date +%H:%M)

		# Se as horas não foram informadas, coloca zero
		test "${hhmm#*:}" = "$hhmm" && hhmm="0:$hhmm"

		# Extrai horas e minutos para variáveis separadas
		local hh="${hhmm%:*}"
		local mm="${hhmm#*:}"

		# Retira o zero das horas e minutos menores que 10
		hh="${hh#0}"
		mm="${mm#0}"

		# Se tiver algo faltando, salva como zero
		hh="${hh:-0}"
		mm="${mm:-0}"

		# Validação dos dados
		if ! (zztool testa_numero "$hh" && zztool testa_numero "$mm")
		then
			zztool erro "Horário inválido '$hhmm_orig', deve ser HH:MM"
			return 1
		fi

		# Os cálculos são feitos utilizando apenas minutos.
		local n=$((hh*60 + mm))

		# Restaura o sinal para as horas negativas
		test $neg -eq 1 && n="-$n"

		echo "$n"
	}

	# Função auxiliar que faz a operação de soma/subtração de dois horários,
	# considerando que o primeiro parâmetro é expresso em minutos,
	# e retorna o valor da operação em minutos.
	zzhora_soma_auxiliar() {
		local mm1="$1"
		local operacao="${2:-+}"
		local mm2=$(zzhora_minutos_auxiliar "$3")
		# Se não conseguiu converter parâmetro $3 em minutos, há um erro.
		if test -z $mm2; then
			return 1 
		fi

		# Somente adição e subtração são permitidas
		if test '-' != "$operacao" -a '+' != "$operacao"
		then
			zztool erro "Operação inválida '$operacao'. Deve ser + ou -."
			return 1
		fi
	
		# Tudo certo, hora de fazer o cálculo
		echo $(($mm1 $operacao $mm2))
	}

	# Opções de linha de comando
	if test '-r' = "$1"
	then
		relativo=1
		shift
	fi

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso hora; return 1; }

	# A zzhora continua simples. Para suportar mais de dois números,
	# é chamada uma função auxiliar de soma, com três parametros:
	# o total parcial de minutos, a operação, e um horário.
	# (O parcial inicial é diferente: apenas os minutos do primeiro horário)
	#
	# Início  : parcial = zzhora_minutos_auxiliar $1
	# Rodada 1: parcial = zzhora_soma_auxiliar $parcial $2 $3
	# Rodada 2: parcial = zzhora_soma_auxiliar $parcial $4 $5
	# Rodada 3: parcial = zzhora_soma_auxiliar $parcial $6 $7
	# e assim vai.
	#

	parcial=$(zzhora_minutos_auxiliar "$1")
	if test -z $parcial; then
		return 1
	fi

	shift

	# Se tiver um número ímpar de argumentos restante, tem algo errado.
	if test $(($# % 2)) -eq 1
	then
		zztool -e uso hora
		return 1
	fi

	# Agora sim, vamos fazer o loop e calcular todo mundo
	while test $# -ge 2
	do
		parcial=$(zzhora_soma_auxiliar "$parcial" "$1" "$2")
		if test -z $parcial; then
			return 1
		fi

		# Esses dois já foram. Venham os próximos!
		shift
		shift
	done
	resultado=$parcial

	# Decide como mostrar o resultado para o usuário.
	#
	# Relativo:
	#   $ zzhora -r 10:00 + 48:00                    $ zzhora -r 12:00 - 13:00
	#   10:00 (2 dias: dd/mm/yyyy)                   23:00 (ontem: dd/mm/yyyy)
	#
	# Normal:
	#   $ zzhora 10:00 + 48:00                       $ zzhora 12:00 - 13:00
	#   58:00 (2d 10h 0m)                            -01:00 (0d 1h 0m)
	#
	if test $relativo -eq 1
	then

		local data_atual_0h=$(date '+%Y-%m-%d 00:00:00%Z')
		local data_resultado=$(date -d "$data_atual_0h $resultado"min +'%Y-%m-%d %H:%M:00%Z')
		local data_resultado_0h=$(date -d "$data_resultado" +'%Y-%m-%d 00:00:00%Z')
		# https://stackoverflow.com/a/4946875/152016
		local dias=$((($(date +%s -d "$data_resultado_0h")-$(date +%s -d "$data_atual_0h"))/86400))

		# Relativo
		# "Hoje", "amanhã" e "ontem" são simpáticos no resultado
		case $dias in
			2)
				extra='depois de amanhã'
			;;
			1)
				extra='amanhã'
			;;
			0)
				extra='hoje'
			;;
			-1)
				extra='ontem'
			;;
			-2)
				extra='anteontem'
			;;
			*)
				extra="$dias dias"
			;;
		esac

		echo $(date -d "$data_resultado" "+%H:%M ($extra: %d/%m/%Y)") && return 0
	fi

	# Não-Relativo
	# (agora é preciso converter o resultado para o formato hh:mm)

	# Resultado negativo, seta a flag e remove o sinal de menos "-"
	if test $resultado -lt 0
	then
		negativo='-'
		resultado="${resultado#-}"
	fi

	horas=$((resultado/60))
	minutos=$((resultado%60))
	dias=$((horas/24))
	horas_do_dia=$((horas%24))

	# Restaura o zero dos minutos/horas menores que 10
	hh="$horas"
	mm="$minutos"
	hh_dia="$horas_do_dia"
	test $hh -le 9 && hh="0$hh"
	test $mm -le 9 && mm="0$mm"
	test $hh_dia -le 9 && hh_dia="0$hh_dia"

	unset zzhora_minutos_auxiliar
	unset zzhora_soma_auxiliar
	echo "$negativo$hh:$mm (${dias}d ${horas_do_dia}h ${minutos}m)"
}

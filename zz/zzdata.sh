# ----------------------------------------------------------------------------
# Calculadora de datas, trata corretamente os anos bissextos.
# Você pode somar ou subtrair dias, meses e anos de uma data qualquer.
# Você pode informar a data dd/mm/aaaa ou usar palavras como: hoje, ontem.
# Ou os dias da semana como: domingo, seg, ter, qua, qui, sex, sab, dom.
# Na diferença entre duas datas, o resultado é o número de dias entre elas.
# Se informar somente uma data, converte para número de dias (01/01/1970 = 0).
# Se informar somente um número (de dias), converte de volta para a data.
# Esta função também pode ser usada para validar uma data.
#
# Uso: zzdata [data [+|- data|número<d|m|a>]]
# Ex.: zzdata                           # que dia é hoje?
#      zzdata anteontem                 # que dia foi anteontem?
#      zzdata hoje + 15d                # que dia será daqui 15 dias?
#      zzdata dom                       # que dia será o próximo domingo?
#      zzdata hoje - 40d                # e 40 dias atrás, foi quando?
#      zzdata 31/12/2010 + 100d         # 100 dias após a data informada
#      zzdata 29/02/2001                # data inválida, ano não-bissexto
#      zzdata 29/02/2000 + 1a           # 28/02/2001 <- respeita bissextos
#      zzdata 01/03/2000 - 11/11/1999   # quantos dias há entre as duas?
#      zzdata hoje - 07/10/1977         # quantos dias desde meu nascimento?
#      zzdata 21/12/2012 - hoje         # quantos dias para o fim do mundo?
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2003-02-07
# Versão: 5
# Licença: GPL
# Tags: data, cálculo
# ----------------------------------------------------------------------------
zzdata ()
{
	zzzz -h data "$1" && return

	local yyyy mm dd mmdd i m y op dias_ano dias_mes dias_neste_mes
	local valor operacao quantidade grandeza
	local tipo tipo1 tipo2
	local data data1 data2
	local dias dias1 dias2
	local delta delta1 delta2
	local epoch=1970
	local dias_mes_ok='31 28 31 30 31 30 31 31 30 31 30 31'  # jan-dez
	local dias_mes_rev='31 30 31 30 31 31 30 31 30 31 28 31' # dez-jan
	local valor1="$1"
	local operacao="$2"
	local valor2="$3"

	# Verificação dos parâmetros
	case $# in
		0)
			# Sem argumentos, mostra a data atual
			zzdata hoje
			return
		;;
		1)
			# Delta sozinho é relativo ao dia atual
			case "$1" in
				[0-9]*[dma])
					zzdata hoje + "$1"
					return
				;;
			esac
		;;
		3)
			# Validação rápida
			if test "$operacao" != '-' -a "$operacao" != '+'
			then
				echo "Operação inválida '$operacao'. Deve ser + ou -."
				return 1
			fi
		;;
		*)
			zztool uso data
			return 1
		;;
	esac

	# Validação do conteúdo de $valor1 e $valor2
	# Formato válidos: 31/12/1999, 123, -123, 5d, 5m, 5a, hoje
	#
	# Este bloco é bem importante, pois além de validar os dados
	# do usuário, também povoa as variáveis que serão usadas na
	# tomada de decisão adiante. São elas:
	# $tipo1 $tipo2 $data1 $data2 $dias1 $dias2 $delta1 $delta2
	#
	# Nota: é o eval quem salva estas variáveis.

	for i in 1 2
	do
		# Obtém o conteúdo de $valor1 ou $valor2
		eval "valor=\$valor$i"

		# Cancela se i=2 e só temos um valor
		test -z "$valor" && break

		# Identifica o tipo do valor e faz a validação
		case "$valor" in

			# Data no formato dd/mm/aaaa
			??/??/?*)

				tipo='data'
				yyyy="${valor##*/}"
				ddmm="${valor%/*}"

				# Data em formato válido?
				zztool -e testa_data "$valor" || return 1

				# 29/02 em um ano não-bissexto?
				if test "$ddmm" = '29/02' && ! zztool testa_ano_bissexto "$yyyy"
				then
					echo "Data inválida '$valor', pois $yyyy não é um ano bissexto"
					return 1
				fi
			;;

			# Delta de dias, meses ou anos: 5d, 5m, 5a
			[0-9]*[dma])

				tipo='delta'

				# Validação
				if ! echo "$valor" | grep '^[0-9][0-9]*[dma]$' >/dev/null
				then
					echo "Delta inválido '$valor'. Deve ser algo como 5d, 5m ou 5a."
					return 1
				fi
			;;

			# Número negativo ou positivo
			-[0-9]* | [0-9]*)

				tipo='dias'

				# Validação
				if ! zztool testa_numero_sinal "$valor"
				then
					echo "Número inválido '$valor'"
					return 1
				fi
			;;

			# Apelidos: hoje, ontem, etc
			[a-z]*)

				tipo='data'

				# Converte apelidos em datas
				case "$valor" in
					today | hoje)
						valor=$(date +%d/%m/%Y)
					;;
					yesterday | ontem)
						valor=$(zzdata hoje - 1)
					;;
					anteontem)
						valor=$(zzdata hoje - 2)
					;;
					tomorrow | amanh[aã])
						valor=$(zzdata hoje + 1)
					;;
					dom | domingo)
						valor=$(zzdata hoje + $(echo "7 $(date +%u)" | awk '{ print ($1 >= $2 ? $1 - $2 : 7 + ($1 - $2)) }'))
					;;
					sab | s[aá]bado)
						valor=$(zzdata hoje + $(echo "6 $(date +%u)" | awk '{ print ($1 >= $2 ? $1 - $2 : 7 + ($1 - $2)) }'))
					;;
					sex | sexta)
						valor=$(zzdata hoje + $(echo "5 $(date +%u)" | awk '{ print ($1 >= $2 ? $1 - $2 : 7 + ($1 - $2)) }'))
					;;
					qui | quinta)
						valor=$(zzdata hoje + $(echo "4 $(date +%u)" | awk '{ print ($1 >= $2 ? $1 - $2 : 7 + ($1 - $2)) }'))
					;;
					qua | quarta)
						valor=$(zzdata hoje + $(echo "3 $(date +%u)" | awk '{ print ($1 >= $2 ? $1 - $2 : 7 + ($1 - $2)) }'))
					;;
					ter | ter[cç]a)
						valor=$(zzdata hoje + $(echo "2 $(date +%u)" | awk '{ print ($1 >= $2 ? $1 - $2 : 7 + ($1 - $2)) }'))
					;;
					seg | segunda)
						valor=$(zzdata hoje + $(echo "1 $(date +%u)" | awk '{ print ($1 >= $2 ? $1 - $2 : 7 + ($1 - $2)) }'))
					;;
					fim)
						valor=21/12/2012  # ;)
					;;
					*)
						echo "Data inválida '$valor', deve ser dd/mm/aaaa"
						return 1
				esac

				# Exceção: se este é o único argumento, mostra a data e sai
				if test $# -eq 1
				then
					echo "$valor"
					return 0
				fi
			;;
			*)
				echo "Data inválida '$valor', deve ser dd/mm/aaaa"
				return 1
			;;
		esac

		# Salva as variáveis $data/$dias/$delta e $tipo,
		# todas com os sufixos 1 ou 2 no nome. Por isso o eval.
		# Exemplo: data1=01/01/1970; tipo1=data
		eval "$tipo$i=$valor; tipo$i=$tipo"
	done

	# Validação: Se há um delta, o outro valor deve ser uma data ou número
	if test "$tipo1" = 'delta' -a "$tipo2" = 'delta'
	then
		zztool uso data
		return 1
	fi

	# Se chamada com um único argumento, é uma conversão simples.
	# Se veio uma data, converta para um número.
	# Se veio um número, converta para uma data.
	# E pronto.

	if test $# -eq 1
	then
		case $tipo1 in

			data)
				#############################################################
				### Conversão DATA -> NÚMERO
				#
				# A data dd/mm/aaaa é transformada em um número inteiro.
				# O resultado é o número de dias desde $epoch (01/01/1970).
				# Se a data for anterior a $epoch, o número será negativo.
				# Anos bissextos são tratados corretamente.
				#
				# Exemplos:
				#      30/12/1969 = -2
				#      31/12/1969 = -1
				#      01/01/1970 = 0
				#      02/01/1970 = 1
				#      03/01/1970 = 2
				#
				#      01/02/1970 = 31    (31 dias do mês de janeiro)
				#      01/01/1971 = 365   (um ano)
				#      01/01/1980 = 3652  (365 * 10 anos + 2 bissextos)

				data="$data1"

				# Extrai os componentes da data: ano, mês, dia
				yyyy=${data##*/}
				mm=${data#*/}
				mm=${mm%/*}
				dd=${data%%/*}

				# Retira os zeros à esquerda (pra não confundir com octal)
				mm=${mm#0}
				dd=${dd#0}
				yyyy=$(echo "$yyyy" | sed 's/^00*//; s/^$/0/')

				# Define o marco inicial e a direção dos cálculos
				if [ $yyyy -ge $epoch ]
				then
					# +Epoch: Inicia em 01/01/1970 e avança no tempo
					y=$epoch          # ano
					m=1               # mês
					op='+'            # direção
					dias=0            # 01/01/1970 == 0
					dias_mes="$dias_mes_ok"
				else
					# -Epoch: Inicia em 31/12/1969 e retrocede no tempo
					y=$((epoch - 1))  # ano
					m=12              # mês
					op='-'            # direção
					dias=-1           # 31/12/1969 == -1
					dias_mes="$dias_mes_rev"
				fi

				# Ano -> dias
				while :
				do
					# Sim, os anos bissextos são levados em conta!
					dias_ano=365
					zztool testa_ano_bissexto $y && dias_ano=366

					# Vai somando (ou subtraindo) até chegar no ano corrente
					[ $y -eq $yyyy ] && break
					dias=$(($dias $op $dias_ano))
					y=$(($y $op 1))
				done

				# Meses -> dias
				for i in $dias_mes
				do
					# Fevereiro de ano bissexto tem 29 dias
					[ $dias_ano -eq 366 -a $i -eq 28 ] && i=29

					# Vai somando (ou subtraindo) até chegar no mês corrente
					[ $m -eq $mm ] && break
					m=$(($m $op 1))
					dias=$(($dias $op $i))
				done
				dias_neste_mes=$i

				# -Epoch: o número de dias indica o quanto deve-se
				# retroceder à partir do último dia do mês
				[ $op = '-' ] && dd=$(($dias_neste_mes - $dd))

				# Somando os dias da data aos anos+meses já contados.
				dias=$(($dias $op $dd))

				# +Epoch: É subtraído um do resultado pois 01/01/1970 == 0
				[ $op = '+' ] && dias=$((dias - 1))

				# Feito, só mostrar o resultado
				echo "$dias"
			;;

			dias)
				#############################################################
				### Conversão NÚMERO -> DATA
				#
				# O número inteiro é convertido para a data dd/mm/aaaa.
				# Se o número for positivo, temos uma data DEPOIS de $epoch.
				# Se o número for negativo, temos uma data ANTES de $epoch.
				# Anos bissextos são tratados corretamente.
				#
				# Exemplos:
				#      -2 = 30/12/1969
				#      -1 = 31/12/1969
				#       0 = 01/01/1970
				#       1 = 02/01/1970
				#       2 = 03/01/1970

				dias="$dias1"

				if [ $dias -ge 0 ]
				then
					# POSITIVO: Inicia em 01/01/1970 e avança no tempo
					y=$epoch          # ano
					mm=1              # mês
					op='+'            # direção
					dias_mes="$dias_mes_ok"
				else
					# NEGATIVO: Inicia em 31/12/1969 e retrocede no tempo
					y=$((epoch - 1))  # ano
					mm=12             # mês
					op='-'            # direção
					dias_mes="$dias_mes_rev"

					# Valor negativo complica, vamos positivar: abs()
					dias=$((0 - dias))
				fi

				# O número da Epoch é zero-based, agora vai virar one-based
				dd=$(($dias $op 1))

				# Dias -> Ano
				while :
				do
					# Novamente, o ano bissexto é levado em conta
					dias_ano=365
					zztool testa_ano_bissexto $y && dias_ano=366

					# Vai descontando os dias de cada ano para saber quantos anos cabem

					# Não muda o ano se o número de dias for insuficiente
					[ $dd -lt $dias_ano ] && break

					# Se for exatamente igual ao total de dias, não muda o
					# ano se estivermos indo adiante no tempo (> Epoch).
					# Caso contrário vai mudar pois cairemos no último dia
					# do ano anterior.
					[ $dd -eq $dias_ano -a $op = '+' ] && break

					dd=$(($dd - $dias_ano))
					y=$(($y $op 1))
				done
				yyyy=$y

				# Dias -> mês
				for i in $dias_mes
				do
					# Fevereiro de ano bissexto tem 29 dias
					[ $dias_ano -eq 366 -a $i -eq 28 ] && i=29

					# Calcula quantos meses cabem nos dias que sobraram

					# Não muda o mês se o número de dias for insuficiente
					[ $dd -lt $i ] && break

					# Se for exatamente igual ao total de dias, não muda o
					# mês se estivermos indo adiante no tempo (> Epoch).
					# Caso contrário vai mudar pois cairemos no último dia
					# do mês anterior.
					[ $dd -eq $i -a $op = '+' ] && break

					dd=$(($dd - $i))
					mm=$(($mm $op 1))
				done
				dias_neste_mes=$i

				# Ano e mês estão OK, agora sobraram apenas os dias

				# Se estivermos antes de Epoch, os número de dias indica quanto
				# devemos caminhar do último dia do mês até o primeiro
				[ $op = '-' ] && dd=$(($dias_neste_mes - $dd))

				# Restaura o zero dos meses e dias menores que 10
				[ $dd -le 9 ] && dd="0$dd"
				[ $mm -le 9 ] && mm="0$mm"

				# E finalmente mostra o resultado em formato de data
				echo "$dd/$mm/$yyyy"
			;;

			*)
				echo "Tipo inválido '$tipo1'. Isso não deveria acontecer :/"
				return 1
			;;
		esac
		return 0
	fi

	# Neste ponto só chega se houver mais de um parâmetro.
	# Todos os valores já foram validados.

	#############################################################
	### Cálculos com datas
	#
	# Temos dois valores informadas pelo usuário: $valor1 e $valor2.
	# Cada valor pode ser uma data dd/mm/aaaa, um número inteiro
	# ou um delta de dias, meses ou anos.
	#
	# Exemplos: 31/12/1999, 123, -123, 5d, 5m, 5a
	#
	# O usuário pode fazer qualquer combinação entre estes valores.
	#
	# Se o cálculo envolver deltas m|a, é usada a data dd/mm/aaaa.
	# Senão, é usado o número inteiro que representa a data.
	#
	# O tipo de cada valor é guardado em $tipo1-2.
	# Dependendo do tipo, o valor foi guardado nas variáveis
	# $data1-2, $dias1-2 ou $delta1-2.
	# Use estas variáveis no bloco seguinte para tomar decisões.

	# Cálculo com delta.
	if test $tipo1 = 'delta' -o $tipo2 = 'delta'
	then
		# Nunca haverá dois valores do mesmo tipo, posso abusar:
		delta="$delta1$delta2"
		data="$data1$data2"
		dias="$dias1$dias2"

		quantidade=$(echo "$delta" | sed 's/[^0-9]//g')
		grandeza=$(  echo "$delta" | sed 's/[^dma]//g')

		case $grandeza in
			d)
				# O cálculo deve ser feito utilizando o número
				test -z "$dias" && dias=$(zzdata "$data")  # data2n

				# Soma ou subtrai o delta
				dias=$(($dias $operacao $quantidade))

				# Converte o resultado para dd/mm/aaaa
				zzdata $dias
				return
			;;
			m | a)
				# O cálculo deve ser feito utilizando a data
				test -z "$data" && data=$(zzdata "$dias")  # n2data

				# Extrai os componentes da data: ano, mês, dia
				yyyy=${data##*/}
				mm=${data#*/}
				mm=${mm%/*}
				dd=${data%%/*}

				# Retira os zeros à esquerda (pra não confundir com octal)
				mm=${mm#0}
				dd=${dd#0}
				yyyy=$(echo "$yyyy" | sed 's/^00*//; s/^$/0/')

				# Anos
				if test $grandeza = 'a'
				then
					yyyy=$(($yyyy $operacao $quantidade))

				# Meses
				else
					mm=$(($mm $operacao $quantidade))

					# Se houver excedente no mês (>12), recalcula mês e ano
					yyyy=$(($yyyy + $mm / 12))
					mm=$(($mm % 12))

					# Se negativou, ajusta os cálculos (voltou um ano)
					if test $mm -le 0
					then
						yyyy=$(($yyyy - 1))
						mm=$((12 + $mm))
					fi
				fi

				# Se o resultado for 29/02 em um ano não-bissexto, muda pra 28/02
				test $dd -eq 29 -a $mm -eq 2 &&	! zztool testa_ano_bissexto $yyyy && dd=28

				# Restaura o zero dos meses e dias menores que 10
				[ $dd -le 9 ] && dd="0$dd"
				[ $mm -le 9 ] && mm="0$mm"

				# Tá feito, basta montar a data
				echo "$dd/$mm/$yyyy"
				return 0
			;;
		esac

	# Cálculo normal, sem delta
	else
		# Ambas as datas são sempre convertidas para inteiros
		test "$tipo1" != 'dias' && dias1=$(zzdata "$data1")
		test "$tipo2" != 'dias' && dias2=$(zzdata "$data2")

		# Soma ou subtrai os valores
		dias=$(($dias1 $operacao $dias2))

		# Se as duas datas foram informadas como dd/mm/aaaa,
		# o resultado é o próprio número de dias. Senão converte
		# o resultado para uma data.
		if test "$tipo1$tipo2" = 'datadata'
		then
			echo "$dias"
		else
			zzdata "$dias"  # n2data
		fi
	fi
}

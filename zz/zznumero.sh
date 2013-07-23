# ----------------------------------------------------------------------------
# Formatando a saída de um número.
# Opções:
#  -f <padrão | numeros>: Padrão de formatação igual ao printf,
# incluindo %'d e %'.f ou precisão se apenas informado um número, se
# no número for informado um  traço '-', fica sem limites.
#  -p <prefixo>: Um prefixo para o número, se for R$ igual a opção -m
#  -s <sufixo>: Um sufixo para o número
#  -m: Trata valor monetário, sobrepondo as configurações de -p, -s  e -f
#  --moeda: O mesmo que a opção -m
#  -t: Número parcialmente por extenso, por ex: 2 mihões 350 mil e doze
#  --texto: Número inteiramente por extenso, ex: quatro mil e cento e vinte
#  -l: Uma classe numérica por linha, quando optar no número por extenso
#  --de <formato>: Formato de entrada
#  --para <formato>: Formato de saída
#   formatos: pt ou pt-br => português (brasil) | en => inglês (americano)
#
# Por extenso suporta 81 dígitos inteiros e até 26 casas decimais.
#
# Uso: zznumero [opção1] [opção2] ... <numero>
# Ex.: zznumero 12445.78
#      zznumero --texto 4567890,213
#      zznumero -m 85,345
#      echo 748 | zznumero -f "%'.3f"
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-05
# Versão: 4
# Licença: GPL
# Requisitos: zzvira
# ----------------------------------------------------------------------------
zznumero ()
{
	zzzz -h numero "$1" && return

	local texto=0
	local prec=2
	local linha=0
	local milhar_de decimal_de milhar_para decimal_para
	local numero qtde_v qtde_p n_formato num_int num_frac num_saida prefixo sufixo sinal n_temp

	# Zero a Novecentos e noventa e nove (base para as demais classes)
	local ordem1="\
0:::
1:um::cento
2:dois:vinte:duzentos
3:três:trinta:trezentos
4:quatro:quarenta:quatrocentos
5:cinco:cinquenta:quinhentos
6:seis:sessenta:seiscentos
7:sete:setenta:setecentos
8:oito:oitenta:oitocentos
9:nove:noventa:novecentos
10:dez::
11:onze::
12:doze::
13:treze::
14:catorze::
15:quinze::
16:dezesseis::
17:dezessete::
18:dezoito::
19:dezenove::"

	# Ordem de grandeza x 1000 (Classe)
	local ordem2="\
0:
1:mil
2:milhões
3:bilhões
4:trilhões
5:quadrilhões
6:quintilhões
7:sextilhões
8:septilhões
9:octilhões
10:nonilhões
11:decillões
12:undecilhões
13:duodecilhões
14:tredecilhões
15:quattuordecilhões
16:quindecilhões
17:sexdecilhões
18:septendecilhões
19:octodecilhões
20:novendecilhões
21:vigintilhões
22:unvigintilhões
23:douvigintilhões
24:tresvigintilhões
25:quatrivigintilhões
26:quinquavigintilhões"

	# Ordem de grandeza base para a ordem4
	local ordem3="\
1:décimos
2:centésimos"

	# Ordem de grandeza / 1000 (Classe)
	local ordem4="\
1:milésimos
2:milionésimos
3:bilionésimos
4:trilionésimos
5:quadrilionésimos
6:quintilionésimos
7:sextilionésimos
8:septilionésimos"

	# Opções
	while  [ "${1#-}" != "$1" ]
	do
		case "$1" in
		-f)
			# Formato estabelecido pelo usuário conforme printf ou precisão
			# Precisão no formato do printf (esperado)
			n_formato="$2"

			# Sem limites de precisão
			if [ "$2" = "-" ]
			then
				prec="$2"
				unset n_formato
			fi

			# Precisão definida
			if zztool testa_numero "$2"
			then
				prec="$2"
				unset n_formato
			fi
			shift
			shift
		;;

		--de)
			# Formato de entrada
			if [ "$2" = "pt" -o "$2" = "pt-br" ]
			then
				milhar_de='.'
				decimal_de=','
			elif [ "$2" = "en" ]
			then
				milhar_de=','
				decimal_de='.'
			fi
			shift
			shift
		;;

		--para)
			# Formato de saída
			if [ "$2" = "pt" -o "$2" = "pt-br" ]
			then
				milhar_para='.'
				decimal_para=','
			elif [ "$2" = "en" ]
			then
				milhar_para=','
				decimal_para='.'
			fi
			shift
			shift
		;;

		-p)
			# Prefixo escolhido pelo usuário
			prefixo="$2"
			$(echo "$2" | grep '^ *[rR]$ *$') && prefixo='R$ '
			shift
			shift
		;;

		-s)
			# Sufixo escolhido pelo usuário
			sufixo="$2"
			shift
			shift
		;;

		-t | --texto)
			# Variável para número por extenso
			# Flag para formato por extenso
			[ "$1" = "-t" ] && texto=1
			[ "$1" = "--texto" ] && texto=2
			shift
		;;

		-l)
			# No modo texto, uma classe numérica por linha
			linha=1
			shift
		;;

		-m | --moeda)
			# Solicitando formato moeda (sobrepõe as opção de prefixo, sufixo e formato)
			prec=2
			prefixo='R$ '
			unset sufixo
			unset n_formato
			shift
		;;

		*) break;;
		esac
	done

	# Habilitar entrada direta ou através de pipe
	n_temp=$(zztool multi_stdin "$@")

	# Adequando entrada do valor a algumas possíveis armadilhas
	set - $n_temp
	n_temp=$(echo "$1" | sed 's/[.,]$//')
	set - $n_temp

	# Armazenando o sinal, se presente
	sinal=$(echo "$1" | cut -c1)
	if [ "$sinal" = "+" -o "$sinal" = "-" ]
	then
		set - $(echo "$1" | sed 's/^[+-]//')
	else
		unset sinal
	fi

	if [ "$decimal_de" ]
	then
		# Trocando o símbolo de milhar de entrada por "m" e depois por . (ponto)
		# Trocando o símbolo de decimal de entrada por "d" e depois , (vírgula)
		n_temp=$(echo "$1" | tr "${milhar_de}" 'm' | tr "${decimal_de}" 'd')
		n_temp=$(echo "$n_temp" | tr 'm' '.' | tr 'd' ',')

		set - $n_temp
	fi

	if zztool testa_numero "$1" && ! zztool grep_var 'R$' "$prefixo"
	then
	# Testa se o número é um numero inteiro sem parte fracionária ou separador de milhar
		if [ ${#n_formato} -gt 0 ]
		then
			numero=$(printf "${n_formato}" "$1" 2>/dev/null)
		else
			numero=$(echo "$1" | zzvira | sed 's/.../&\./g;s/\.$//' | zzvira)
		fi
		num_int="$1"
		num_saida="${sinal}${numero}"

		# Aplicando o formato conforme opção --para
		if [ "$milhar_para" ]
		then
			num_saida=$(echo "$num_saida" | tr '.' "${milhar_para}")
		fi

	else

		# Testa se o número é um numero inteiro sem parte fracionária ou separador de milhar
		# e que tem o prefixo 'R$', caracterizando como moeda
		if zztool testa_numero "$1" && zztool grep_var 'R$' "$prefixo"
		then
			numero="${1},00"
		fi

		# Quantidade de pontos ou vírgulas no número informado
		qtde_p=$(echo "$1" | sed 's/./&\n/g' | grep -c "\.")
		qtde_v=$(echo "$1" | sed 's/./&\n/g' | grep -c ",")

		# Número com o "ponto decimal" separando a parte fracionária, sem separador de milhar
		# Se for padrão 999.999, é considerado um inteiro
		if [ $qtde_p -eq 1 -a $qtde_v -eq 0 ] && zztool testa_numero_fracionario "$1"
		then
			echo $1 | grep '^[0-9]\{1,3\}\.[0-9]\{3\}$' >/dev/null
			[ $? -eq 0  ] && numero=$(echo $1 | tr -d '.') || numero=$(echo $1 | tr '.' ',')
		fi

		# Número com a "vírgula" separando da parte fracionária, sem separador de milhares
		if [ $qtde_v -eq 1 -a $qtde_p -eq 0 ] && zztool testa_numero_fracionario "$1"
		then
			numero=$1
		fi

		# Número com o "ponto" como separador de milhar, e sem parte fracionária
		if ([ $qtde_p -gt 1 -a $qtde_v -eq 0 ] && [ ! $numero ])
		then
			echo $1 | grep '^[0-9]\{1,3\}\(\.[0-9]\{3\}\)\{1,\}$' >/dev/null
			[ $? -eq 0  ] && numero=$(echo $1 | tr -d '.')
		fi

		# Número com a "vírgula" como separador de milhar, e sem parte fracionária
		if ([ $qtde_v -gt 1 -a $qtde_p -eq 0 ] && [ ! $numero ])
		then
			echo $1 | grep '^[0-9]\{1,3\}\(,[0-9]\{3\}\)\{1,\}$' >/dev/null
			[ $? -eq 0  ] && numero=$(echo $1 | tr -d ',')
		fi

		# Numero começando com ponto ou vírgula, sendo considerado só fracionário
		if [ ! $numero ]
		then
			echo $1 | grep '^[,.][0-9]\{1,\}$' >/dev/null
			[ $? -eq 0  ] && numero=$(echo "0${1}" | tr '.' ',')
		fi

		if [ ! $numero ]
		then
		# Deixando o número com o formato 0000,00 (sem separador de milhar)
			# Número com o "ponto" separando a parte fracionária e vírgula como separador de milhar
			echo $1 | grep '^[0-9]\{1,3\}\(,[0-9]\{3\}\)\{1,\}\.[0-9]\{1,\}$' >/dev/null
			[ $? -eq 0  ] && numero=$(echo $1 | tr -d ',' | tr '.' ',')

			# Número com a "vírgula" separando a parte fracionária e ponto como separador de milhar
			echo $1 | grep '^[0-9]\{1,3\}\(\.[0-9]\{3\}\)\{1,\},[0-9]\{1,\}$' >/dev/null
			[ $? -eq 0  ] && numero=$(echo $1 | tr -d '.')
		fi

		if [ $numero ]
		then
			# Separando componentes dos números
			num_int=${numero%,*}
			zztool grep_var ',' "$numero" && num_frac=${numero#*,}

			# Tirando os zeros não significativos
			num_int=$(echo "$num_int" | sed 's/^0*//')
			[ ${#num_int} -eq 0 ] && num_int=0

			[ ${#num_frac} -gt 0 ] && num_frac=$(echo "$num_frac" | sed 's/0*$//')

			if [ ${#num_frac} -gt 0 ]
			then
				zztool testa_numero $num_frac || { zztool uso numero; return 1; }
			fi

			# Se houver precisão estabelecida pela opção -f
			if test "$prec" != "-" && test $prec -ge 0 && test ${#n_formato} -eq 0
			then
				# Para arredondamento usa-se a seguinte regra:
				#  Se o próximo número além da precisão for maior que 5 arredonda-se para cima
				#  Se o próximo número além da precisão for menor que 5 arredonda-se para baixo
				#  Se o próximo número além da precisão for 5, vai depender do número anterior
				#    Se for par arredonda-se para baixo
				#    Se for ímpar arredonda-se para cima
				if [ ${#num_frac} -gt $prec ]
				then

					# Quando for -f 0, sem casas decimais, guardamos o ultimo digito do num_int (parte inteira)
					unset n_temp
					if [ $prec -eq 0 ]
					then
						n_temp=${#num_int}
						n_temp=$(echo "$num_int" | cut -c $n_temp)
					fi

					num_frac=$(echo "$num_frac" | cut -c 1-$((prec + 1)))

					if [ $(echo "$num_frac" | cut -c $((prec + 1))) -ge 6 ]
					then
						# Último número maior que cinco (além da precisão), arredonda pra cima
						if [ $prec -eq 0 ]
						then
							unset num_frac
							num_int=$(echo "$num_int + 1" | bc)
						else
							num_frac=$(echo "$num_frac" | cut -c 1-${prec})
							num_frac=$(echo "$num_frac + 1" | bc)
						fi

					elif [ $(echo "$num_frac" | cut -c $((prec + 1))) -le 4 ]
					then
						# Último número menor que cinco (além da precisão), arredonda pra baixo (trunca)
						if [ $prec -eq 0 ]
						then
							unset num_frac
						else
							num_frac=$(echo "$num_frac" | cut -c 1-${prec})
						fi

					else
						if [ $prec -eq 0 ]
						then
							unset num_frac
							# Se o último número do num_int for ímpar, arredonda-se para cima
							if [ $(($n_temp % 2)) -eq 1 ]
							then
								num_int=$(echo "$num_int + 1" | bc)
							fi
						else
						# Determinando último número dentro da precisão é par
							if [ $(echo $(($(echo $num_frac | cut -c ${prec}) % 2))) -eq 0 ]
							then
								# Se sim arredonda-se para baixo (trunca)
								num_frac=$(echo "$num_frac" | cut -c 1-${prec})
							else
								# Se não arredonda-se para cima
								num_frac=$(echo "$num_frac" | cut -c 1-${prec})

								# Exceção: Se num_frac for 9*, vira 0* e aumenta num_int em mais 1
								echo "$num_frac" | cut -c 1-${prec} | grep '^9\{1,\}$' > /dev/null
								if [ $? -eq 0 ]
								then
									unset num_frac
									num_int=$(echo "$num_int + 1" | bc)
								else
									num_frac=$(echo "$num_frac + 1" | bc)
								fi
							fi
						fi
					fi

					# Restaurando o tamanho do num_frac
					while [ ${#num_frac} -lt $prec -a ${#num_frac} -gt 0 ]
					do
						num_frac="0${num_frac}"
					done
				fi

				# Tirando os zeros não significativos
				num_frac=$(echo "$num_frac" | sed 's/0*$//')
			fi

			if zztool grep_var 'R$' "$prefixo"
			then
			# Caso especial para opção -m, --moedas ou prefixo 'R$'
			# Formato R$ 0.000,00 (sempre)
				# Arredondamento para 2 casas decimais
				[ ${#num_frac} -eq 0 -a $texto -eq 0 ] && num_frac="00"
				[ ${#num_frac} -eq 1 ] && num_frac="${num_frac}0"

				numero=$(echo "${num_int}" | zzvira | sed 's/.../&\./g;s/\.$//' | zzvira)
				num_saida="${numero},${num_frac}"

				# Aplicando o formato conforme opção --para
				if [ "$decimal_para" ]
				then
					num_saida=$(echo "$num_saida" | tr '.' 'm' | tr ',' 'd')
					num_saida=$(echo "$num_saida" | tr 'm' "${milhar_para}" | tr 'd' "${decimal_para}")
				fi

			elif [ ${#n_formato} -gt 0 ]
			then

			# Conforme formato solicitado pelo usuário
				if [ ${#num_frac} -gt 0 ]
				then
				# Se existir parte fracionária

					# Para shell configurado para vírgula como separador da parte decimal
					numero=$(printf "${n_formato}" "${num_int},${num_frac}" 2>/dev/null)
					# Para shell configurado para ponto como separador da parte decimal
					[ $? -ne 0 ] && numero=$(printf "${n_formato}" "${num_int}.${num_frac}" 2>/dev/null)
				else
				# Se tiver apenas a parte inteira
					numero=$(printf "${n_formato}" "${num_int}" 2>/dev/null)
				fi
				num_saida=$numero
			else
			# Formato 0.000,00
				numero=$(echo "${num_int}" | zzvira | sed 's/.../&\./g;s/\.$//' | zzvira)
				num_saida="${numero},${num_frac}"

				# Aplicando o formato conforme opção --para
				if [ "$decimal_para" ]
				then
					num_saida=$(echo "$num_saida" | tr '.' 'm' | tr ',' 'd')
					num_saida=$(echo "$num_saida" | tr 'm' "${milhar_para}" | tr 'd' "${decimal_para}")
				fi
			fi

			if zztool grep_var 'R$' "$prefixo"
			then
				num_saida=$(echo "${sinal}${prefixo}${num_saida}" | sed 's/[,.]$//')
			else
				num_saida=$(echo "${sinal}${num_saida}" | sed 's/[,.]$//')
			fi

		fi
	fi

	if [ $texto -eq 1 -o $texto -eq 2 ]
	then

		######################################################################

		# Escrevendo a parte inteira. (usando a variável qtde_p emprestada)
		qtde_p=$(((${#num_int}-1) / 3))

		# Colocando os números como argumentos
		set - $(echo "${num_int}" | zzvira | sed 's/.../&\ /g' | zzvira)

		# Liberando as variáveis numero e num_saida para receber o número por extenso
		unset numero
		unset num_saida

		while [ "$1" ]
		do
			# Emprestando a variável qtde_v para cada conjunto de 3 números do número original (ordem de grandeza)
			# Tirando os zeros não significativos nesse contexto

			qtde_v=$(echo "$1" | sed 's/^[ 0]*//')

			if [ ${#qtde_v} -gt 0 ]
			then
				# Emprestando a variável n_formato para guardar a descrição da ordem2
				n_formato=$(echo "$ordem2" | grep "^${qtde_p}:" 2>/dev/null | cut -f2 -d":")
				[ "$qtde_v" = "1" ] && n_formato=$(echo "$n_formato" | sed 's/ões/ão/')

				if [ $texto -eq 2 ]
				then
				# Números também por extenso

					case ${#qtde_v} in
						1)
							# Número unitario, captura direta do texto no segundo campo
							numero=$(echo "$ordem1" | grep "^${qtde_v}:" | cut -f2 -d":")
						;;
						2)
							if [ $(echo "$qtde_v" | cut -c1) -eq 1 ]
							then
								# Entre 10 e 19, captura direta do texto no segundo campo
								numero=$(echo "$ordem1" | grep "^${qtde_v}:" | cut -f2 -d":")
							elif [ $(echo "$qtde_v" | cut -c2) -eq 0 ]
							then
								# Dezenas, captura direta do texto no terceiro campo
								n_temp=$(echo "$qtde_v" | cut -c1)
								numero=$(echo "$ordem1" | grep "^${n_temp}:" | cut -f3 -d":")
							else
								# 21 a 99, excluindo as dezenas terminadas em zero
								# Dezena
								n_temp=$(echo "$qtde_v" | cut -c1)
								numero=$(echo "$ordem1" | grep "^${n_temp}:" | cut -f3 -d":")

								# Unidade
								n_temp=$(echo "$qtde_v" | cut -c2)
								n_temp=$(echo "$ordem1" | grep "^${n_temp}:" | cut -f2 -d":")

								# Numero dessa classe
								numero="$numero e $n_temp"
							fi
						;;
						3)
							if [ $qtde_v -eq 100 ]
							then
								# Exceção para o número cem
								numero="cem"
							else
								# 101 a 999
								# Centena
								n_temp=$(echo "$qtde_v" | cut -c1)
								numero=$(echo "$ordem1" | grep "^${n_temp}:" | cut -f4 -d":")

								# Dezena
								n_temp=$(echo "$qtde_v" | cut -c2)
								if [ "$n_temp" != "0" ]
								then
									if [ "$n_temp" = "1" ]
									then
										n_temp=$(echo "$qtde_v" | cut -c2-3)
										n_temp=$(echo "$ordem1" | grep "^${n_temp}:" | cut -f2 -d":")
										numero="$numero e $n_temp"
									else
										n_temp=$(echo "$ordem1" | grep "^${n_temp}:" | cut -f3 -d":")
										numero="$numero e $n_temp"
									fi
								fi

								# Unidade
								n_temp=$(echo "$qtde_v" | cut -c2)
								if [ "$n_temp" != "1" ]
								then
									n_temp=$(echo "$qtde_v" | cut -c3)
									if [ "$n_temp" != "0" ]
									then
										n_temp=$(echo "$ordem1" | grep "^${n_temp}:" | cut -f2 -d":")
										numero="$numero e $n_temp"
									fi
								fi
							fi
						;;
					esac
				fi

				if [ $texto -eq 2 ]
				then
					num_saida="${num_saida} e ${numero} ${n_formato}"
				else
					num_saida="${num_saida} ${qtde_v} ${n_formato}"
				fi
			fi

			qtde_p=$((qtde_p - 1))
			shift
		done
		[ "$num_saida" ] && num_saida=$(echo "${num_saida} inteiros" | sed 's/ *$//;s/ \{1,\}/ /g')

		######################################################################

		#Validando as parte fracionária do número
		if [ ${#num_frac} -gt 0 ]
		then
			zztool testa_numero $num_frac || { zztool uso numero; return 1; }
		fi

		# Escrevendo a parte fracionária. (usando a variável qtde_p emprestada)
		qtde_p=$(((${#num_frac}-1) / 3))

		# Colocando os números como argumentos
		set - $(echo "${num_frac}" | zzvira | sed 's/.../&\ /g' | zzvira)

		# Liberando as variáveis numero para receber o número por extenso
		unset numero

		[ "$1" ] && num_saida="$num_saida e "

		while [ "$1" ]
		do
			# Emprestando a variável qtde_v para cada conjunto de 3 números do número original (ordem de grandeza)
			# Tirando os zeros não significativos nesse contexto
			qtde_v=$(echo "$1" | sed 's/^[ 0]*//')

			if [ ${#qtde_v} -gt 0 ]
			then
				# Emprestando a variável n_formato para guardar a descrição da ordem2
				n_formato=$(echo "$ordem2" | grep "^${qtde_p}:" 2>/dev/null | cut -f2 -d":")
				[ "$qtde_v" = "1" ] && n_formato=$(echo "$n_formato" | sed 's/ões/ão/')
				n_formato=$(echo "$n_formato" | sed 's/inteiros//')

				if [ $texto -eq 2 ]
				then
				# Numeros também por extenso
					case ${#qtde_v} in
						1)
							# Número unitario, captura direta do texto no segundo campo
							numero=$(echo "$ordem1" | grep "^${qtde_v}:" | cut -f2 -d":")
						;;
						2)
							if [ $(echo "$qtde_v" | cut -c1) -eq 1 ]
							then
								# Entre 10 e 19, captura direta do texto no segundo campo
								numero=$(echo "$ordem1" | grep "^${qtde_v}:" | cut -f2 -d":")
							elif [ $(echo "$qtde_v" | cut -c2) -eq 0 ]
							then
								# Dezenas, captura direta do texto no terceiro campo
								n_temp=$(echo "$qtde_v" | cut -c1)
								numero=$(echo "$ordem1" | grep "^${n_temp}:" | cut -f3 -d":")
							else
								# 21 a 99, excluindo as dezenas terminadas em zero
								# Dezena
								n_temp=$(echo "$qtde_v" | cut -c1)
								numero=$(echo "$ordem1" | grep "^${n_temp}:" | cut -f3 -d":")

								# Unidade
								n_temp=$(echo "$qtde_v" | cut -c2)
								n_temp=$(echo "$ordem1" | grep "^${n_temp}:" | cut -f2 -d":")

								# Número dessa classe
								numero="$numero e $n_temp"
							fi
						;;
						3)
							if [ $qtde_v -eq 100 ]
							then
								# Exceção para o número cem
								numero="cem"
							else
								# 101 a 999
								# Centena
								n_temp=$(echo "$qtde_v" | cut -c1)
								numero=$(echo "$ordem1" | grep "^${n_temp}:" | cut -f4 -d":")

								# Dezena
								n_temp=$(echo "$qtde_v" | cut -c2)
								if [ "$n_temp" != "0" ]
								then
									if [ "$n_temp" = "1" ]
									then
										n_temp=$(echo "$qtde_v" | cut -c2-3)
										n_temp=$(echo "$ordem1" | grep "^${n_temp}:" | cut -f2 -d":")
										numero="$numero e $n_temp"
									else
										n_temp=$(echo "$ordem1" | grep "^${n_temp}:" | cut -f3 -d":")
										numero="$numero e $n_temp"
									fi
								fi

								# Unidade
								n_temp=$(echo "$qtde_v" | cut -c2)
								if [ "$n_temp" != "1" ]
								then
									n_temp=$(echo "$qtde_v" | cut -c3)
									if [ "$n_temp" != "0" ]
									then
										n_temp=$(echo "$ordem1" | grep "^${n_temp}:" | cut -f2 -d":")
										numero="$numero e $n_temp"
									fi
								fi
							fi
						;;
					esac
				fi

				if [ $texto -eq 2 ]
				then
					num_saida="${num_saida} e ${numero} ${n_formato}"
				else
					num_saida="${num_saida} ${qtde_v} ${n_formato}"
				fi
			fi

			qtde_p=$((qtde_p - 1))
			shift
		done

		if [ ${#num_frac} -gt 0 ]
		then
			# Primeiro sub-nível (ordem)
			n_temp=$((${#num_frac} % 3))
			n_temp=$(echo "$ordem3" | grep "^${n_temp}:" | cut -f2 -d":")
			num_saida="${num_saida} ${n_temp}"

			# Segundo sub-nível (classes)
			n_temp=$(((${#num_frac}-1) / 3))
			[ $((${#num_frac} % 3)) -eq 0  ] && n_temp=$((n_temp + 1))
			n_temp=$(echo "$ordem4" | grep "^${n_temp}:" | cut -f2 -d":")
			num_saida="${num_saida} ${n_temp}"

			num_saida=$(echo "$num_saida" |
				sed 's/décimos \([a-z]\)/décimos de \1/;s/centésimos \([a-z]\)/centésimos de \1/' |
				sed 's/ *$//;s/ \{1,\}/ /g')

			# Ajuste para valor unitário na parte fracionária
			$(echo $num_frac | grep '^0\{1,\}1$' > /dev/null) && num_saida=$(echo $num_saida | sed 's/imos/imo/g')
		fi

		######################################################################

		[ "$sinal" = '-' ] && num_saida="$num_saida negativos"
		[ "$sinal" = '+' ] && num_saida="$num_saida positivos"

		# Para o caso de ser o número 1, colocar no singular
		if [ "$num_int" = "1" ]
		then
			if [ ${#num_frac} -eq 0 ]
			then
				num_saida=$(echo $num_saida | sed 's/s$//')
			elif [ "$num_frac" = "00" ]
			then
				num_saida=$(echo $num_saida | sed 's/s$//')
			fi
		fi

		# Sufixo dependendo se for valor monetário
		if zztool grep_var 'R$' "$prefixo"
		then
			num_saida=$(echo "$num_saida" | sed 's/inteiros/reais/;s/inteiro/real/;s/centésimo/centavo/')
		else
			[ "$sufixo" ] && num_saida=$(echo "$num_saida" | sed "s/inteiros/${sufixo}/;s/inteiro/${sufixo}/")
		fi

		num_saida=$(echo "$num_saida" | sed 's/ e  *e / e /g;s/ \{1,\}/ /g' | sed 's/^  *e//;s/ e *$//')

		# Uma classe numérica por linha
		if [ $linha -eq 1 ]
		then
			case $texto in
			1)
				num_saida=$(echo " $num_saida" |
				sed 's/ [0-9]/\
&/g' | sed '/^ *$/d')
			;;
			2)
				num_saida=$(echo " $num_saida" |
				sed 's/ilhões/&\
/g;s/ilhão/&\
/g;s/mil /&\
 /' |
				sed 's/inteiros*/&\
/;s/rea[li]s*/&\
/')
			;;
			esac
		fi

		echo "$num_saida" | sed 's/ *$//g;s/ \{1,\}/ /g'

	else
		zztool grep_var 'R$' "$prefixo" && unset prefixo
		[ ${#num_saida} -gt 0 ] && echo ${prefixo}${num_saida}${sufixo}
	fi
}

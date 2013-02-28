# ----------------------------------------------------------------------------
# Calcula porcentagens.
# Se informado um número, mostra sua tabela de porcentagens.
# Se informados dois números, mostra a porcentagem relativa entre eles.
# Se informados um número e uma porcentagem, mostra o valor da porcentagem.
# Se informados um número e uma porcentagem com sinal, calcula o novo valor.
#
# Uso: zzporcento valor [valor|[+|-]porcentagem%]
# Ex.: zzporcento 500           # Tabela de porcentagens de 500
#      zzporcento 500.0000      # Tabela para número fracionário (.)
#      zzporcento 500,0000      # Tabela para número fracionário (,)
#      zzporcento 5.000,00      # Tabela para valor monetário
#      zzporcento 500 25        # Mostra a porcentagem de 25 para 500 (5%)
#      zzporcento 500 1000      # Mostra a porcentagem de 1000 para 500 (200%)
#      zzporcento 500,00 2,5%   # Mostra quanto é 2,5% de 500,00
#      zzporcento 500,00 +2,5%  # Mostra quanto é 500,00 + 2,5%
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2008-12-11
# Versão: 6
# Licença: GPL
# ----------------------------------------------------------------------------
zzporcento ()
{
	zzzz -h porcento "$1" && return

	local i porcentagem sinal
	local valor1="$1"
	local valor2="$2"
	local escala=0
	local separador=','
	local tabela='200 150 125 100 90 80 75 70 60 50 40 30 25 20 15 10 9 8 7 6 5 4 3 2 1'

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso porcento; return 1; }

	# Remove os pontos dos dinheiros para virarem fracionários (1.234,00 > 1234,00)
	zztool testa_dinheiro "$valor1" && valor1=$(echo "$valor1" | sed 's/\.//g')
	zztool testa_dinheiro "$valor2" && valor2=$(echo "$valor2" | sed 's/\.//g')

	### Vamos analisar o primeiro valor

	# Número fracionário (1.2345 ou 1,2345)
	if zztool testa_numero_fracionario "$valor1"
	then
		separador=$(echo "$valor1" | tr -d 0-9)
		escala=$(echo "$valor1" | sed 's/.*[.,]//')
		escala="${#escala}"

		# Sempre usar o ponto como separador interno (para os cálculos)
		valor1=$(echo "$valor1" | sed 'y/,/./')

	# Número inteiro ou erro
	else
		zztool -e testa_numero "$valor1" || return 1
	fi

	### Vamos analisar o segundo valor

	# O segundo argumento é uma porcentagem
	if test $# -eq 2 && zztool grep_var % "$valor2"
	then
		# O valor da porcentagem é guardado sem o caractere %
		porcentagem=$(echo "$valor2" | tr -d %)

		# Sempre usar o ponto como separador interno (para os cálculos)
		porcentagem=$(echo "$porcentagem" | sed 'y/,/./')

		# Há um sinal no início?
		if test "${porcentagem#[+-]}" != "$porcentagem"
		then
			sinal=$(printf %c $porcentagem)  # pega primeiro char
			porcentagem=${porcentagem#?}     # remove primeiro char
		fi

		# Porcentagem fracionada
		if zztool testa_numero_fracionario "$porcentagem"
		then
			# Se o valor é inteiro (escala=0) e a porcentagem fracionária,
			# é preciso forçar uma escala para que o resultado apareça correto.
			test $escala -eq 0 && escala=2 valor1="$valor1.00"

		# Porcentagem inteira ou erro
		elif ! zztool testa_numero "$porcentagem"
		then
			echo "O valor da porcentagem deve ser um número. Exemplos: 2 ou 2,5."
			return 1
		fi

	# O segundo argumento é um número
	elif test $# -eq 2
	then
		# Ao mostrar a porcentagem entre dois números, a escala é fixa
		escala=2

		# O separador do segundo número é quem "manda" na saída
		# Sempre usar o ponto como separador interno (para os cálculos)

		# Número fracionário
		if zztool testa_numero_fracionario "$valor2"
		then
			separador=$(echo "$valor2" | tr -d 0-9)
			valor2=$(echo "$valor2" | sed 'y/,/./')

		# Número normal ou erro
		else
			zztool -e testa_numero "$valor2" || return 1
		fi
	fi

	# Ok. Dados coletados, analisados e formatados. Agora é hora dos cálculos.

	# Mostra tabela
	if test $# -eq 1
	then
		for i in $tabela
		do
			printf "%s%%\t%s\n" $i $(echo "scale=$escala; $valor1*$i/100" | bc)
		done

	# Mostra porcentagem
	elif test $# -eq 2
	then
		# Mostra a porcentagem relativa entre dois números
		if ! zztool grep_var % "$valor2"
		then
			echo "scale=$escala; $valor2*100/$valor1" | bc | sed 's/$/%/'

		# valor + n% é igual a…
		elif test "$sinal" = '+'
		then
			echo "scale=$escala; $valor1+$valor1*$porcentagem/100" | bc

		# valor - n% é igual a…
		elif test "$sinal" = '-'
		then
			echo "scale=$escala; $valor1-$valor1*$porcentagem/100" | bc

		# n% do valor é igual a…
		else
			echo "scale=$escala; $valor1*$porcentagem/100" | bc

			### Saída antiga, uma mini tabelinha
			# printf "%s%%\t%s\n" "+$porcentagem" $(echo "scale=$escala; $valor1+$valor1*$porcentagem/100" | bc)
			# printf "%s%%\t%s\n"  100          "$valor1"
			# printf "%s%%\t%s\n" "-$porcentagem" $(echo "scale=$escala; $valor1-$valor1*$porcentagem/100" | bc)
			# echo
			# printf "%s%%\t%s\n"  "$porcentagem" $(echo "scale=$escala; $valor1*$porcentagem/100" | bc)
			#
			# | sed "s/\([^0-9]\)\./\10./ ; s/^\./0./; y/./$separador/"
		fi
	fi |

	# Assegura 0.123 (em vez de .123) e restaura o separador original
	sed "s/^\./0./; y/./$separador/"
}

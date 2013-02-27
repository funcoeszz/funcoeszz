# ----------------------------------------------------------------------------
# Verifica se a data passada por parâmetro é um feriado ou não.
# Caso não seja passado nenhuma data é pego a data atual.
# Pode-se configurar a variável ZZFERIADO para os feriados regionais.
# O formato é o dd/mm:descrição, por exemplo: 20/11:Consciência negra.
# Uso: zzferiado -l [ano] | [data]
# Ex.: zzferiado 25/12/2008
#      zzferiado -l
#      zzferiado -l 2010
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2008-11-21
# Versão: 6
# Licença: GPLv2
# Requisitos: zzcarnaval zzcorpuschristi zzdiadasemana zzsextapaixao zzsemacento
# Tags: data
# ----------------------------------------------------------------------------
zzferiado ()
{
	zzzz -h feriado "$1" && return

	local feriados carnaval corpuschristi
	local hoje data sextapaixao ano listar
	local dia diasemana descricao linha

	hoje=$(date '+%d/%m/%Y')

	# Verifica se foi passado o parâmetro -l
	if [ "$1" = "-l" ]; then
		# Se não for passado $2 pega o ano atual
		ano=${2:-$(basename $hoje)}

		# Seta a flag listar
		listar=1

		# Teste da variável ano
		zztool -e testa_ano $ano || return 1
	else
		# Se não for passada a data é pega a data de hoje
		data=${1:-$hoje}

		# Verifica se a data é valida
		zztool -e testa_data "$data" || return 1

		# Uma coisa interessante, como data pode ser usada com /(20/11/2008)
		# podemos usar o basename e dirname para pegar o que quisermos
		# Ex.: dirname 25/12/2008 ->  25/12
		#      basename 25/12/2008 -> 2008
		#
		# Pega só o dia e o mes no formato: dd/mm
		data=$(dirname $data)
		ano=$(basename ${1:-$hoje})
	fi

	# Para feriados Estaduais ou regionais Existe a variável de
	# ambiente ZZFERIADO que pode ser configurada no $HOME/.bashrc e
	# colocar as datas com dd/mm:descricao
	carnaval=$(dirname $(zzcarnaval $ano ) )
	sextapaixao=$(dirname $(zzsextapaixao $ano ) )
	corpuschristi=$(dirname $(zzcorpuschristi $ano ) )
	feriados="01/01:Confraternização Universal $carnaval:Carnaval $sextapaixao:Sexta-ferida da Paixao 21/04:Tiradentes 01/05:Dia do Trabalho $corpuschristi:Corpu Christi 07/09:Independência do Brasil 12/10:Nossa Sra. Aparecida 02/11:Finados 15/11:Proclamação da República 25/12:Natal $ZZFERIADO"

	# Verifica se lista ou nao, caso negativo verifica se a data escolhida é feriado
	if [ "$listar" = "1" ]; then

		# Pega os dados, coloca 1 por linha, inverte dd/mm para mm/dd,
		# ordena, inverte mm/dd para dd/mm
		echo $feriados |
		sed 's# \([0-3]\)#~\1#g' |
		tr '~' '\n' |
		sed 's#^\(..\)/\(..\)#\2/\1#g' |
		sort -n |
		sed 's#^\(..\)/\(..\)#\2/\1#g' |
		while read linha; do
			dia=$(echo $linha | cut -d: -f1)
			diasemana=$(zzdiadasemana $dia/$ano | zzsemacento)
			descricao=$(echo $linha | cut -d: -f2)
			printf "%s %-15s %s\n" "$dia" "$diasemana" "$descricao" |
				sed 's/terca-feira/terça-feira/ ; s/ sabado / sábado /'
			# ^ Estou tirando os acentos do dia da semana e depois recolocando
			# pois o printf não lida direito com acentos. O %-15s não fica
			# exatamente com 15 caracteres quando há acentos.
		done
	else
		# Verifica se a data está dentro da lista de feriados
		# e imprime o resultado
		if zztool grep_var "$data" "$feriados"; then
			echo "É feriado: $data/$ano"
		else
			echo "Não é feriado: $data/$ano"
		fi
	fi

	return 0
}

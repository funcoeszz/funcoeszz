# ----------------------------------------------------------------------------
# Consulta a taxa SELIC no site do Banco Central.
# É possível consultar a taxa numa data específica ou num intervalo de datas.
# As taxas em todos os dias úteis no intervalo informado serão retornadas.
# As datas podem ser os "apelidos" da zzdata (hoje, ontem, anteontem etc).
# Você será avisado caso não haja um dia útil no intervalo informado.
# A saída pode ser formatada como uma tabela ou como CSV.
# É possível consultar apenas a taxa ou a taxa+estatísticas completas.
#
# Uso: zzselic [-c] [-e] [data inicial] [data final]
# Ex.: zzselic                    # qual a taxa SELIC hoje?
#      zzselic anteontem          # qual a taxa SELIC anteontem?
#      zzselic 05/11/1987         # qual a taxa SELIC dia 05/11/1987?
#      zzselic 01/06/2015 ontem   # quais as taxas entre dia 1/6/15 e ontem?
#      zzselic -e 05/11/1987      # estatísticas completas (média, moda etc)
#      zzselic -c 01/04/2015      # saída no formato CSV, delimitado por ;
#
# Autor: Guilherme Magalhães Gall <gmgall (a) gmail com>
# Desde: 2015-06-07
# Versão: 2
# Licença: GPL
# Requisitos: zzdata zzdiadasemana zzdos2unix zzferiado zzurlencode zzutf8 zzpad
# ----------------------------------------------------------------------------
# DESATIVADA: 2018-01-06 Página do Banco Central usando AJAX.
zzselic ()
{
	zzzz -h selic "$1" && return

	local url='http://www3.bcb.gov.br/selic/consulta/taxaSelic.do'
	local query='dataInicial=DI&dataFinal=DF&method=listarTaxaDiaria&tipoApresentacao=arquivo&Submit=++++Consultar++++'

	local estatisticas=0
	local csv=0

	local achei_dia_util=0
	local data_inicial
	local data_final
	local datas
	local i
	local saida
	local v1 v2 v3 v4 v5 v6 v7 v8 v9

	# Processa as opções de linha de comando
	# Todas que não começarem com '-' serão consideradas datas e validadas com zzdata
	while test -n "$1"
	do
		case "$1" in

			-e)	estatisticas=1 ;;
			-c)	csv=1 ;;
			-*)
				zztool erro "Opção $1 desconhecida"
				zztool -e uso selic
				return 1
			;;
			*)
				if zzdata "$1" > /dev/null
				then
					datas="$datas $1"
				else
					return 1
				fi
			;;
		esac
		shift
	done

	# Se nenhuma data foi fornecida, a taxa é a de hoje
	test -z "$datas" && datas="$(zzdata)"

	# A 1ª data fornecida pelo usuário é a inicial; a 2ª, a final; as demais, ignoradas
	# É seguro dizer que as datas aqui são válidas por causa da zzdata no case
	data_inicial=$(echo $datas | cut -d' ' -f1)
	data_final=$(echo $datas | cut -d' ' -f2)

	# Converte as datas fornecidas fora do formato (dd/mm/aaaa) para esse formato
	# Os apelidos da zzdata podem ser fornecidos ("ontem", "anteontem" etc.)
	zztool testa_data "$data_inicial" || data_inicial=$(zzdata "$data_inicial")
	zztool testa_data "$data_final" || data_final=$(zzdata "$data_final")

	# O site do BC só divulga dados a partir de 04/06/1986.
	# A data inicial é antes disso?
	if test $(zzdata "$data_inicial" - 04/06/1986) -lt 0
	then
		zztool erro "Dados disponíveis apenas a partir de 04/06/1986."
		return 1
	fi

	# A data inicial é anterior à data final?
	if test $(zzdata "$data_inicial" - "$data_final") -gt 0
	then
		zztool erro "Data inicial depois da final."
		return 1
	fi

	# Alguma das datas está no futuro?
	if test $(zzdata "$data_inicial" - hoje) -gt 0
	then
		zztool erro "Data inicial no futuro."
		return 1
	fi

	if test $(zzdata "$data_final" - hoje) -gt 0
	then
		zztool erro "Data final no futuro."
		return 1
	fi

	# Existem dias úteis no intervalo?
	# O site do BC tenta "ajudar" o usuário fornecendo o dia útil subsequente
	# caso a data inicial seja dia não útil. Também faz isso com a data final.
	# No site, tem-se o aviso de que dias subsequentes foram retornados e o
	# usuário pode decidir se usa esse resultado ou se faz nova requisição.
	#
	# Numa ZZ, que pode estar sendo usada por um script ou outra ZZ, esse
	# comportamento pode induzir a erros. Um exemplo é se o usuário consultar
	# o intervalo de 18/04/2014 a 20/04/2014. O site fornecerá como resposta
	# apenas o dia 22/04/2014, 2 dias depois da data final do intervalo
	# desejado, porque dia 18 e 21 foram feriados e 19 e 20 foram final
	# de semana.
	#
	# Por isso, informa-se explicitamente ao usuário caso o intervalo não
	# contenha dias úteis.
	for i in $(seq $(zzdata $data_inicial) $(zzdata $data_final))
	do
		dia_da_semana=$(zzdiadasemana $(zzdata $i))
		if zztool grep_var 'Não é feriado' "$(zzferiado $(zzdata $i))" && \
		test "$dia_da_semana" != 'sábado' -a "$dia_da_semana" != 'domingo'
		then
			achei_dia_util=1
			break
		fi
	done

	if test "$achei_dia_util" -eq 0
	then
		zztool erro "Não há dias úteis entre as datas informadas."
		return 1
	fi

	# Substitui 'DI' e 'DF' na query pela data inicial e final
	query=$(echo "$query" | sed "s|DI|$(zzurlencode $data_inicial)|; s|DF|$(zzurlencode $data_final)|")

	# Faz a consulta ao site do BC e limpa a saída.
	saida=$(zztool post "$url" "$query" | zzutf8 | zzdos2unix | sed '1d')

	# A data final é dia útil? Se não for, o comportamento do site de retornar
	# o dia útil subsequente vai causar problemas novamente...
	#
	# ...se o próximo dia útil estiver no futuro, ele virá no resultado com uma
	# taxa de -100,00. Exemplo: o usuário fez a consulta num sábado usando como
	# data final "hoje". O site retornará a segunda-feira com taxa de -100,00
	saida=$(echo "$saida" | sed '/-100,00/d; s/;$//')

	# ...se o dia útil subsequente à data final estiver no passado, ele será
	# retornado mesmo não estando no intervalo pedido pelo usuário.
	# Exemplo: a data final é 31/01/2015 (sábado) e o dia 02/02/2015 (segunda)
	# é retornado. Abaixo, certifica-se que a última data na resposta não seja
	# depois da data final.
	#
	# Mas não é tão simples quanto verificar se o 1º campo na última linha é
	# depois da data final. O tal "-100,00" pode vir como taxa na data atual,
	# mesmo sendo dia útil e não estando no futuro, se a taxa ainda não foi
	# divulgada. Isso é um problema se o usuário solicitou apenas a taxa de
	# hoje.
	#
	# Se for esse o caso, a linha com a data atual já foi excluída pelo sed
	# acima e só sobrou a linha com o cabeçalho.
	#
	# Então eu verifico se existe alguma coisa além do cabeçalho e aí sim
	# removo a última linha se ela tiver numa data depois da data final.
	#
	# Eu poderia simplificar ignorando a taxa do dia corrente, mas se a
	# informação está disponível eu quero informar ao usuário, ora. :-)
	if test $(echo "$saida" | wc -l) -ne 1;
	then
		test $(zzdata $(echo "$saida" | sed -n '$p' | cut -d\; -f1) - "$data_final") -gt 0 && \
		saida=$(echo "$saida" | sed '$d')
	fi

	# Mostrar as estatísticas completas ou apenas a taxa?
	if test "$estatisticas" -eq 0
	then
		saida=$(echo "$saida" | cut -d\; -f1,2)
	fi

	# Mostrar em colunas ou CSV (como vem do site)?
	if test "$csv" -eq 0
	then
		saida=$(
			echo "$saida" |
			if test "$estatisticas" -eq 0
			then
				while IFS=';' read v1 v2
				do
					echo "$(zzpad 11 $v1) $v2"
				done
			else
				while IFS=';' read v1 v2 v3 v4 v5 v6 v7 v8 v9
				do
					echo "$(zzpad 11 $v1) $(zzpad 13 $v2) $(zzpad 13 $v3) $(zzpad 21 $v4) $(zzpad 6 $v5) $(zzpad 8 $v6) $(zzpad 6 $v7) $(zzpad 14 $v8) $v9"
				done
			fi
		)
	fi

	# Mostra a saída
	echo "$saida"
}

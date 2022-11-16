# ----------------------------------------------------------------------------
# Consulta a taxa SELIC no site do Banco Central.
# É possível consultar a taxa numa data específica ou num intervalo de datas.
# As taxas em todos os dias úteis no intervalo informado serão retornadas.
# As datas podem ser os "apelidos" da zzdata (hoje, ontem, anteontem etc).
# Você será avisado caso não haja um dia útil no intervalo informado.
# A saída pode ser formatada como uma tabela ou como CSV.
#
# Uso: zzselic [-c] [data inicial] [data final]
# Ex.: zzselic                    # qual a taxa SELIC hoje?
#      zzselic anteontem          # qual a taxa SELIC anteontem?
#      zzselic 05/11/1987         # qual a taxa SELIC dia 05/11/1987?
#      zzselic 01/06/2015 ontem   # quais as taxas entre dia 1/6/15 e ontem?
#      zzselic -c 01/04/2015      # saída no formato CSV, delimitado por ;
#
# Autor: Guilherme Magalhães Gall <gmgall (a) gmail com>
# Desde: 2015-06-07
# Versão: 3
# Requisitos: zzzz zztool zzdata zzdiadasemana zzdos2unix zzferiado zzurlencode zzutf8 zzpad
# Tags: internet
# ----------------------------------------------------------------------------
zzselic ()
{
	zzzz -h selic "$1" && return

	local url='http://api.bcb.gov.br/dados/serie/bcdata.sgs.1178/dados?formato=csv'
	local query='&dataInicial=DI&dataFinal=DF'

	local csv=0

	local achei_dia_util=0
	local data_inicial
	local data_final
	local datas
	local i
	local saida
	local v1 v2

	# Processa as opções de linha de comando
	# Todas que não começarem com '-' serão consideradas datas e validadas com zzdata
	while test -n "$1"
	do
		case "$1" in

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
	#
	# Informa-se explicitamente ao usuário caso o intervalo não
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

	# Faz a consulta ao site do BC, limpa a saída e remove o cabeçalho.
	#
	# O cabeçalho original é apenas "data";"valor".
	saida=$(zztool source "$url$query" | zzutf8 | zzdos2unix | sed 's/"//g; 1d')

	# Insere um cabeçalho mais informativo
	saida=$(
		echo 'Data;Taxa (%a.a.)'
		echo "$saida"
	)

	# Mostrar em colunas ou CSV (como vem do site)?
	if test "$csv" -eq 0
	then
		saida=$(
			echo "$saida" |
				while IFS=';' read -r v1 v2
				do
					echo "$(zzpad 11 $v1) $v2"
				done
		)
	fi

	# Mostra a saída
	echo "$saida"
}

# ----------------------------------------------------------------------------
# Mostra qual o dia da semana de uma data qualquer.
# Com a opção -n mostra o resultado em forma numérica (domingo=1).
# Obs.: Se a data não for informada, usa a data atual.
# Uso: zzdiadasemana [-n] [data]
# Ex.: zzdiadasemana
#      zzdiadasemana 31/12/2010          # sexta-feira
#      zzdiadasemana -n 31/12/2010       # 6
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2008-10-24
# Versão: 3
# Licença: GPL
# Requisitos: zzdata
# Tags: data
# ----------------------------------------------------------------------------
zzdiadasemana ()
{
	zzzz -h diadasemana "$1" && return

	local data delta dia
	local dias="quinta- sexta- sábado domingo segunda- terça- quarta-"
	local dias_rev="quinta- quarta- terça- segunda- domingo sábado sexta-"
	local dias_n="5 6 7 1 2 3 4"
	local dias_n_rev="5 4 3 2 1 7 6"
	# 1=domingo, assim os números são similares aos nomes: 2=segunda

	# Opção de linha de comando
	if test "$1" = '-n'
	then
		dias="$dias_n"
		dias_rev="$dias_n_rev"
		shift
	fi

	data="$1"

	# Se a data não foi informada, usa a atual
	test -z "$data" && data=$(date +%d/%m/%Y)

	# Validação
	zztool -e testa_data "$data" || return 1

	# O cálculo se baseia na data ZERO (01/01/1970), que é quinta-feira.
	# Basta dividir o delta (intervalo de dias até a data ZERO) por 7.
	# O resto da divisão é o dia da semana, sendo 0=quinta e 6=quarta.
	#
	# A função zzdata considera 01/01/1970 a data zero, e se chamada
	# apenas com uma data, retorna o número de dias de diferença para
	# o dia zero. O número será negativo se o ano for inferior a 1970.
	#
	delta=$(zzdata $data)
	dia=$(( ${delta#-} % 7))  # remove o sinal negativo (se tiver)

	# Se a data é anterior a 01/01/1970, conta os dias ao contrário
	test $delta -lt 0 && dias="$dias_rev"

	# O cut tem índice inicial um e não zero, por isso dia+1
	echo "$dias" |
		cut -d ' ' -f $((dia+1)) |
		sed 's/-/-feira/'
}

# ----------------------------------------------------------------------------
# Calcula o número de dias úteis entre duas datas, inclusive ambas.
# Chamada sem argumentos, mostra os total de dias úteis no mês atual.
# Obs.: Não leva em conta feriados.
#
# Uso: zzdiasuteis [data-inicial data-final]
# Ex.: zzdiasuteis                          # Fevereiro de 2013 tem 20 dias …
#      zzdiasuteis 01/01/2011 31/01/2011    # 21
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-20
# Versão: 2
# Licença: GPL
# Requisitos: zzdata zzdiadasemana zzdatafmt zzcapitalize
# Tags: data, cálculo
# ----------------------------------------------------------------------------
zzdiasuteis ()
{
	zzzz -h diasuteis "$1" && return

	local data dias dia1 semanas avulsos ini fim hoje mes ano
	local avulsos_uteis=0
	local uteis="0111110"  # D S T Q Q S S
	local data1="$1"
	local data2="$2"

	# Verificação dos parâmetros
	if test $# -eq 0
	then
		# Sem argumentos, calcula para o mês atual
		# Exemplo para fev/2013: zzdiasuteis 01/02/2013 28/02/2013
		hoje=$(zzdata hoje)
		data1=$(zzdatafmt -f 01/MM/AAAA $hoje)
		data2=$(zzdata $(zzdata $data1 + 1m) - 1)
		mes=$(zzdatafmt -f MES $hoje | zzcapitalize)
		ano=$(zzdatafmt -f AAAA $hoje)
		echo "$mes de $ano tem $(zzdiasuteis $data1 $data2) dias úteis."
		return 0

	elif test $# -ne 2
	then
		zztool uso diasuteis
		return 1
	fi

	# Valida o formato das datas
	zztool -e testa_data "$data1" || return 1
	zztool -e testa_data "$data2" || return 1

	# Quantos dias há entre as duas datas?
	dias=$(zzdata $data2 - $data1)

	# O usuário inverteu a ordem das datas?
	if test $dias -lt 0
	then
		# Tudo bem, a gente desinverte.
		dias=$((0 - $dias))  # abs()
		data=$data1
		data1=$data2
		data2=$data
	fi

	# A zzdata conta a diferença, então precisamos fazer +1 para incluir
	# ambas as datas no resultado.
	dias=$((dias + 1))

	# Qual dia da semana cai a data inicial?
	dia1=$(zzdiadasemana -n $data1)  # 1=domingo

	# Quantas semanas e quantos dias avulsos?
	semanas=$((dias / 7))
	avulsos=$((dias % 7))

	# Dos avulsos, quantos são úteis?
	#
	# Montei uma matriz de 14 posições ($uteis * 2) que contém 0's
	# e 1's, sendo que os 1's marcam os dias úteis. Faço um recorte
	# nessa matriz que inicia no $dia1 e tem o tamanho do total de
	# dias avulsos ($avulsos, max=6). As variáveis $ini e $fim são
	# usadas no cut e traduzem este recorte. Por fim, removo os
	# zeros e conto quantos 1's sobraram, que são os dias úteis.
	#
	if test $avulsos -gt 0
	then
		ini=$dia1
		fim=$(($dia1 + $avulsos - 1))
		avulsos_uteis=$(
			echo "$uteis$uteis" |
			cut -c $ini-$fim |
			tr -d 0)
		avulsos_uteis=${#avulsos_uteis}  # wc -c
	fi

	# Com os dados na mão, basta calcular
	echo $(($semanas * 5 + $avulsos_uteis))
}

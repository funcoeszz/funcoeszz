# ----------------------------------------------------------------------------
# Faz calculos com datas e/ou converte data->num e num->data.
# Que dia vai ser daqui 45 dias? Quantos dias ha entre duas datas? zzdata!
# Quando chamada com apenas um parametro funciona como conversor de data
# para numero inteiro (N dias passados desde Epoch) e vice-versa.
# A zzdata pode subtrair, ou somar meses e anos tambem. Eh so especificar!
# Obs.: Leva em conta os anos bissextos     (Epoch = 01/01/1970, editavel)
# Opcoes:
#         data|num  data inicial.
#         +|-       operacao a realizar (adicao|subtracao).
#         D|M|Y     unidade em operacao com numero (D=dia, M=mes, Y=ano).
# Uso: zzdata2 data|num [+|- data|num [D|M|Y]]
# Ex.: zzdata2 22/12/1999 + 69
#      zzdata2 hoje - 5
#      zzdata2 01/03/2000 - 11/11/1999
#      zzdata2 hoje - dd/mm/aaaa         <---- use sua data de nascimento
#      zzdata2 01/03/2000 - 1 M          # subtrai 1 mes. resp: 01/02/2000
#      zzdata2 30/03/2008 - 1 M          # resp: 19/02/2008 (ano bissexto)
#
# Autor: Aurélio Marinho Jargas, www.aurelio.net, modificada por Lauro de Sá
# Desde: 2010-05-26
# Versão: 20091010
# Licença: GPLv2
# ----------------------------------------------------------------------------
# DESATIVADA: 2011-05-19 Funcionalidades implementadas na zzdata original.
zzdata2 ()
{
	zzzz -h data2 $1 && return

	local yyyy mm dd dias_ano data dias i n y op muda_ano
	local epoch=1970
	local primeira_data=1
	local dias_mes='31 28 31 30 31 30 31 31 30 31 30 31'
	local data1=$1
	local operacao=$2
	local data2=$3
	local n1=$data1
	local n2=$data2
	local tipo=$4
	
	# Verificacao dos parametros
	# Alterado o numero de parametros para ate 4.
	# Porem, para manter a compatibilidade com versoes anteriores, aceita-se 3.
	# Ou seja, para somar ou subtrair dias nao precisa informar "d".
	[ $# -eq 3 -o $# -eq 1 -o $# -eq 4 ] || { zztool uso data2; return 1; }

	# Esse bloco gigante define $n1 e $n2 baseado nas datas $data1 e $data2.
	# A data eh transformada em um numero inteiro (dias desde $epoch).
	# Exemplo: 27/07/2007 -> 13721
	# Este eh numero usado para fazer os calculos.
	for data in $data1 $data2
	do
		dias=0 # Guarda o total que ira para $n1 e $n2
		
		# Atalhos uteis para o dia atual
		if [ "$data" = 'hoje' -o "$data" = 'today' ]
		then
			# Qual a data de hoje?
			data=$(date +%d/%m/%Y)
			[ "$primeira_data" ] && data1=$data || data2=$data
		else
			# Valida o formato da data
			if ! ( zztool testa_data "$data" || zztool testa_numero "$data" )
			then
				echo "Data invalida '$data', deve ser dd/mm/aaaa"
				return 1
			fi
		fi
		
		# Se tem /, entao e uma data e deve ser transformado em numero
		if zztool grep_var / "$data"
		then
			n=1
			y=$epoch
			yyyy=${data##*/}
			mm=${data#*/}
			mm=${mm%/*}
			dd=${data%%/*}

			# Retira o zero dos dias e meses menores que 10
			mm=${mm#0}
			dd=${dd#0}

			# Define qual sera a operacao: adicao ou subtracao
			op=+
			[ $yyyy -lt $epoch ] && op=-
			
			# Ano -> dias
			while :
			do
				# Sim, os anos bissextos sao levados em conta!
				dias_ano=365
				zztool testa_ano_bissexto ${y} && dias_ano=366
				
				# Vai somando (ou subtraindo) ate chegar no ano corrente
				[ $y -eq $yyyy ] && break
				dias=$((dias $op dias_ano))
				y=$((y $op 1))
			done
			
			# Meses -> dias
			for i in $dias_mes
			do
				[ $n -eq $mm ] && break
				n=$((n+1))
				
				# Fevereiro de ano bissexto tem 29 dias
				[ $dias_ano -eq 366 -a $i -eq 28 ] && i=29
				
				dias=$((dias+$i))
			done
			
			# Somando os dias da data aos anos+meses ja contados (-1)
			dias=$((dias+dd-1))
			
			[ "$primeira_data" ] && n1=$dias || n2=$dias
			
		else
			# Esta parte eh responsavel pela subtracao de meses ou anos.
			# Para isto, o usuario deve informar o terceiro parametro
			# como um numero.
			if [ "$primeira_data" != 1 ] ; then
				# Determinando o tipo de operacao (dia, mes, ou ano)
				case "${tipo}" in
					"m" | "M" | "y" | "Y")
						data2=`zzdata "$n1"`
						dd=`echo "$data2" | cut -c1-2`
						mm=`echo "$data2" | cut -c4-5`
						yyyy=`echo "$data2" | cut -c7-10`
						i=1
						while [ $i -le $n2 ]
						do
							case "${tipo}" in
							"m" | "M")
								muda_ano=1
								[ $mm -eq 1  -a "$operacao" = "-" ] && muda_ano=0 mm="12"
								[ $mm -eq 12 -a "$operacao" = "+" ] && muda_ano=0 mm="01"
								
								if [ "$muda_ano" = 1 ] ; then
									mm=`expr $mm $operacao 1`
									[ $mm -lt 10 ] && mm="0$mm"
								else
									yyyy=`expr $yyyy $operacao 1`
								fi
								;;
							"y" | "Y")	yyyy=`expr $yyyy $operacao 1`;;
							esac
							i=$((i+1))
						done
						
						# Verifica mes de fevereiro.
						if [ $mm -eq 2 -a $dd -gt 28 ] ; then
							zztool testa_ano_bissexto "$yyyy" && dd="29" || dd="28"
						fi
						
						# Verifica se o dia 31 existe no mes.
						if [ $dd -eq 31 ] ; then
							case "${mm}" in
								"04" | "06" | "09" | "11") dd="30";;
							esac
						fi
						
						data1="$dd/$mm/$yyyy"
						n1=`zzdata "$data1"`
						data2=0
						n2=0
						;;
				esac
			fi
		fi
		primeira_data=
	done
	

	
	# Agora que ambas as datas sao numeros inteiros, a conta e feita
	dias=$(($n1 $operacao $n2))
	
	# Se as duas datas foram informadas como dd/mm/aaaa,
	# o resultado e o proprio numero de dias, entao terminamos.
	if [ "${data1##??/*}" = "${data2##??/*}" ]
	then
		echo $dias
		return
	fi
	
	# Como nao caimos no IF anterior, entao o resultado sera uma data.
	# e preciso converter o numero inteiro para dd/mm/aaaa.
	
	y=$epoch
	mm=1
	dd=$((dias+1))
	
	# Dias -> Ano
	while :
	do
		# Novamente, o ano bissexto e levado em conta
		dias_ano=365
		zztool testa_ano_bissexto ${y} && dias_ano=366
		
		# Vai descontando os dias de cada ano para saber quantos anos cabem
		[ $dd -le $dias_ano ] && break
		dd=$((dd-dias_ano))
		y=$((y+1))
	done
	yyyy=$y
	
	# Dias -> mes
	for i in $dias_mes
	do
		# Fevereiro de ano bissexto tem 29 dias
		[ $dias_ano -eq 366 -a $i -eq 28 ] && i=29
	
		# Calcula quantos meses cabem nos dias que sobraram
		[ $dd -le $i ] && break
		dd=$((dd-i))
		mm=$((mm+1))
	done
	
	# Restaura o zero dos meses menores que 10
	[ $dd -le 9 ] && dd=0$dd
	[ $mm -le 9 ] && mm=0$mm
	
	# E finalmente mostra o resultado em formato de data
	echo $dd/$mm/$yyyy
}

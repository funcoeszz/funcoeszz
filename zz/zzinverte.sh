# ----------------------------------------------------------------------------
# Inversor de números inteiros.
# Ex.: zzinverte 1234               # Retorna: 4321
#      zzinverte -4509               # Retorna: -9054
#
# Autor: Rafael Nascimento de Sousa <rafaelsousa2187 (a) gmail com>
# Desde: 2017-07-03
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzinverte ()
{
	#Verificação dos parâmetros.
	test -n "$1" || { zztool -e uso inverte; return 1; }
	zzzz -h inverte "$1" && return
	
local valor=$1
local aux=0
	#Pega o número do valor sem sinal.
	zzmat ads $valor
	
	#ciclo repete até que valor seja menor que zero. 
	while test $valor != 0 
	do
		#Ajuda a armazenar os valores que vem do mod(resto da divisão) e a cada ciclo uma casa decimal é acrescentada ao valor.
      		aux=$((aux * 10)) 
		#O auxiliar recebe o valor anterior mais o mod do valor por 10.
        	aux=$[$aux + ($valor % 10)] 
		#E ao final de cada ciclo, o valor é dividido por dez até ficar menor que zero.
        	valor=$((valor / 10)) 
    	done
	valor=$aux
    	echo "Resposta: $valor"
}

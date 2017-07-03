#!/bin/bash
source /usr/bin/funcoeszz   # inclui o ambiente ZZ.
ZZPATH=$PWD/chaves.sh       # o PATH desse script
# ----------------------------------------------------------------------------
# Inversor de números inteiros.
# Ex.: zzinverter 1234               # Retorna: 4321
#      zzinverter -4509               # Retorna: -9054
#
# Autor: Rafael Nascimento de Sousa <rafaelsousa2187 (a) gmail com>
# Desde: 2017-07-03
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzinverte ()
{
	zzzz -h inverte "$1" && return
	
local valor=$1
local aux=0

#Testa se o valor é positivo.
if test $valor -ge 0; 
then
	while test $valor != 0 #ciclo repete até que valor seja menor que zero. 
	do
      	aux=$((aux * 10)) #Ajuda a armazenar os valores que vem do mod(resto da divisão) e a cada ciclo uma casa decimal é acrescentada ao valor.
        aux=$[$aux + ($valor % 10)] #O auxiliar recebe o valor anterior mais o mod do valor por 10
        valor=$((valor / 10)) #E ao final de cada ciclo, o valor é dividido por dez até ficar menor que zero.
    done
	valor=$aux
    echo "Resposta: $valor"
    
#Caso o valor não seja maior ou igual a zero.    
else
    #Transforma o valor para positivo.
    valor=$[$valor*(-1)]
    while test $valor != 0
	do
      	aux=$((aux * 10))
        aux=$[$aux + ($valor % 10)]
        valor=$((valor / 10))
    done
    #Transforma o valor em negativo.
    valor=$[$aux*(-1)]
    echo "Resposta: $valor"
fi 
}

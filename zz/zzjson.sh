#!/bin/bash

#------------------------------------------------------------------------------
#Parser de arquivos JSON.
#Não passando argumentos a função retorna o documento inteiro
#Passando um argumento a função retorna apenas os campos onde aquele argumento foi encontrado.
#Passando um argumento com notação de ponto a função retorna o campo de um objeto.
#Uso: cat [arquivo].json | zzjson [argumento]
#Ex: cat carro.json | zzjson marca

#Autor: Abner Cardoso da Silva, @abner.cardo@gmail.com
#Desde: 2017-07-04
#Versão: 1
#Licença GPL
#------------------------------------------------------------------------------

zzjson ()
{

	zzzz -h json "$1" && return

	local ARGUMENTO="$1"
	local ARQUIVO_JSON
	local ARGUMENTO_DIVIDIDO=""
	local RESULTADO="" 

	#Converte aquivo para string
	while read -r LINHA; do
		
		ARQUIVO_JSON="$ARQUIVO_JSON
$LINHA"
	
	done
	
	#Verifica se foi inserido algum argumento
	if [ -z $ARGUMENTO ]; then
		echo "$ARQUIVO_JSON" | 
		tr -d { | 
		tr -d } | 
		tr -d '"' | 
		tr -d , | 
		sed '/^$/d'
	else
		#Verifica o uso de notação de ponto
		if [[ $ARGUMENTO == *"."* ]]; then
			
			#Divide o argumento
			ARGUMENTO_DIVIDIDO=$( echo $ARGUMENTO | 
			tr '.' ' ')
			
			for PALAVRA in $ARGUMENTO_DIVIDIDO; do
				RESULTADO=$RESULTADO$( echo "$ARQUIVO_JSON" | 
				tr -d '",' | 
				sed 's/: {/./g' | 
				grep $PALAVRA)
			done
	
			echo $RESULTADO;
			
		else
			#Imprime o cambo relacionado ao argumento
			echo "$ARQUIVO_JSON" | 
			tr -d '"' | 
			tr -d , | 
			grep -i $ARGUMENTO
		fi
	fi
}

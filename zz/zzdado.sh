#!/bin/bash

source /usr/bin/funcoeszz
ZZPATH=$PWD/zzdado.sh

# ----------------------------------------------------------------------------
# Dado Virtual - Exibe um número aleatório entre 1 e 6
# Uso: zzdado
# Ex.: zzdado
#
# Autor: Angelito M. Goulart, www.angelitomg.com
# Desde: 2012-12-05
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzdado()
{
	
	# Comando especial das funcoes ZZ
	zzzz -h dado "$1" && return	

	# Gera e exibe um numero aleatorio entre 1 e 6
	echo "$((($RANDOM % 6) + 1))"

}

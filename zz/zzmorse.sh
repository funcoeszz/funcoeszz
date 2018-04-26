#!/bin/bash
# ----------------------------------------------------------------------------
# Conversor de código morse.
#
# Uso: zzmorse [string]
# Ex.: zzaleatorio alfredo
#      zzaleatorio ... --- ...
#
# Autor: Alfredo Casanova <atcasanova (a) gmail com>
# Desde: 2018-04-26
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------


zzmorse(){
	match_pattern="^[ \.\-]+$"
	[[ $* =~ $match_pattern ]] && input=morse || input=text

	if [[ "$input" == "morse" ]]; then
		declare -A morse=( [.-]=A  [-...]=B  [-.-.]=C  [-..]=D  [.]=E  [..-.]=F  [--.]=G  [....]=H  [..]=I  [.---]=J  [-.-]=K  [.-..]=L  [--]=M  [-.]=N  [---]=O  [.--.]=P  [--.-]=Q  [.-.]=R  [...]=S  [-]=T  [..-]=U  [...-]=V  [.--]=W  [-..-]=X  [-.--]=Y  [--..]=Z  [-----]=0  [.----]=1  [..---]=2  [...--]=3  [....-]=4  [.....]=5  [-....]=6  [--...]=7  [---..]=8  [----.]=9 )
		for i in $*; do
			echo -n "${morse[$i]}"
		done
		echo
	else
		declare -A tomorse=( [A]=.- [B]=-... [C]=-.-. [D]=-.. [E]=. [F]=..-. [G]=--. [H]=.... [I]=.. [J]=.--- [K]=-.- [L]=.-.. [M]=-- [N]=-. [O]=--- [P]=.--. [Q]=--.- [R]=.-. [S]=... [T]=- [U]=..- [V]=...- [W]=.-- [X]=-..- [Y]=-.-- [Z]=--.. [0]=----- [1]=.---- [2]=..--- [3]=...-- [4]=....- [5]=..... [6]=-.... [7]=--... [8]=---.. [9]=----. )
		texto="$*"
		for (( i=0; i<${#texto}; i++ )); do
			char=${texto:$i:1}
			echo -n "${tomorse[${char^^}]} ";
		done
		echo
	fi
}

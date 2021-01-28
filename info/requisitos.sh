#!/bin/bash
# Lista dependências e dependentes de cada função

cd "$(dirname "$0")/.." || exit 1  # go to repo root

{
	fzz=$(ls zz/*.sh | sed 's|.*/||;s/\.sh//')
	requisitos=$(grep 'Requisitos: ' zz/*.sh | sed 's|.*/||;s/\.sh.*:/:/')

	echo "$fzz" |
	while read arq
	do
		unset dependentes
		echo "$arq"
		echo "$requisitos" | sed -n "/^$arq:/{s/.*://; s/^/Requisitos: /; p;}"
		dependentes=$(echo "$requisitos" | grep -E " \<${arq}\>" | cut -d: -f1 | tr '\n' ' ')
		test -n "$dependentes" && echo "Dependentes: $dependentes"
		echo
	done |
	grep --color=none -B 1 ':' |
	if test -n "$1"
	then
		sed -n "/^$1$/,/--/p"
	else
		cat -
	fi |
	sed 's/--//'
} |
fmt -s -w "$(tput cols)"

#!/bin/bash
# Listar dependências e dependentes de cada função
#
	cd $(dirname "$0") || exit 1

	if test "$1" = "zztool" -o "$1" = "tool"
	then
		fzz=$(sed -n '/^zztool/,/simplesmente ignoradas$/{/^		[a-z]/!d;/\(uso\|\erro\))/d;s/	*//;s/)//;s/ | /\
/g;p;}' ../funcoeszz)
		test -n "$2" -a "$2" = "--listar" && { echo "$fzz"; exit; }

		requisitos=$(
			grep -o -E 'zztool (-e )?[[:alnum:]_]+' ../zz/*.sh |
			sed '/ uso/d;s|.*/||;s/\.sh.*:zztool\( -e\)*/:/' | sort | uniq
		)

		echo "$fzz" |
		while read arq
		do
			unset dependentes
			echo "$arq"
			dependentes=$(echo "$requisitos" | grep -E " \<${arq}\>" | cut -d: -f1 | tr '\n' ' ')
			test -n "$dependentes" && echo "Dependentes: $dependentes"
			echo
		done |
		if test -n "$2"
		then
			grep --color=none -A 1 "^$2$"
		else
			cat -
		fi
	else
		fzz=$(ls ../zz/*.sh | sed 's|.*/||;s/\.sh//')
		requisitos=$(grep 'Requisitos: ' ../zz/*.sh | sed 's|.*/||;s/\.sh.*:/:/')

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
	fi |
	fmt -s -w $(tput cols)

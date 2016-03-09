#!/bin/bash
# Exibe a quantidade de linhas das funcoeszz
#
	cd $(dirname "$0") || exit 1

	dir='zz'
	case "$1" in
		tod[ao]s) dir='tudo'; shift;;
		off)      dir='off';  shift;;
	esac

	case $dir in
		zz)
			for arq in ../zz/*.sh
			do
				awk 'END {printf "%4d %s\n", NR, FILENAME}' $arq
			done
		;;
		off)
			for arq in ../off/*.sh
			do
				awk 'END {printf "%4d %s\n", NR, FILENAME}' $arq
			done
		;;
		tudo)
			for arq in ../{zz,off}/*.sh
			do
				awk 'END {printf "%4d %s\n", NR, FILENAME}' $arq
			done
		;;
	esac |
	sed 's|\..*/||;s/\.sh//' |
	grep --color=none -i "${1:-.}"

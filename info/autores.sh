#!/bin/bash
# Listar e datar as funcoeszz e seus autores
#
	cd "$(dirname "$0")" || exit 1

	dir='zz'
	case "$1" in
		tod[ao]s) dir='tudo'; shift;;
		off)      dir='off';  shift;;
	esac

	case $dir in
		zz  ) grep -E '# (Autor|Desde): ' ../zz/*.sh       ;;
		off ) grep -E '# (Autor|Desde): ' ../off/*.sh      ;;
		tudo) grep -E '# (Autor|Desde): ' ../{zz,off}/*.sh ;;
	esac |
	sed 's|.*/zz|zz|; s/\.sh//; s/#.*: //; s/\(, \| [(<]\).*//' |
	awk -F : '
		NR % 2 == 1 {autor = $2 }
		NR % 2 == 0 { print $2, $1 "\t" autor}
	' |
	sort -n |
	grep -i "${1:-.}" |
	expand -t 30

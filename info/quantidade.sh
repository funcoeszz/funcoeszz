#!/bin/bash
# Listar e quantificar as funcoeszz por autor ou ano
#
	cd "$(dirname "$0")" || exit 1

	dir='zz'
	case "$1" in
		tod[ao]s) dir='tudo'; shift;;
		off)      dir='off';  shift;;
	esac

	if test -z "$1" -o "$1" = "ano"
	then
		case $dir in
			zz  ) grep '# Desde: ' ../zz/*.sh       ;;
			off ) grep '# Desde: ' ../off/*.sh      ;;
			tudo) grep '# Desde: ' ../{zz,off}/*.sh ;;
		esac |
		sed 's/.*: //;s/-.*//' |
		sort -n | uniq -c |
		awk ' BEGIN { print "## Ano" }; { printf "%02d %d\n", $1, $2 } '
	elif test "$1" = "autores" -o "$1" = "autor"
	then
		case $dir in
			zz  ) sed -n '/Autor: / { s/#.*: //; s/\(, \| [(<]\).*//; p; }' ../zz/*.sh       ;;
			off ) sed -n '/Autor: / { s/#.*: //; s/\(, \| [(<]\).*//; p; }' ../off/*.sh      ;;
			tudo) sed -n '/Autor: / { s/#.*: //; s/\(, \| [(<]\).*//; p; }' ../{zz,off}/*.sh ;;
		esac |
		awk '
			{linha[$0]++}
			END {for (i in linha) printf "%02d %s\n", linha[i], i }
		' |
		sort -k2 -nr |
		awk ' BEGIN { print "## Autor" }; 1'
	fi

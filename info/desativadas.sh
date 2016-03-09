#!/bin/bash
# Listar e datar funçoes desativadas
#
	cd $(dirname "$0") || exit 1

	grep 'DESATIVADA:' ../off/*.sh |
	sed 's|.*/zz|zz|; s/\.sh:# DESATIVADA:/\t/' |
	expand -t 18

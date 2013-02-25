#!/bin/bash
# 2013-02-25
# Aurelio Marinho Jargas
#
# Wrapper to run checkbashisms.pl in Funções ZZ files

cd $(dirname "$0")
cd ..

eco() { echo -e "\033[36;1m$*\033[m"; }

for f in zz/*
do
	eco ----------------------------------------------------------------
	eco $f
	echo '#!/bin/sh' > _tmp
	cat $f >> _tmp
	util/checkbashisms.pl _tmp
done
rm _tmp

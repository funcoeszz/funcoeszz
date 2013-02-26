#!/bin/bash
# 2013-02-25
# Aurelio Marinho Jargas
#
# Wrapper to run checkbashisms.pl in Funções ZZ files
#
# Lastest version of checkbashisms.pl script:
# http://anonscm.debian.org/gitweb/?p=devscripts/devscripts.git;a=tree;f=scripts;hb=HEAD
# Man page:
# http://manpages.ubuntu.com/manpages/lucid/man1/checkbashisms.1.html

cd $(dirname "$0")
cd ..

eco() { echo -e "\033[36;1m$*\033[m"; }

for f in zz/*
do
	eco ----------------------------------------------------------------
	eco $f
	echo '#!/bin/sh' > _tmp
	cat $f >> _tmp
	util/checkbashisms.pl -n --extra _tmp
done
rm _tmp

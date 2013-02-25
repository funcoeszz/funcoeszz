#!/bin/bash
# 2012-03-28
# Aurelio Marinho Jargas
#
# *** EXPERIMENTAL ***

# TODO receber arquivo individual via argumentos

cd $(dirname "$0") || exit 1
cd ..

eco() { echo -e "\033[36;1m$*\033[m"; }

eco ----------------------------------------------------------------
eco '* Evite usar $@, use zztool file_stdin (ou multi_stdin) quando cabível'
eco '*** Troque: sed "s/foo/bar/" "$@"'
eco '*** Por   : zztool file_stdin "$@" | sed "s/foo/bar/"'

grep '${*@' funcoeszz zz/zz* | grep -v 'zztool [a-z]*_stdin'

eco ----------------------------------------------------------------
eco '* Sempre use aspas ao redor do $* e de suas variáveis-filhas'
eco '*** Exemplo: filha=$(echo "$*"); echo "$filha"  # aspas em ambos'

grep '${*\*' funcoeszz zz/zz* | grep -v 'zztool [a-z]*_stdin'

eco ----------------------------------------------------------------
eco '* Sempre use aspas ao redor do $1 e de suas variáveis-filhas'
eco '*** Exemplo: filha=$(echo "$1"); echo "$filha"  # aspas em ambos'

grep '[^"]${*[1-9]' funcoeszz zz/zz*

eco ----------------------------------------------------------------
eco '* Sempre use aspas ao redor da variável no echo'
eco '*** Exemplo: echo "$foo"'

grep 'echo \$' funcoeszz zz/zz*

eco ----------------------------------------------------------------
eco '* eval is evil'

grep -w 'eval' funcoeszz zz/zz*
grep '${!' funcoeszz zz/zz*


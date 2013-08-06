#!/usr/bin/env bash
debug=0
values=1

# Linhas 1 a 4 sao sempre apagadas, por ser comentarios ou em branco
cat _dados | sed '1s/^/#/; 2s/^/   #/;3s/^/	#/;4s/.*//' > _tmp1
cat _dados | sed '1s/^/"/; 2s/^/   "/;3s/^/	"/;4s/.*//' > _tmp.vim
cat _dados | sed '1,4d' > _tmp3 # soh a ultima linha
cat _dados | sed 's/.*/   	       	/' > _tmp4 # soh brancos
cat _tmp1 _tmp1 _tmp1 > _tmp5 # testa o uniq

tests=(
_tmp1	a	_tmp3
_tmp.vim	a	_tmp3
_tmp4	t	''
_tmp5	a	_tmp3
)
. _lib

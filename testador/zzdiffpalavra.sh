#!/usr/bin/env bash
debug=0
values=2

cat _dados | tr : ' ' > _tmp1
sed 's/um/UM/;s/ three//;s/cinco/& mil/' _tmp1 > _tmp2
sed 's/five/FIVE/' _tmp1 > _tmp3
sed 's/ five//' _tmp1 > _tmp4

saida1=" 1
-um
+UM
 one 2 dois two 3 tres
-three
 4 quatro four 5 cinco
+mil
 five"
saida2="-1 um one 2 dois two 3 tres three 4 quatro four 5 cinco five"
saida3="+1 um one 2 dois two 3 tres three 4 quatro four 5 cinco five"
saida4=" 1 um one 2 dois two 3 tres three 4 quatro four 5 cinco
-five
+FIVE"
saida5=" 1 um one 2 dois two 3 tres three 4 quatro four 5 cinco
-five"

tests=(
''	''	r	^Uso:.*
_tmp1	''	r	^Uso:.*

_fake_	_tmp2_	r	'N.o consegui ler o arquivo _fake_'
_tmp1	_fake_	r	'N.o consegui ler o arquivo _fake_'

_tmp1	_tmp1	t	''	# no diff
_empty	_empty	t	''	# both empty

_tmp1	_tmp2	t	"$saida1" # termina normal
_tmp1	_empty	t	"$saida2" # soh -antigo
_empty	_tmp1	t	"$saida3" # soh +novo

_tmp1	_tmp3	t	"$saida4" # termina +novo
_tmp1	_tmp4	t	"$saida5" # termina -antigo
)
. _lib

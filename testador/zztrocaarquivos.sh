#!/usr/bin/env bash
debug=0
values=2

echo 1 > _tmp1
echo 2 > _tmp2

tests=(
# Erros
''	''	r	^Uso:.*
_tmp1	''	r	^Uso:.*
_fake_	_tmp2_	r	'N.o consegui ler o arquivo _fake_'
_tmp1	_fake_	r	'N.o consegui ler o arquivo _fake_'
_tmp1	_tmp1	t	'' # ignora
	
_tmp1	_tmp2	t	'Feito: _tmp1 <-> _tmp2'
)
. _lib

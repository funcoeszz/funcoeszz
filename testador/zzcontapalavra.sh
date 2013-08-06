#!/usr/bin/env bash
debug=0
values=4
tests=(
one	_dados	''	''	t	1
-i	one	_dados	''	t	1
-p	o	_dados	''	t	6	# dois na mesma linha
-i	-p	o	_dados	t	6

''	''	''	''	r	^Uso:.*
o	_dados	''	''	t	0	# parcial sem -p
:	_dados	''	''	t	0	# nao conta simbolos
)
. _lib

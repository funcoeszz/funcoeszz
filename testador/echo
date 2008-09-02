#!/usr/bin/env bash
values=3
tests=(
'-X'	''	''	r	^Uso:.*
'-l'	''	''	r	^Uso:.*
'-f'	''	''	r	^Uso:.*
'-l'	'xxx'	''	r	^Uso:.*
'-f'	'xxx'	''	r	^Uso:.*
'-f'	'azulx'	''	r	^Uso:.*
'-s'	'-N'	'-X'	r	^Uso:.*

# no color
Foo	Bar	''	t	'Foo Bar'
-n	Foo	Bar	t	'Foo Bar'
-l	azul	Foo	t	'Foo'
-p	-s	Foo	t	'Foo'
)
. _lib


# color tests
values=6
color=1
tests=(
-n	Foo	Bar	''	''	''	r	'^Foo Bar$'
-n	-l	azul	Foo	''	''	r	'^.\[;34mFoo.\[m$'
-n	-f	azul	Foo	''	''	r	'^.\[44mFoo.\[m$'
-n	-f	azul	-l	azul	Foo	r	'^.\[44;34mFoo.\[m$'
-n	-N	-p	-s	Foo	''	r	'^.\[;1;5;4mFoo.\[m$'

--nao-quebra	--fundo		azul	--letra		azul	Foo	r	'^.\[44;34mFoo.\[m$'
--nao-quebra	--negrito	--pisca	--sublinhado	Foo	''	r	'^.\[;1;5;4mFoo.\[m$'
)
. _lib


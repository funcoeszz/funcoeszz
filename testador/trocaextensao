#!/usr/bin/env bash
file="foo.JPG"
touch "$file"

debug=0
values=4
tests=(
# Erros
''	''	''	''	r	^Uso:.*
-n	''	''	''	r	^Uso:.*
-n	JPG	''	''	r	^Uso:.*
-n	JPG	BMP	''	r	^Uso:.*
-n	JPG	BMP	_fake_	r	'N.o consegui ler o arquivo _fake_'
-n 	JPG	JPG	"$file"	t	''

-n 	JPG	BMP	"$file"	t	'[-n] foo.JPG -> foo.BMP'
-n 	.JPG	.BMP	"$file"	t	'[-n] foo.JPG -> foo.BMP'
)
. _lib

rm "$file"

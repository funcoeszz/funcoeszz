#!/usr/bin/env bash
debug=0
values=2
protected=1

n="$(printf '.\n.')"
t="$(printf '.\t.')"

tests=(

binario	''	t	"62 69 6e 61 72 69 6f"
com	espaco	t	"63 6f 6d 20 65 73 70 61 63 6f"
'. .'	''	t	"2e 20 2e"
'\t'	''	t	"5c 74"
'\n'	''	t	"5c 6e"
"$t"	''	t	"2e 09 2e"
"$n"	''	t	"2e 0a 2e"
)
. _lib

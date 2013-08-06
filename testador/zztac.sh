#!/usr/bin/env bash
debug=0
values=2

tests=(
_numeros	''		t	"5\n4\n3\n2\n1"
_numeros	_numeros	t	"5\n4\n3\n2\n1\n5\n4\n3\n2\n1"
)
. _lib

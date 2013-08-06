#!/usr/bin/env bash
debug=0
values=2

tests=(
_empty	_dados	t	"d41d8cd98f00b204e9800998ecf8427e\t_empty\na48adf5366ffc7e0a6eb60447502c18e\t_dados"
)
. _lib

############################################################################

# Testes personalizados

result=$(echo abcdef | "$zz" md5 | sed -n l)

if test "$result" != '5ab557c937e38f15291c04b7e99544ad$'
then
	echo "ERROR: md5 via STDIN"
	echo "$result"
fi

#!/usr/bin/env bash
debug=0
values=1
tests=(

# a-f
"62 69 6e 61 72 69 6f"	t	binario
# A-F
"62 69 6E 61 72 69 6F"	t	binario
# A-F, prefixo 0x
"0x62 0x69 0x6e 0x61 0x72 0x69 0x6F"	t	binario
)
. _lib

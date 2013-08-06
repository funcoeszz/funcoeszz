#!/usr/bin/env bash
debug=0
values=1

tests=(
3	a	tabuada3.out
99	a	tabuada99.out
''	a	tabuada.out
-1	a	tabuada.out
foo	a	tabuada.out
)
. _lib

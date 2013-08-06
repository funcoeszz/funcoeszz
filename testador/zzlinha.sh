#!/usr/bin/env bash
debug=0
values=3
tests=(
# n
1	''	"$0"	t	'#!/usr/bin/env bash'
# -t
-t	^values	"$0"	r	'values=3'
-t	1	_dados	t	'1:um:one'
-t	:	_dados	r	'^[0-9]:[a-z].*'
# sem argumentos
''	''	_dados	r	'^[0-9]:[a-z].*'
# argumento faltando (mas vai ok no STDIN)
# -t	''	-	r	'^[0-9]:[a-z].*'
# multiplos arquivos
1	''	"$0 _dados"	t	'#!/usr/bin/env bash\n1:um:one'
-t	'^values\|^1'	"$0 _dados"	r	'^[v1]'
)
. _lib

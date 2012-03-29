#!/usr/bin/env bash
debug=0
values=2
tests=(

# erros
''	FOO	t	"Número inválido 'FOO'"
''	-8	t	"Número inválido '-8'"
''	--foo	t	"Número inválido '--foo'"
''	63	t	"O tamanho máximo desse tipo de senha é 62"

--num	FOO	t	"Número inválido 'FOO'"
--num	-8	t	"Número inválido '-8'"
--num	11	t	"O tamanho máximo desse tipo de senha é 10"

--pro	FOO	t	"Número inválido 'FOO'"
--pro	-8	t	"Número inválido '-8'"
--pro	76	t	"O tamanho máximo desse tipo de senha é 75"


# normal
''	0	t	''
''	1	r	'^[A-Za-z0-9]$'
''	10	r	'^[A-Za-z0-9]{10}$'
''	62	r	'^[A-Za-z0-9]{62}$'
''	''	r	'^[A-Za-z0-9]{8}$' # default

# --num
--num	0	t	''
--num	1	r	'^[0-9]$'
--num	10	r	'^[0-9]{10}$'
--num	''	r	'^[0-9]{8}$' # default

# --pro
--pro	0	t	''
--pro	1	r	'^[A-Za-z0-9/:;()$&@.,?!-]$'
--pro	10	r	'^[A-Za-z0-9/:;()$&@.,?!-]{10}$'
--pro	75	r	'^[A-Za-z0-9/:;()$&@.,?!-]{75}$'
--pro	''	r	'^[A-Za-z0-9/:;()$&@.,?!-]{8}$' # default
)
. _lib

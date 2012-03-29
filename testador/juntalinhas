#!/usr/bin/env bash
debug=0
values=5

tests=(
# sem opções
'_numeros'	''	''	''	''	t	"1\t2\t3\t4\t5"

# -d
# -d	''	'_numeros'	''	''	t	"12345"  # cant test
-d	@	'_numeros'	''	''	t	"1@2@3@4@5"
-d	::	'_numeros'	''	''	t	"1::2::3::4::5"
# -d	'{ }'	'_numeros'	''	''	t	"1{ }2{ }3{ }4{ }5"

# números e $
# -d	@	-i	0	_numeros	t	"1@2@3@4@5"  # depende do sed, o GNU entende endereço zero, BSD não
-d	@	-i	1	_numeros	t	"1@2@3@4@5"
-d	@	-i	3	_numeros	t	"1\n2\n3@4@5"
-d	@	-i	$	_numeros	t	"1\n2\n3\n4\n5"
-d	@	-f	1	_numeros	t	"1\n2\n3\n4\n5"
-d	@	-f	3	_numeros	t	"1@2@3\n4\n5"
-d	@	-f	$	_numeros	t	"1@2@3@4@5"
-i	2	-f	4	_numeros	t	"1\n2\t3\t4\n5"
# -i	4	-f	2	_numeros	t	"1\n2\n3\n4\t5"  # bug: got '1 2 3 5'
-i	4	-f	$	_numeros	t	"1\n2\n3\n4\t5"
-i	1	-f	$	_numeros	t	"1\t2\t3\t4\t5"
-i	4	-f	4	_numeros	t	"1\n2\n3\n4\n5"
-i	99	-f	$	_numeros	t	"1\n2\n3\n4\n5"
-i	4	-f	99	_numeros	t	"1\n2\n3\n4\n5"

# regex
-d	@	-i	^1$	_numeros	t	"1@2@3@4@5"
-d	@	-i	^3$	_numeros	t	"1\n2\n3@4@5"
-d	@	-f	^1$	_numeros	t	"1\n2\n3\n4\n5"
-d	@	-f	^3$	_numeros	t	"1@2@3\n4\n5"
-i	^2$	-f	^4$	_numeros	t	"1\n2\t3\t4\n5"

# escape da /
-d	@	-f	a/b	_numeros	t	"1\n2\n3\n4\n5"
-d	@	-i	a/b	_numeros	t	"1\n2\n3\n4\n5"
-d	/	-i	1	_numeros	t	"1/2/3/4/5"
-i	a/b	-f	a/b	_numeros	t	"1\n2\n3\n4\n5"

# início e fim na mesma linha
-i	^2	-f	:	_dados		t	"1:um:one\n2:dois:two\n3:tres:three\n4:quatro:four\n5:cinco:five"

)
. _lib

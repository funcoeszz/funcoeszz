#!/usr/bin/env bash

file="DSC00077.JPG"
touch "$file"

debug=0
values=6
tests=(
# Erros
''	''	''	''	''	''	r	^Uso:.*
-n	''	''	''	''	''	r	^Uso:.*
-n	-d	''	''	''	''	r	^Uso:.*
-n	-d	1	-i	''	''	r	^Uso:.*
-n	-d	1	-i	1	''	r	^Uso:.*
-n	-d	1	-i	1	_fake_	r	'N.o consegui ler o arquivo _fake_'
-n	''	''	''	''	_fake_	r	'N.o consegui ler o arquivo _fake_'
-n	-d	A	''	''	"$file"	r	'N.mero inv.lido para a op..o -d: A'
-n	-d	-3	''	''	"$file"	r	'N.mero inv.lido para a op..o -d: -3'
-n	-i	A	''	''	"$file"	r	'N.mero inv.lido para a op..o -i: A'
-n	-i	-3	''	''	"$file"	r	'N.mero inv.lido para a op..o -i: -3'

# Sem parametros
-n 	''	''	''	''	"$file"	t	'[-n] DSC00077.JPG -> DSC001.JPG'

# Numeros
-n	-d	1	''	''	"$file"	t	'[-n] DSC00077.JPG -> DSC1.JPG'
-n	-d	4	''	''	"$file"	t	'[-n] DSC00077.JPG -> DSC0001.JPG'
-n	-d	10	''	''	"$file"	t	'[-n] DSC00077.JPG -> DSC0000000001.JPG'
-n	-i	99	''	''	"$file"	t	'[-n] DSC00077.JPG -> DSC099.JPG'
-n	-d	10	-i	99	"$file"	t	'[-n] DSC00077.JPG -> DSC0000000099.JPG'
-n	-d	1	-i	9999	"$file"	t	'[-n] DSC00077.JPG -> DSC9999.JPG'

# Prefixo
# -n	-p	''	''	''	"$file"	t	''
-n	-p	'Praia_'	''	''	"$file"	t	'[-n] DSC00077.JPG -> Praia_001.JPG'
-n	-p	'Praia_'	-d	4	"$file"	t	'[-n] DSC00077.JPG -> Praia_0001.JPG'
-n	-p	'Praia_'	-i	4	"$file"	t	'[-n] DSC00077.JPG -> Praia_004.JPG'

)
. _lib

rm "$file"

#!/usr/bin/env bash
debug=0
values=1
tests=(

# mapa completo (ida)
'!'"\"#$%&'()*+,-./"		t	'PQRSTUVWXYZ[\]^'
0123456789			t	'_`abcdefgh'
':;<=>?@'			t	ijklmno
ABCDEFGHIJKLMNOPQRSTUVWXYZ	t	"pqrstuvwxyz{|}~!\"#$%&'()*+"
'[\]^_`'			t	,-./01
abcdefghijklmnopqrstuvwxyz	t	'23456789:;<=>?@ABCDEFGHIJK'
'{|}~'				t	LMNO

# mapa completo (volta)
'PQRSTUVWXYZ[\]^'		t	'!'"\"#$%&'()*+,-./"	
'_`abcdefgh'			t	0123456789		
ijklmno				t	':;<=>?@'		
"pqrstuvwxyz{|}~!\"#$%&'()*+"	t	ABCDEFGHIJKLMNOPQRSTUVWXYZ
,-./01				t	'[\]^_`'		
'23456789:;<=>?@ABCDEFGHIJK'	t	abcdefghijklmnopqrstuvwxyz
LMNO				t	'{|}~'			

# e os acentos?
AÁaá	t	pÁ2á
)
. _lib

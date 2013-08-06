#!/usr/bin/env bash

values=2
tests=(

# 0-9 (nada muda)
"0 1 2 3 4 5 6 7 8 9"					''	t
"0 1 2 3 4 5 6 7 8 9"

# A-Z (nada muda)
"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"	''	t
"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"

# a-z
"a b c d e f g h i j k l m n o p q r s t u v w x y z"	''	t
"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"

# ACENTUAÇÃO (nada muda)
"À Á Â Ã Ä Å È É Ê Ë Ì Í Î Ï Ò Ó Ô Õ Ö Ù Ú Û Ü Ç Ñ"	''	t
"À Á Â Ã Ä Å È É Ê Ë Ì Í Î Ï Ò Ó Ô Õ Ö Ù Ú Û Ü Ç Ñ"

# acentuação
"à á â ã ä å è é ê ë ì í î ï ò ó ô õ ö ù ú û ü ç ñ"	''	t
"À Á Â Ã Ä Å È É Ê Ë Ì Í Î Ï Ò Ó Ô Õ Ö Ù Ú Û Ü Ç Ñ"

### O delimitador é qualquer coisa fora letras e números

# Tabela ASCII (exceto ')
'x x!x"x#x$x%x&x(x)x*x+x,x-x.x/x:x;x<x=x>x?x@x[x\x]x^x_x`x{x|x}x~x'	''	t
'X X!X"X#X$X%X&X(X)X*X+X,X-X.X/X:X;X<X=X>X?X@X[X\X]X^X_X`X{X|X}X~X'
# Para gerar: zzascii 1 | cut -c78- | grep -v [a-zA-Z0-9] | grep -v \' | tr \\n a

# Unicode
"x©x®x²xªx½x»x→x⇒x♣x♥x♠x♦x★x"	''	t
"X©X®X²XªX½X»X→X⇒X♣X♥X♠X♦X★X"
)
. _lib


#######################################################################

values=3
tests=(
	# exemplos do --help
	''	''	root			t	Root
	''	''	"kung fu panda"		t	"Kung Fu Panda"
	''	-1	"kung fu panda"		t	"Kung fu panda"
	''	''	quero-quero		t	Quero-Quero
	''	''	eu_uso_camel_case	t	Eu_Uso_Camel_Case
	''	''	"i don't care"		t	"I Don'T Care"
	-w	\'	"i don't care"		t	"I Don't Care"

	# Opção -w: escape do "
	''	''	'foo"bar'		t	'Foo"Bar'
	-w	\"	'foo"bar'		t	'Foo"bar'

	# Opção -w: múltiplos caracteres
	''	''	'a:b c_d e-f'		t	'A:B C_D E-F'
	-w	':_-'	'a:b c_d e-f'		t	'A:b C_d E-f'
)
. _lib

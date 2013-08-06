# 0-9 (nada muda)
$ zzcapitalize '0 1 2 3 4 5 6 7 8 9'
0 1 2 3 4 5 6 7 8 9
$

# A-Z (nada muda)
$ zzcapitalize 'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z'
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
$

# a-z
$ zzcapitalize 'a b c d e f g h i j k l m n o p q r s t u v w x y z'
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
$

# ACENTUAÇÃO (nada muda)
$ zzcapitalize 'À Á Â Ã Ä Å È É Ê Ë Ì Í Î Ï Ò Ó Ô Õ Ö Ù Ú Û Ü Ç Ñ'
À Á Â Ã Ä Å È É Ê Ë Ì Í Î Ï Ò Ó Ô Õ Ö Ù Ú Û Ü Ç Ñ
$

# acentuação
$ zzcapitalize 'à á â ã ä å è é ê ë ì í î ï ò ó ô õ ö ù ú û ü ç ñ'
À Á Â Ã Ä Å È É Ê Ë Ì Í Î Ï Ò Ó Ô Õ Ö Ù Ú Û Ü Ç Ñ
$

### O delimitador é qualquer coisa fora letras e números

# Tabela ASCII
$ zzcapitalize x\'x' x!x"x#x$x%x&x(x)x*x+x,x-x.x/x:x;x<x=x>x?x@x[x\x]x^x_x`x{x|x}x~x'
X'X X!X"X#X$X%X&X(X)X*X+X,X-X.X/X:X;X<X=X>X?X@X[X\X]X^X_X`X{X|X}X~X
$
# '
# Para gerar: zzascii 1 | cut -c78- | grep -v [a-zA-Z0-9] | tr \\n x


# Unicode
$ zzcapitalize 'x©x®x²xªx½x»x→x⇒x♣x♥x♠x♦x★x'
X©X®X²XªX½X»X→X⇒X♣X♥X♠X♦X★X
$

#######################################################################

# exemplos do --help
$ zzcapitalize			root			#→ Root
$ zzcapitalize			'kung fu panda'		#→ Kung Fu Panda
$ zzcapitalize	-1		'kung fu panda'		#→ Kung fu panda
$ zzcapitalize			quero-quero		#→ Quero-Quero
$ zzcapitalize			eu_uso_camel_case	#→ Eu_Uso_Camel_Case
$ zzcapitalize			"i don't care"		#→ I Don'T Care
$ zzcapitalize	-w	\'	"i don't care"		#→ I Don't Care

# Opção -w: escape do "
$ zzcapitalize			'foo"bar'		#→ Foo"Bar
$ zzcapitalize	-w	\"	'foo"bar'		#→ Foo"bar

# Opção -w: múltiplos caracteres
$ zzcapitalize			'a:b c_d e-f'		#→ A:B C_D E-F
$ zzcapitalize	-w	':_-'	'a:b c_d e-f'		#→ A:b C_d E-f

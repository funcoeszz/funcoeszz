# Mínimo de argumentos: somente o número, preenche com espaços
$ echo x | zzpad 5 | tr ' ' _				#→ x____

# Texto via STDIN
$ echo x | zzpad    -x _ 5				#→ x____
$ echo x | zzpad -d -x _ 5				#→ x____
$ echo x | zzpad -e -x _ 5				#→ ____x
$ echo x | zzpad -a -x _ 5				#→ __x__

# Texto via STDIN, multilinha
$ cat _numeros.txt
1
2
3
4
5
$ cat _numeros.txt | zzpad -x _ 5
1____
2____
3____
4____
5____
$ cat _numeros.txt | zzpad -d -x _ 5
1____
2____
3____
4____
5____
$ cat _numeros.txt | zzpad -e -x _ 5
____1
____2
____3
____4
____5
$ cat _numeros.txt | zzpad -a -x _ 5
__1__
__2__
__3__
__4__
__5__
$

# Valores inválidos para o número (argumento 1)
$ zzpad	-9	a	a 				#→ Opção inválida: -9
$ zzpad	0	a	a 				#→ --regex ^Uso:
$ zzpad	a	a	a 				#→ --regex ^Uso:

# String de preenchimento maior que o tamanho máximo
$ zzpad	-e	-x	XXXXXX	3	a			#→ XXXXXXa
$ zzpad	-d	-x	XXXXXX	3	a			#→ aXXXXXX

# Texto já maior que o tamanho máximo
$ zzpad	-d	-x	_	3	paralelepípedo		#→ paralelepípedo
$ zzpad	-e	-x	_	3	paralelepípedo		#→ paralelepípedo
$ zzpad	-a	-x	_	3	paralelepípedo		#→ paralelepípedo

# Quando é ambos, primeiro preenche à direita, depois à esquerda
$ zzpad	-a	-x	_	2	a			#→ a_
$ zzpad	-a	-x	_	3	a			#→ _a_
$ zzpad	-a	-x	_	4	a			#→ _a__

# Teste das opções em inglês
$ zzpad	-r	-x	_	5	a			#→ a____
$ zzpad	-l	-x	_	5	a			#→ ____a
$ zzpad	-b	-x	_	5	a			#→ __a__

# Texto em UTF-8 (letras, 2 bytes)
$ zzpad	-d	-x	_	5	á			#→ á____
$ zzpad	-e	-x	_	5	á			#→ ____á
$ zzpad	-a	-x	_	5	á			#→ __á__
$ zzpad	-d	-x	_	5	áé			#→ áé___
$ zzpad	-e	-x	_	5	áé			#→ ___áé
$ zzpad	-a	-x	_	5	áé			#→ _áé__

# Texto em UTF-8 (símbolos, 3 bytes)
$ zzpad	-d	-x	_	5	♥			#→ ♥____
$ zzpad	-e	-x	_	5	♥			#→ ____♥
$ zzpad	-a	-x	_	5	♥			#→ __♥__
$ zzpad	-d	-x	_	5	♥★			#→ ♥★___
$ zzpad	-e	-x	_	5	♥★			#→ ___♥★
$ zzpad	-a	-x	_	5	♥★			#→ _♥★__

# Zero padding informando zero
$ zzpad	-e	-x	0	1	0			#→ 0
$ zzpad	-e	-x	0	2	0			#→ 00
$ zzpad	-e	-x	0	9	0			#→ 000000000

# Zero padding - direita
$ zzpad		-x	0	11	0			#→ 00000000000
$ zzpad		-x	0	11	1			#→ 10000000000
$ zzpad		-x	0	11	12			#→ 12000000000
$ zzpad		-x	0	11	123			#→ 12300000000
$ zzpad		-x	0	11	1234			#→ 12340000000
$ zzpad		-x	0	11	12345			#→ 12345000000
$ zzpad		-x	0	11	123456			#→ 12345600000
$ zzpad		-x	0	11	1234567			#→ 12345670000
$ zzpad		-x	0	11	12345678		#→ 12345678000
$ zzpad		-x	0	11	123456789		#→ 12345678900
$ zzpad		-x	0	11	1234567890		#→ 12345678900
$ zzpad		-x	0	11	12345678901		#→ 12345678901
$ zzpad		-x	0	11	123456789012		#→ 123456789012
$ zzpad	-d	-x	0	11	0			#→ 00000000000
$ zzpad	-d	-x	0	11	1			#→ 10000000000
$ zzpad	-d	-x	0	11	12			#→ 12000000000
$ zzpad	-d	-x	0	11	123			#→ 12300000000
$ zzpad	-d	-x	0	11	1234			#→ 12340000000
$ zzpad	-d	-x	0	11	12345			#→ 12345000000
$ zzpad	-d	-x	0	11	123456			#→ 12345600000
$ zzpad	-d	-x	0	11	1234567			#→ 12345670000
$ zzpad	-d	-x	0	11	12345678		#→ 12345678000
$ zzpad	-d	-x	0	11	123456789		#→ 12345678900
$ zzpad	-d	-x	0	11	1234567890		#→ 12345678900
$ zzpad	-d	-x	0	11	12345678901		#→ 12345678901
$ zzpad	-d	-x	0	11	123456789012		#→ 123456789012

# Zero padding - esquerda
$ zzpad	-e	-x	0	11	0			#→ 00000000000
$ zzpad	-e	-x	0	11	1			#→ 00000000001
$ zzpad	-e	-x	0	11	12			#→ 00000000012
$ zzpad	-e	-x	0	11	123			#→ 00000000123
$ zzpad	-e	-x	0	11	1234			#→ 00000001234
$ zzpad	-e	-x	0	11	12345			#→ 00000012345
$ zzpad	-e	-x	0	11	123456			#→ 00000123456
$ zzpad	-e	-x	0	11	1234567			#→ 00001234567
$ zzpad	-e	-x	0	11	12345678		#→ 00012345678
$ zzpad	-e	-x	0	11	123456789		#→ 00123456789
$ zzpad	-e	-x	0	11	1234567890		#→ 01234567890
$ zzpad	-e	-x	0	11	12345678901		#→ 12345678901
$ zzpad	-e	-x	0	11	123456789012		#→ 123456789012

# Zero padding - ambos
$ zzpad	-a	-x	0	11	0			#→ 00000000000
$ zzpad	-a	-x	0	11	1			#→ 00000100000
$ zzpad	-a	-x	0	11	12			#→ 00001200000
$ zzpad	-a	-x	0	11	123			#→ 00001230000
$ zzpad	-a	-x	0	11	1234			#→ 00012340000
$ zzpad	-a	-x	0	11	12345			#→ 00012345000
$ zzpad	-a	-x	0	11	123456			#→ 00123456000
$ zzpad	-a	-x	0	11	1234567			#→ 00123456700
$ zzpad	-a	-x	0	11	12345678		#→ 01234567800
$ zzpad	-a	-x	0	11	123456789		#→ 01234567890
$ zzpad	-a	-x	0	11	1234567890		#→ 12345678900
$ zzpad	-a	-x	0	11	12345678901		#→ 12345678901
$ zzpad	-a	-x	0	11	123456789012		#→ 123456789012

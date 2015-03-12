# Mínimo de argumentos: somente o número, preenche com espaços
$ echo x | zzpad 5 | tr ' ' _				#→ x____

# Texto via STDIN
$ echo x | zzpad    5 _					#→ x____
$ echo x | zzpad -d 5 _					#→ x____
$ echo x | zzpad -e 5 _					#→ ____x
$ echo x | zzpad -a 5 _					#→ __x__

# Texto via STDIN, multilinha
$ cat _numeros.txt
1
2
3
4
5
$ cat _numeros.txt | zzpad 5 _
1____
2____
3____
4____
5____
$ cat _numeros.txt | zzpad -d 5 _
1____
2____
3____
4____
5____
$ cat _numeros.txt | zzpad -e 5 _
____1
____2
____3
____4
____5
$ cat _numeros.txt | zzpad -a 5 _
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
$ zzpad	-e	3	XXXXXX	a			#→ XXXXXXa
$ zzpad	-d	3	XXXXXX	a			#→ aXXXXXX

# Texto já maior que o tamanho máximo
$ zzpad	-d	3	_	paralelepípedo		#→ paralelepípedo
$ zzpad	-e	3	_	paralelepípedo		#→ paralelepípedo
$ zzpad	-a	3	_	paralelepípedo		#→ paralelepípedo

# Quando é ambos, primeiro preenche à direita, depois à esquerda
$ zzpad	-a	2	_	a			#→ a_
$ zzpad	-a	3	_	a			#→ _a_
$ zzpad	-a	4	_	a			#→ _a__

# Teste das opções em inglês
$ zzpad	-r	5	_	a			#→ a____
$ zzpad	-l	5	_	a			#→ ____a
$ zzpad	-b	5	_	a			#→ __a__

# Texto em UTF-8 (letras, 2 bytes)
$ zzpad	-d	5	_	á			#→ á____
$ zzpad	-e	5	_	á			#→ ____á
$ zzpad	-a	5	_	á			#→ __á__
$ zzpad	-d	5	_	áé			#→ áé___
$ zzpad	-e	5	_	áé			#→ ___áé
$ zzpad	-a	5	_	áé			#→ _áé__

# Texto em UTF-8 (símbolos, 3 bytes)
$ zzpad	-d	5	_	♥			#→ ♥____
$ zzpad	-e	5	_	♥			#→ ____♥
$ zzpad	-a	5	_	♥			#→ __♥__
$ zzpad	-d	5	_	♥★			#→ ♥★___
$ zzpad	-e	5	_	♥★			#→ ___♥★
$ zzpad	-a	5	_	♥★			#→ _♥★__

# Zero padding informando zero
$ zzpad	-e	1	0	0			#→ 0
$ zzpad	-e	2	0	0			#→ 00
$ zzpad	-e	9	0	0			#→ 000000000

# Zero padding - direita
$ zzpad		11	0	0			#→ 00000000000
$ zzpad		11	0	1			#→ 10000000000
$ zzpad		11	0	12			#→ 12000000000
$ zzpad		11	0	123			#→ 12300000000
$ zzpad		11	0	1234			#→ 12340000000
$ zzpad		11	0	12345			#→ 12345000000
$ zzpad		11	0	123456			#→ 12345600000
$ zzpad		11	0	1234567			#→ 12345670000
$ zzpad		11	0	12345678		#→ 12345678000
$ zzpad		11	0	123456789		#→ 12345678900
$ zzpad		11	0	1234567890		#→ 12345678900
$ zzpad		11	0	12345678901		#→ 12345678901
$ zzpad		11	0	123456789012		#→ 123456789012
$ zzpad	-d	11	0	0			#→ 00000000000
$ zzpad	-d	11	0	1			#→ 10000000000
$ zzpad	-d	11	0	12			#→ 12000000000
$ zzpad	-d	11	0	123			#→ 12300000000
$ zzpad	-d	11	0	1234			#→ 12340000000
$ zzpad	-d	11	0	12345			#→ 12345000000
$ zzpad	-d	11	0	123456			#→ 12345600000
$ zzpad	-d	11	0	1234567			#→ 12345670000
$ zzpad	-d	11	0	12345678		#→ 12345678000
$ zzpad	-d	11	0	123456789		#→ 12345678900
$ zzpad	-d	11	0	1234567890		#→ 12345678900
$ zzpad	-d	11	0	12345678901		#→ 12345678901
$ zzpad	-d	11	0	123456789012		#→ 123456789012

# Zero padding - esquerda
$ zzpad	-e	11	0	0			#→ 00000000000
$ zzpad	-e	11	0	1			#→ 00000000001
$ zzpad	-e	11	0	12			#→ 00000000012
$ zzpad	-e	11	0	123			#→ 00000000123
$ zzpad	-e	11	0	1234			#→ 00000001234
$ zzpad	-e	11	0	12345			#→ 00000012345
$ zzpad	-e	11	0	123456			#→ 00000123456
$ zzpad	-e	11	0	1234567			#→ 00001234567
$ zzpad	-e	11	0	12345678		#→ 00012345678
$ zzpad	-e	11	0	123456789		#→ 00123456789
$ zzpad	-e	11	0	1234567890		#→ 01234567890
$ zzpad	-e	11	0	12345678901		#→ 12345678901
$ zzpad	-e	11	0	123456789012		#→ 123456789012

# Zero padding - ambos
$ zzpad	-a	11	0	0			#→ 00000000000
$ zzpad	-a	11	0	1			#→ 00000100000
$ zzpad	-a	11	0	12			#→ 00001200000
$ zzpad	-a	11	0	123			#→ 00001230000
$ zzpad	-a	11	0	1234			#→ 00012340000
$ zzpad	-a	11	0	12345			#→ 00012345000
$ zzpad	-a	11	0	123456			#→ 00123456000
$ zzpad	-a	11	0	1234567			#→ 00123456700
$ zzpad	-a	11	0	12345678		#→ 01234567800
$ zzpad	-a	11	0	123456789		#→ 01234567890
$ zzpad	-a	11	0	1234567890		#→ 12345678900
$ zzpad	-a	11	0	12345678901		#→ 12345678901
$ zzpad	-a	11	0	123456789012		#→ 123456789012

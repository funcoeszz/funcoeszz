# Operação normal

$ zztabuada	3
3 x 0  = 0
3 x 1  = 3
3 x 2  = 6
3 x 3  = 9
3 x 4  = 12
3 x 5  = 15
3 x 6  = 18
3 x 7  = 21
3 x 8  = 24
3 x 9  = 27
3 x 10 = 30
$ zztabuada	-3
-3 x 0  =  0
-3 x 1  = -3
-3 x 2  = -6
-3 x 3  = -9
-3 x 4  = -12
-3 x 5  = -15
-3 x 6  = -18
-3 x 7  = -21
-3 x 8  = -24
-3 x 9  = -27
-3 x 10 = -30
$ zztabuada	99
99 x 0  = 0
99 x 1  = 99
99 x 2  = 198
99 x 3  = 297
99 x 4  = 396
99 x 5  = 495
99 x 6  = 594
99 x 7  = 693
99 x 8  = 792
99 x 9  = 891
99 x 10 = 990
$ zztabuada	0
0 x 0  = 0
0 x 1  = 0
0 x 2  = 0
0 x 3  = 0
0 x 4  = 0
0 x 5  = 0
0 x 6  = 0
0 x 7  = 0
0 x 8  = 0
0 x 9  = 0
0 x 10 = 0
$

# O segundo argumento indica o número final da tabela

$ zztabuada 5 0
5 x 0  = 0
$ zztabuada 5 3
5 x 0  = 0
5 x 1  = 5
5 x 2  = 10
5 x 3  = 15
$ zztabuada 5 15
5 x 0  = 0
5 x 1  = 5
5 x 2  = 10
5 x 3  = 15
5 x 4  = 20
5 x 5  = 25
5 x 6  = 30
5 x 7  = 35
5 x 8  = 40
5 x 9  = 45
5 x 10 = 50
5 x 11 = 55
5 x 12 = 60
5 x 13 = 65
5 x 14 = 70
5 x 15 = 75
$

# Argumentos inválidos

$ zztabuada foo
Uso: zztabuada [número [número]]
$

# Sem argumentos mostra a tabuada de 1 a 9

$ zztabuada		#=> --file zztabuada.out.txt

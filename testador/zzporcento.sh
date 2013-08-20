# Erros

$ zzporcento			#→ --regex ^Uso:
$ zzporcento	100	-1	#→ Número inválido '-1'
$ zzporcento	-1	100	#→ Número inválido '-1'
$ zzporcento	100	+1	#→ Número inválido '+1'
$ zzporcento	+1	100	#→ Número inválido '+1'
$ zzporcento	100	X	#→ Número inválido 'X'
$ zzporcento	X	100	#→ Número inválido 'X'

$ zzporcento	1	.5%	#→ O valor da porcentagem deve ser um número. Exemplos: 2 ou 2,5.
$ zzporcento	1	X%	#→ O valor da porcentagem deve ser um número. Exemplos: 2 ou 2,5.

### valor1 valor2

# inteiros
$ zzporcento	100	0			#→ 0%

# XXX ^ 0,00% ?
$ zzporcento	100	1			#→ 1,00%
$ zzporcento	100	10			#→ 10,00%
$ zzporcento	100	50			#→ 50,00%
$ zzporcento	100	100			#→ 100,00%
$ zzporcento	100	200			#→ 200,00%
$ zzporcento	100	1000			#→ 1000,00%

# float
$ zzporcento	100,0	10			#→ 10,00%
$ zzporcento	100,00	10			#→ 10,00%
$ zzporcento	100,000	10			#→ 10,00%
$ zzporcento	100	10,0			#→ 10,00%
$ zzporcento	100	10,00			#→ 10,00%
$ zzporcento	100	10,000			#→ 10,00%
$ zzporcento	100,0	10,0			#→ 10,00%
$ zzporcento	100,00	10,00			#→ 10,00%
$ zzporcento	100,000	10,000			#→ 10,00%

# float com ponto
$ zzporcento	100.0	10			#→ 10.00%
$ zzporcento	100.00	10			#→ 10.00%
$ zzporcento	100.000	10			#→ 10.00%
$ zzporcento	100	10.0			#→ 10.00%
$ zzporcento	100	10.00			#→ 10.00%
$ zzporcento	100	10.000			#→ 10.00%
$ zzporcento	100.0	10.0			#→ 10.00%
$ zzporcento	100.00	10.00			#→ 10.00%
$ zzporcento	100.000	10.000			#→ 10.00%

# float/float o segundo separador ganha
$ zzporcento	100.0	10,0			#→ 10,00%
$ zzporcento	100,0	10.0			#→ 10.00%

# dinheiro
$ zzporcento	1.000,00	100		#→ 10,00%
$ zzporcento	10000		1.000,00	#→ 10,00%
$ zzporcento	10.000,00	1.000,00	#→ 10,00%
$ zzporcento	100.000,00	10.000,00	#→ 10,00%
$ zzporcento	1.000.000,00	100.000,00	#→ 10,00%
$ zzporcento	10.000.000,00	1.000.000,00	#→ 10,00%
$ zzporcento	100.000.000,00	10.000.000,00	#→ 10,00%

### valor1 porcentagem

# inteiro
$ zzporcento	100		20%	#→ 20

# primeiro inteiro e % float: escala=2 e vírgula
$ zzporcento	100		2.5%	#→ 2,50
$ zzporcento	100		2,5%	#→ 2,50

# escala e vírgula do primeiro
$ zzporcento	100,00		2.5%	#→ 2,50
$ zzporcento	100,00		2,5%	#→ 2,50

# dinheiro com pontos
$ zzporcento	1.234.567,89	25%	#→ 308641,97

# adição do zero em caso de resultado .123
$ zzporcento	1,00		1%	#→ 0,01

### valor1 +porcentagem

# inteiro
$ zzporcento	100		+20%	#→ 120
$ zzporcento	100		-20%	#→ 80

# primeiro inteiro e % float: escala=2 e vírgula
$ zzporcento	100		+2.5%	#→ 102,50
$ zzporcento	100		+2,5%	#→ 102,50
$ zzporcento	100		-2.5%	#→ 97,50
$ zzporcento	100		-2,5%	#→ 97,50

# escala e vírgula do primeiro
$ zzporcento	100,00		+2.5%	#→ 102,50
$ zzporcento	100,00		+2,5%	#→ 102,50
$ zzporcento	100,00		-2.5%	#→ 97,50
$ zzporcento	100,00		-2,5%	#→ 97,50

# dinheiro com pontos
$ zzporcento	1.234.567,89	+25%	#→ 1543209,86
$ zzporcento	1.234.567,89	-25%	#→ 925925,92

# adição do zero em caso de resultado .123
$ zzporcento	1,00		+1%	#→ 1,01
$ zzporcento	1,00		-1%	#→ 0,99

### valor1

$ zzporcento 500
200%	1000
150%	750
125%	625
100%	500
90%	450
80%	400
75%	375
70%	350
60%	300
50%	250
40%	200
30%	150
25%	125
20%	100
15%	75
10%	50
9%	45
8%	40
7%	35
6%	30
5%	25
4%	20
3%	15
2%	10
1%	5
$ zzporcento 500.00
200%	1000.00
150%	750.00
125%	625.00
100%	500.00
90%	450.00
80%	400.00
75%	375.00
70%	350.00
60%	300.00
50%	250.00
40%	200.00
30%	150.00
25%	125.00
20%	100.00
15%	75.00
10%	50.00
9%	45.00
8%	40.00
7%	35.00
6%	30.00
5%	25.00
4%	20.00
3%	15.00
2%	10.00
1%	5.00
$ zzporcento 500.0000
200%	1000.0000
150%	750.0000
125%	625.0000
100%	500.0000
90%	450.0000
80%	400.0000
75%	375.0000
70%	350.0000
60%	300.0000
50%	250.0000
40%	200.0000
30%	150.0000
25%	125.0000
20%	100.0000
15%	75.0000
10%	50.0000
9%	45.0000
8%	40.0000
7%	35.0000
6%	30.0000
5%	25.0000
4%	20.0000
3%	15.0000
2%	10.0000
1%	5.0000
$ zzporcento 500,00
200%	1000,00
150%	750,00
125%	625,00
100%	500,00
90%	450,00
80%	400,00
75%	375,00
70%	350,00
60%	300,00
50%	250,00
40%	200,00
30%	150,00
25%	125,00
20%	100,00
15%	75,00
10%	50,00
9%	45,00
8%	40,00
7%	35,00
6%	30,00
5%	25,00
4%	20,00
3%	15,00
2%	10,00
1%	5,00
$ zzporcento 500,0000
200%	1000,0000
150%	750,0000
125%	625,0000
100%	500,0000
90%	450,0000
80%	400,0000
75%	375,0000
70%	350,0000
60%	300,0000
50%	250,0000
40%	200,0000
30%	150,0000
25%	125,0000
20%	100,0000
15%	75,0000
10%	50,0000
9%	45,0000
8%	40,0000
7%	35,0000
6%	30,0000
5%	25,0000
4%	20,0000
3%	15,0000
2%	10,0000
1%	5,0000
$ zzporcento 1.234.567,89
200%	2469135,78
150%	1851851,83
125%	1543209,86
100%	1234567,89
90%	1111111,10
80%	987654,31
75%	925925,91
70%	864197,52
60%	740740,73
50%	617283,94
40%	493827,15
30%	370370,36
25%	308641,97
20%	246913,57
15%	185185,18
10%	123456,78
9%	111111,11
8%	98765,43
7%	86419,75
6%	74074,07
5%	61728,39
4%	49382,71
3%	37037,03
2%	24691,35
1%	12345,67
$


# Saída antiga:
# $ zzporcento 100 20%
# +20%	120
# 100%	100
# -20%	80
# 
# 20%	20
# $


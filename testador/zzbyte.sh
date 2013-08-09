$ zzbyte				#→ --regex ^Uso:
$ zzbyte	a			#→ Número inválido 'a'
$ zzbyte	-1			#→ Número inválido '-1'
$ zzbyte	1.0			#→ Número inválido '1.0'
$ zzbyte	1,0			#→ Número inválido '1,0'
# $ zzbyte  ' '				#→ Número inválido ' '

$ zzbyte	0	x		#→ Unidade inválida 'X'
$ zzbyte	0	B	x	#→ Unidade inválida 'X'

# unidade máxima
$ zzbyte	1073741824	Z	#→ 1048576Y

# o zero fica na unidade escolhida
$ zzbyte	0			#→ 0B
$ zzbyte	0	g		#→ 0G
$ zzbyte	0	g	k	#→ 0K
$ zzbyte	0	g	p	#→ 0P

# aumento de grandezas
$ zzbyte	1			#→ 1B
$ zzbyte	10			#→ 10B
$ zzbyte	100			#→ 100B
$ zzbyte	1000			#→ 1000B

# até 1023 não vira
$ zzbyte	1023			#→ 1023B
$ zzbyte	1023	b		#→ 1023B
$ zzbyte	1023	k		#→ 1023K

# 1024 é o ponto de virada
$ zzbyte	1024			#→ 1K
$ zzbyte	1024	b		#→ 1K
$ zzbyte	1024	k		#→ 1M
$ zzbyte	1024	b	k	#→ 1K
$ zzbyte	1024	k	b	#→ 1048576B

# decresce até B
$ zzbyte	1	m	b	#→ 1048576B
$ zzbyte	1	g	b	#→ 1073741824B

# cresce desde B
$ zzbyte	1048576	b	k	#→ 1024K
$ zzbyte	1048576	b	m	#→ 1M
$ zzbyte	1048576	b		#→ 1M
$ zzbyte	1048576			#→ 1M

# aumento de grandezas em M
$ zzbyte	5	m	g	#→ 0.004G
$ zzbyte	50	m	g	#→ 0.048G
$ zzbyte	500	m	g	#→ 0.488G
$ zzbyte	5000	m	g	#→ 4G

# unidades de entrada e saída iguais
$ zzbyte	5	g	g	#→ 5G

# 1 T em todas as unidades
$ zzbyte	1	t	b	#→ 1099511627776B
$ zzbyte	1	t	k	#→ 1073741824K
$ zzbyte	1	t	m	#→ 1048576M
$ zzbyte	1	t	g	#→ 1024G
$ zzbyte	1	t	t	#→ 1T
$ zzbyte	1	t	p	#→ 0P
$ zzbyte	1	t	e	#→ 0E
$ zzbyte	1	t	z	#→ 0Z
$ zzbyte	1	t	y	#→ 0Y

# 2 T em todas as unidades
$ zzbyte	2	t	b	#→ 2199023255552B
$ zzbyte	2	t	k	#→ 2147483648K
$ zzbyte	2	t	m	#→ 2097152M
$ zzbyte	2	t	g	#→ 2048G
$ zzbyte	2	t	t	#→ 2T
$ zzbyte	2	t	p	#→ 0.001P
$ zzbyte	2	t	e	#→ --regex ^0[.,]000001E$
$ zzbyte	2	t	z	#→ --regex ^0[.,]000000001Z$
$ zzbyte	2	t	y	#→ --regex ^0[.,]000000000001Y$

# Limites dos poucos B
$ zzbyte	1	b	k	#→ 0K
$ zzbyte	1	b	y	#→ 0Y
$ zzbyte	2	b	k	#→ 0.001K
$ zzbyte	2	b	y	#→ --regex ^0[.,]000000000000000000000001Y$

# Limite de descida de 1Y sem estourar a pilha do Bash
$ zzbyte	1	y	m	#→ 1152921504606846976M

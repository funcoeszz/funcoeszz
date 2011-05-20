#!/usr/bin/env bash
debug=0
values=3
tests=(
''	''	''	r	^Uso:.*
a	''	''	t	"Número inválido 'a'"
-1	''	''	t	"Número inválido '-1'"
1.0	''	''	t	"Número inválido '1.0'"
1,0	''	''	t	"Número inválido '1,0'"
# ' '	''	''	t	"Número inválido ' '"

0	x	''	r	"Unidade inv.lida '.'"
0	B	x	r	"Unidade inv.lida '.'"

1073741824	Z	''	t	1048576Y # unidade maxima

# o zero fica na unidade escolhda
0	''	''	t	0B
0	g	''	t	0G
0	g	k	t	0K
0	g	p	t	0P

# aumento de grandezas
1	''	''	t	1B
10	''	''	t	10B
100	''	''	t	100B
1000	''	''	t	1000B

# ate 1023 nao vira
1023	''	''	t	1023B
1023	b	''	t	1023B
1023	k	''	t	1023K

# 1024 eh o ponto de virada
1024	''	''	t	1K
1024	b	''	t	1K
1024	k	''	t	1M
1024	b	k	t	1K
1024	k	b	t	1048576B

# decresce ate B
1	m	b	t	1048576B
1	g	b	t	1073741824B

# cresce desde B
1048576	b	k	t	1024K
1048576	b	m	t	1M
1048576	b	''	t	1M
1048576	''	''	t	1M

# aumento de grandezas em M
5	m	g	t	0.004G
50	m	g	t	0.048G
500	m	g	t	0.488G
5000	m	g	t	4G

# unidades de entrada e saida iguais
5	g	g	t	5G

# 1 T em todas as unidades
1	t	b	t	1099511627776B
1	t	k	t	1073741824K
1	t	m	t	1048576M
1	t	g	t	1024G
1	t	t	t	1T
1	t	p	t	0P
1	t	e	t	0E
1	t	z	t	0Z
1	t	y	t	0Y

# 2 T em todas as unidades
2	t	b	t	2199023255552B
2	t	k	t	2147483648K
2	t	m	t	2097152M
2	t	g	t	2048G
2	t	t	t	2T
2	t	p	t	0.001P
2	t	e	r	0[.,]000001E
2	t	z	r	0[.,]000000001Z
2	t	y	r	0[.,]000000000001Y

# Limites dos poucos B
1	b	k	t	0K
1	b	y	t	0Y
2	b	k	t	0.001K
2	b	y	r	0[.,]000000000000000000000001Y

# Limite de descida de 1Y sem estourar a pilha do Bash
1	y	m	t	1152921504606846976M
)
. _lib

#!/usr/bin/env bash
# TODO: area volume
debug=0
values=2
tests=(
fat	5	t	120
sen	60g	t	0.866026
cos	60g	t	0.5
tan	30g	t	0.577351
sec	30g	t	1.154701
csc	45g	t	1.414214
cot	45g	t	1

)
. _lib

values=3
tests=(
mmc	8	12	t	24
mdc	8	12	t	4

media	3[2]	6[3]	t	4.8
soma	2[4]	3[6]	t	26

arranjo	6	2	t	30
arranjo_r	5	3	t	125
combinacao	6	2	t	15
combinacao_r	5	3	t	35

d2p	4.3,5.1	9,12	t	8.348653
egr	1,2	6,3	t	'-x+5y-9=0'
err	6,3	1,2	t	'y=0.2x+1.8'
egc	7,8	1,1	t	'x^2+y^2-14x-16y+28=0'
egc	1,1	5	t	'x^2+y^2-2x-2y-23=0'
ege	1,2,3	4	t	'x^2+y^2+z^2-2x-4y-6z-2=0'
ege	1,2,3	-1,-2,-3	t	'x^2+y^2+z^2-2x-4y-6z-42=0'

converte	gr	60	t	1.047198
converte	rg	1	t	57.29578
converte	K1	2	t	2000

ln	8	''	t	2.079442
log	8	2	t	3
raiz	3	100	t	4.641589
elevado	3	3.3	t	37.540508

fib	9	''	t	'34 '
fib	9	s	t	'0 1 1 2 3 5 8 13 21 34 '
trib	9	''	t	'81 '
trib	9	s	t	'0 1 1 2 4 7 13 24 44 81 '
lucas	9	''	t	'76 '
lucas	9	s	t	'2 1 3 4 7 11 18 29 47 76 '
)
. _lib

values=4
saida1=' X1: -3 
 X2: 0
 Vertice: (-1.5, -2.25)
'
saida2="x^2+y^2-57x+33y+22=0
Centro: (28.5, -16.5)
"
saida3="53.4
6.8"
tests=(
somatoria	5	2	x^3+2	t	232
produtoria	3	7	x^2+5	t	19527480

pa	7	2	6	t	' 7 9 11 13 15 17'
pa2	7	2	6	t	' 7 9 13 19 27 37'
pg	2	7	6	t	' 2 14 98 686 4802 33614'

eq2g	1	3	0	t	"$saida1"
egc3p	1,1	7,8	4,5	t	"$saida2"

asen	0.5	g	''	t	30
acos	0.5	g	''	t	60
atan	2	rad	r2	t	-2.034444

vetor	2,45g,45g	4,-60g,-30g	g	t	'5.591248,89.999981g,29.250584g'

conf_eq	'x^2+3*(y-1)-2z+5'	7,6.8,9	3,2,5.1	t	"$saida3"

area	triangulo	3	4	t	6
area	quadrado	2	''	t	4
area	esfera	2	''	t	50.265482
area	icosidodecaedro	truncado	2	t	433.767968

volume	cubo	snub	3	t	213.01589
volume	cilindro	2	5	t	62.831853
volume	icosidodecaedro	truncado	1	t	201.803399
volume	rombicosidodecaedro	3	''	t	1123.613742
)
. _lib

saida4="(x)^3
-3(x)^2(y)
+3(x)(y)^2
-(y)^3
"
values=5
tests=(
det	1	2	3	4	t	-2
det	9	2	4	6	t	46

area	trapezio	7	3	4	t	20

newton	3	-	x	y	t	"$saida4"
)
. _lib

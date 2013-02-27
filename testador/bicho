#!/usr/bin/env bash
debug=0
values=2

lista="\
 01 Avestruz
 02 Águia
 03 Burro
 04 Borboleta
 05 Cachorro
 06 Cabra
 07 Carneiro
 08 Camelo
 09 Cobra
 10 Coelho
 11 Cavalo
 12 Elefante
 13 Galo
 14 Gato
 15 Jacaré
 16 Leão
 17 Macaco
 18 Porco
 19 Pavão
 20 Peru
 21 Touro
 22 Tigre
 23 Urso
 24 Veado
 25 Vaca
"

tests=(

# Erro
foo	''	r	^Uso:.*
-1	''	r	^Uso:.*
+1	''	r	^Uso:.*
1.0	''	r	^Uso:.*
1,0	''	r	^Uso:.*
# 0	''	t	""

# sem argumentos, ou se $1=g, mostra a lista de bichos
''	''	t	"$lista"
g	''	t	"$lista"

### Testes dos números de cada grupo, de 1 a 25
# Para gerar esta lista de testes:
# for i in $(zzseq 25); do printf "$i\tg\tt\t"; zzbicho $i g | sed 's/.*/"&"/'; done
1	g	t	" 01 02 03 04"
2	g	t	" 05 06 07 08"
3	g	t	" 09 10 11 12"
4	g	t	" 13 14 15 16"
5	g	t	" 17 18 19 20"
6	g	t	" 21 22 23 24"
7	g	t	" 25 26 27 28"
8	g	t	" 29 30 31 32"
9	g	t	" 33 34 35 36"
10	g	t	" 37 38 39 40"
11	g	t	" 41 42 43 44"
12	g	t	" 45 46 47 48"
13	g	t	" 49 50 51 52"
14	g	t	" 53 54 55 56"
15	g	t	" 57 58 59 60"
16	g	t	" 61 62 63 64"
17	g	t	" 65 66 67 68"
18	g	t	" 69 70 71 72"
19	g	t	" 73 74 75 76"
20	g	t	" 77 78 79 80"
21	g	t	" 81 82 83 84"
22	g	t	" 85 86 87 88"
23	g	t	" 89 90 91 92"
24	g	t	" 93 94 95 96"
25	g	t	" 97 98 99 00"

### Testes dos números de 1 a 100
# Para gerar esta lista de testes:
# for i in $(zzseq 100); do printf "$i\t''\tt\t"; zzbicho $i | sed 's/.*/"&"/'; done
1	''	t	" Avestruz (1)"
2	''	t	" Avestruz (1)"
3	''	t	" Avestruz (1)"
4	''	t	" Avestruz (1)"
5	''	t	" Águia (2)"
6	''	t	" Águia (2)"
7	''	t	" Águia (2)"
8	''	t	" Águia (2)"
9	''	t	" Burro (3)"
10	''	t	" Burro (3)"
11	''	t	" Burro (3)"
12	''	t	" Burro (3)"
13	''	t	" Borboleta (4)"
14	''	t	" Borboleta (4)"
15	''	t	" Borboleta (4)"
16	''	t	" Borboleta (4)"
17	''	t	" Cachorro (5)"
18	''	t	" Cachorro (5)"
19	''	t	" Cachorro (5)"
20	''	t	" Cachorro (5)"
21	''	t	" Cabra (6)"
22	''	t	" Cabra (6)"
23	''	t	" Cabra (6)"
24	''	t	" Cabra (6)"
25	''	t	" Carneiro (7)"
26	''	t	" Carneiro (7)"
27	''	t	" Carneiro (7)"
28	''	t	" Carneiro (7)"
29	''	t	" Camelo (8)"
30	''	t	" Camelo (8)"
31	''	t	" Camelo (8)"
32	''	t	" Camelo (8)"
33	''	t	" Cobra (9)"
34	''	t	" Cobra (9)"
35	''	t	" Cobra (9)"
36	''	t	" Cobra (9)"
37	''	t	" Coelho (10)"
38	''	t	" Coelho (10)"
39	''	t	" Coelho (10)"
40	''	t	" Coelho (10)"
41	''	t	" Cavalo (11)"
42	''	t	" Cavalo (11)"
43	''	t	" Cavalo (11)"
44	''	t	" Cavalo (11)"
45	''	t	" Elefante (12)"
46	''	t	" Elefante (12)"
47	''	t	" Elefante (12)"
48	''	t	" Elefante (12)"
49	''	t	" Galo (13)"
50	''	t	" Galo (13)"
51	''	t	" Galo (13)"
52	''	t	" Galo (13)"
53	''	t	" Gato (14)"
54	''	t	" Gato (14)"
55	''	t	" Gato (14)"
56	''	t	" Gato (14)"
57	''	t	" Jacaré (15)"
58	''	t	" Jacaré (15)"
59	''	t	" Jacaré (15)"
60	''	t	" Jacaré (15)"
61	''	t	" Leão (16)"
62	''	t	" Leão (16)"
63	''	t	" Leão (16)"
64	''	t	" Leão (16)"
65	''	t	" Macaco (17)"
66	''	t	" Macaco (17)"
67	''	t	" Macaco (17)"
68	''	t	" Macaco (17)"
69	''	t	" Porco (18)"
70	''	t	" Porco (18)"
71	''	t	" Porco (18)"
72	''	t	" Porco (18)"
73	''	t	" Pavão (19)"
74	''	t	" Pavão (19)"
75	''	t	" Pavão (19)"
76	''	t	" Pavão (19)"
77	''	t	" Peru (20)"
78	''	t	" Peru (20)"
79	''	t	" Peru (20)"
80	''	t	" Peru (20)"
81	''	t	" Touro (21)"
82	''	t	" Touro (21)"
83	''	t	" Touro (21)"
84	''	t	" Touro (21)"
85	''	t	" Tigre (22)"
86	''	t	" Tigre (22)"
87	''	t	" Tigre (22)"
88	''	t	" Tigre (22)"
89	''	t	" Urso (23)"
90	''	t	" Urso (23)"
91	''	t	" Urso (23)"
92	''	t	" Urso (23)"
93	''	t	" Veado (24)"
94	''	t	" Veado (24)"
95	''	t	" Veado (24)"
96	''	t	" Veado (24)"
97	''	t	" Vaca (25)"
98	''	t	" Vaca (25)"
99	''	t	" Vaca (25)"
100	''	t	" Vaca (25)"

### Testa múltiplos de 100, todos devem ter o mesmo resultado do número 1,
### pois a tabela de numeros é cíclica de 100 em 100.
# Para gerar esta lista de testes:
# for i in $(zzseq 1 100 1001); do printf "$i\t''\tt\t"; zzbicho $i | sed 's/.*/"&"/'; done
1	''	t	" Avestruz (1)"
101	''	t	" Avestruz (1)"
201	''	t	" Avestruz (1)"
301	''	t	" Avestruz (1)"
401	''	t	" Avestruz (1)"
501	''	t	" Avestruz (1)"
601	''	t	" Avestruz (1)"
701	''	t	" Avestruz (1)"
801	''	t	" Avestruz (1)"
901	''	t	" Avestruz (1)"
1001	''	t	" Avestruz (1)"
)
. _lib

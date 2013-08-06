# Erro
$ zzbicho	foo		  #→ --regex ^Uso:
$ zzbicho	-1		  #→ --regex ^Uso:
$ zzbicho	+1		  #→ --regex ^Uso:
$ zzbicho	1.0		  #→ --regex ^Uso:
$ zzbicho	1,0		  #→ --regex ^Uso:
# $ zzbicho	 0		  #→ 

# sem argumentos, ou se $1=g, mostra a lista de bichos
$ zzbicho
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
$ zzbicho g
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
$

### Testes dos números de cada grupo, de 1 a 25
# Para gerar esta lista de testes:
# for i in $(zzseq 25); do printf "$ zzbicho\t$i\tg\t#→ "; zzbicho $i g; done

$ zzbicho	1	g	  #→ 01 02 03 04
$ zzbicho	2	g	  #→ 05 06 07 08
$ zzbicho	3	g	  #→ 09 10 11 12
$ zzbicho	4	g	  #→ 13 14 15 16
$ zzbicho	5	g	  #→ 17 18 19 20
$ zzbicho	6	g	  #→ 21 22 23 24
$ zzbicho	7	g	  #→ 25 26 27 28
$ zzbicho	8	g	  #→ 29 30 31 32
$ zzbicho	9	g	  #→ 33 34 35 36
$ zzbicho	10	g	  #→ 37 38 39 40
$ zzbicho	11	g	  #→ 41 42 43 44
$ zzbicho	12	g	  #→ 45 46 47 48
$ zzbicho	13	g	  #→ 49 50 51 52
$ zzbicho	14	g	  #→ 53 54 55 56
$ zzbicho	15	g	  #→ 57 58 59 60
$ zzbicho	16	g	  #→ 61 62 63 64
$ zzbicho	17	g	  #→ 65 66 67 68
$ zzbicho	18	g	  #→ 69 70 71 72
$ zzbicho	19	g	  #→ 73 74 75 76
$ zzbicho	20	g	  #→ 77 78 79 80
$ zzbicho	21	g	  #→ 81 82 83 84
$ zzbicho	22	g	  #→ 85 86 87 88
$ zzbicho	23	g	  #→ 89 90 91 92
$ zzbicho	24	g	  #→ 93 94 95 96
$ zzbicho	25	g	  #→ 97 98 99 00

### Testes dos números de 1 a 100
# Para gerar esta lista de testes:
# for i in $(zzseq 100); do printf "$ zzbicho\t$i\t\t#→ "; zzbicho $i; done

$ zzbicho	1		  #→ Avestruz (1)
$ zzbicho	2		  #→ Avestruz (1)
$ zzbicho	3		  #→ Avestruz (1)
$ zzbicho	4		  #→ Avestruz (1)
$ zzbicho	5		  #→ Águia (2)
$ zzbicho	6		  #→ Águia (2)
$ zzbicho	7		  #→ Águia (2)
$ zzbicho	8		  #→ Águia (2)
$ zzbicho	9		  #→ Burro (3)
$ zzbicho	10		  #→ Burro (3)
$ zzbicho	11		  #→ Burro (3)
$ zzbicho	12		  #→ Burro (3)
$ zzbicho	13		  #→ Borboleta (4)
$ zzbicho	14		  #→ Borboleta (4)
$ zzbicho	15		  #→ Borboleta (4)
$ zzbicho	16		  #→ Borboleta (4)
$ zzbicho	17		  #→ Cachorro (5)
$ zzbicho	18		  #→ Cachorro (5)
$ zzbicho	19		  #→ Cachorro (5)
$ zzbicho	20		  #→ Cachorro (5)
$ zzbicho	21		  #→ Cabra (6)
$ zzbicho	22		  #→ Cabra (6)
$ zzbicho	23		  #→ Cabra (6)
$ zzbicho	24		  #→ Cabra (6)
$ zzbicho	25		  #→ Carneiro (7)
$ zzbicho	26		  #→ Carneiro (7)
$ zzbicho	27		  #→ Carneiro (7)
$ zzbicho	28		  #→ Carneiro (7)
$ zzbicho	29		  #→ Camelo (8)
$ zzbicho	30		  #→ Camelo (8)
$ zzbicho	31		  #→ Camelo (8)
$ zzbicho	32		  #→ Camelo (8)
$ zzbicho	33		  #→ Cobra (9)
$ zzbicho	34		  #→ Cobra (9)
$ zzbicho	35		  #→ Cobra (9)
$ zzbicho	36		  #→ Cobra (9)
$ zzbicho	37		  #→ Coelho (10)
$ zzbicho	38		  #→ Coelho (10)
$ zzbicho	39		  #→ Coelho (10)
$ zzbicho	40		  #→ Coelho (10)
$ zzbicho	41		  #→ Cavalo (11)
$ zzbicho	42		  #→ Cavalo (11)
$ zzbicho	43		  #→ Cavalo (11)
$ zzbicho	44		  #→ Cavalo (11)
$ zzbicho	45		  #→ Elefante (12)
$ zzbicho	46		  #→ Elefante (12)
$ zzbicho	47		  #→ Elefante (12)
$ zzbicho	48		  #→ Elefante (12)
$ zzbicho	49		  #→ Galo (13)
$ zzbicho	50		  #→ Galo (13)
$ zzbicho	51		  #→ Galo (13)
$ zzbicho	52		  #→ Galo (13)
$ zzbicho	53		  #→ Gato (14)
$ zzbicho	54		  #→ Gato (14)
$ zzbicho	55		  #→ Gato (14)
$ zzbicho	56		  #→ Gato (14)
$ zzbicho	57		  #→ Jacaré (15)
$ zzbicho	58		  #→ Jacaré (15)
$ zzbicho	59		  #→ Jacaré (15)
$ zzbicho	60		  #→ Jacaré (15)
$ zzbicho	61		  #→ Leão (16)
$ zzbicho	62		  #→ Leão (16)
$ zzbicho	63		  #→ Leão (16)
$ zzbicho	64		  #→ Leão (16)
$ zzbicho	65		  #→ Macaco (17)
$ zzbicho	66		  #→ Macaco (17)
$ zzbicho	67		  #→ Macaco (17)
$ zzbicho	68		  #→ Macaco (17)
$ zzbicho	69		  #→ Porco (18)
$ zzbicho	70		  #→ Porco (18)
$ zzbicho	71		  #→ Porco (18)
$ zzbicho	72		  #→ Porco (18)
$ zzbicho	73		  #→ Pavão (19)
$ zzbicho	74		  #→ Pavão (19)
$ zzbicho	75		  #→ Pavão (19)
$ zzbicho	76		  #→ Pavão (19)
$ zzbicho	77		  #→ Peru (20)
$ zzbicho	78		  #→ Peru (20)
$ zzbicho	79		  #→ Peru (20)
$ zzbicho	80		  #→ Peru (20)
$ zzbicho	81		  #→ Touro (21)
$ zzbicho	82		  #→ Touro (21)
$ zzbicho	83		  #→ Touro (21)
$ zzbicho	84		  #→ Touro (21)
$ zzbicho	85		  #→ Tigre (22)
$ zzbicho	86		  #→ Tigre (22)
$ zzbicho	87		  #→ Tigre (22)
$ zzbicho	88		  #→ Tigre (22)
$ zzbicho	89		  #→ Urso (23)
$ zzbicho	90		  #→ Urso (23)
$ zzbicho	91		  #→ Urso (23)
$ zzbicho	92		  #→ Urso (23)
$ zzbicho	93		  #→ Veado (24)
$ zzbicho	94		  #→ Veado (24)
$ zzbicho	95		  #→ Veado (24)
$ zzbicho	96		  #→ Veado (24)
$ zzbicho	97		  #→ Vaca (25)
$ zzbicho	98		  #→ Vaca (25)
$ zzbicho	99		  #→ Vaca (25)
$ zzbicho	100		  #→ Vaca (25)

### Testa múltiplos de 100, todos devem ter o mesmo resultado do número 1,
### pois a tabela de numeros é cíclica de 100 em 100.
# Para gerar esta lista de testes:
# for i in $(zzseq 1 100 1001); do printf "$ zzbicho\t$i\t\t#→ "; zzbicho $i; done

$ zzbicho	1		  #→ Avestruz (1)
$ zzbicho	101		  #→ Avestruz (1)
$ zzbicho	201		  #→ Avestruz (1)
$ zzbicho	301		  #→ Avestruz (1)
$ zzbicho	401		  #→ Avestruz (1)
$ zzbicho	501		  #→ Avestruz (1)
$ zzbicho	601		  #→ Avestruz (1)
$ zzbicho	701		  #→ Avestruz (1)
$ zzbicho	801		  #→ Avestruz (1)
$ zzbicho	901		  #→ Avestruz (1)
$ zzbicho	1001		  #→ Avestruz (1)

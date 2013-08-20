# Erro: vazio

$ zzseq				#→ --regex ^Uso:

# Erro: float com ponto

$ zzseq	1.0			#→ Número inválido '1.0'
$ zzseq	1.0	1		#→ Número inválido '1.0'
$ zzseq	1.0	1	1	#→ Número inválido '1.0'
$ zzseq	1	1.0		#→ Número inválido '1.0'
$ zzseq	1	1.0	1	#→ Número inválido '1.0'
$ zzseq	1	1	1.0	#→ Número inválido '1.0'

# Erro: float com vírgula

$ zzseq	1,0			#→ Número inválido '1,0'
$ zzseq	1,0	1		#→ Número inválido '1,0'
$ zzseq	1,0	1	1	#→ Número inválido '1,0'
$ zzseq	1	1,0		#→ Número inválido '1,0'
$ zzseq	1	1,0	1	#→ Número inválido '1,0'
$ zzseq	1	1	1,0	#→ Número inválido '1,0'

# Erro: string

$ zzseq	x			#→ Número inválido 'x'
$ zzseq	x	1		#→ Número inválido 'x'
$ zzseq	x	1	1	#→ Número inválido 'x'
$ zzseq	1	x		#→ Número inválido 'x'
$ zzseq	1	x	1	#→ Número inválido 'x'
$ zzseq	1	1	x	#→ Número inválido 'x'

# Erro: passo zero

$ zzseq	1	0	1	#→ O passo não pode ser zero.

# Desce

$ zzseq	-5
1
0
-1
-2
-3
-4
-5
$ zzseq	-1
1
0
-1
$ zzseq	-0
1
0
$ zzseq	0
1
0
$ zzseq	+0
1
0
$

# Meio

$ zzseq	1
1
$ zzseq	+1
1
$

# Sobe

$ zzseq	5
1
2
3
4
5
$

# Desce faixa

$ zzseq	10	5
10
9
8
7
6
5
$ zzseq	2	0
2
1
0
$ zzseq	2	+0
2
1
0
$ zzseq	2	-0
2
1
0
$ zzseq	2	-2
2
1
0
-1
-2
$ zzseq	-5	-10
-5
-6
-7
-8
-9
-10
$ zzseq	0	-2
0
-1
-2
$

# Sobe faixa

$ zzseq	5	10
5
6
7
8
9
10
$ zzseq	0	2
0
1
2
$ zzseq	+0	2
0
1
2
$ zzseq	-0	2
0
1
2
$ zzseq	-2	2
-2
-1
0
1
2
$ zzseq	-10	-5
-10
-9
-8
-7
-6
-5
$ zzseq	-2	0
-2
-1
0
$

# Desce faixa com passo

$ zzseq	 10	  1	  5
10
9
8
7
6
5
$ zzseq	 10	  2	  5
10
8
6
$ zzseq	 10	 -2	  5
10
8
6
$ zzseq	 10	 99	  5
10
$ zzseq	 4	  2	  0
4
2
0
$ zzseq	 4	  2	 +0
4
2
0
$ zzseq	 4	  2	 -0
4
2
0
$ zzseq	 2	  1	 -2
2
1
0
-1
-2
$ zzseq	 2	  2	 -2
2
0
-2
$ zzseq	 2	 -2	 -2
2
0
-2
$ zzseq	-5	  1	-10
-5
-6
-7
-8
-9
-10
$ zzseq	-5	 -1	-10
-5
-6
-7
-8
-9
-10
$ zzseq	 0	 -1	 -2
0
-1
-2
$

# Sobe faixa com passo

$ zzseq	 5	 1	10
5
6
7
8
9
10
$ zzseq	 5	 2	10
5
7
9
$ zzseq	 5	-2	10
5
7
9
$ zzseq	 5	99	10
5
$ zzseq	 0	 2	 4
0
2
4
$ zzseq	+0	 2	 4
0
2
4
$ zzseq	-0	 2	 4
0
2
4
$ zzseq	-2	 1	 2
-2
-1
0
1
2
$ zzseq	-2	 2	 2
-2
0
2
$ zzseq	-2	-2	 2
-2
0
2
$ zzseq	-10	 1	-5
-10
-9
-8
-7
-6
-5
$ zzseq	-10	-1	-5
-10
-9
-8
-7
-6
-5
$ zzseq	-2	-1	 0
-2
-1
0
$

# Formato
# Nota: Usando --regex para casar linhas sem \n no final

$ zzseq -f Z       5     #→ --regex ^ZZZZZ$
$ zzseq -f '%d'    5     #→ --regex ^12345$
$ zzseq -f '%d:'   5     #→ --regex ^1:2:3:4:5:$
$ zzseq -f '<%d>'  5     #→ --regex ^<1><2><3><4><5>$
$ zzseq -f '%.4d,' 5     #→ --regex ^0001,0002,0003,0004,0005,$

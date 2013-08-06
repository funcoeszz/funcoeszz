$ cat _dados.txt
1:um:one
2:dois:two
3:tres:three
4:quatro:four
5:cinco:five
$ cat _numeros.txt
1
2
3
4
5
$

# Número da linha

$ zzlinha		1	_dados.txt	#→ 1:um:one

# -t regex

$ zzlinha	-t	^2:	_dados.txt	#→ 2:dois:two
$ zzlinha	-t	1	_dados.txt	#→ 1:um:one

# Multimatch: linha aleatória

$ zzlinha	-t	:	_dados.txt	#→ --regex ^[0-9]:[a-z]

# Padrão vazio: linha aleatória

$ zzlinha	-t	''	_dados.txt	#→ --regex ^[0-9]:[a-z]

# Sem argumentos: linha aleatória

$ zzlinha			_dados.txt	#→ --regex ^[0-9]:[a-z]

# Multi arquivos com número da linha: extrai a linha de cada um

$ zzlinha 1 _numeros.txt _dados.txt _numeros.txt
1
1:um:one
1
$

# Multi arquivos com -t: uma única linha aleatória

$ zzlinha -t '^2:\|^1$' _numeros.txt _dados.txt		#→ --regex ^2:|^1$

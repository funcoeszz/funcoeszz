#!/usr/bin/env bash

# Remove o arquivo de lembretes (guardando cópia do original)
test -f ~/.zzlembrete && cp -a ~/.zzlembrete ~/.zzlembrete.orig && rm -f ~/.zzlembrete

values=2
tests=(
# Tudo vazio por enquanto
''	''	t	''
1	''	t	''
0	''	t	''
10	''	t	''
1d	''	t	''
0d	''	t	''
10d	''	t	''

# Adiciona alguns lembretes
lavar 	roupa	t	''
comprar pão	t	''
tomar	banho	t	''

# Mostra
1	''	t	'lavar roupa'
2	''	t	'comprar pão'
3	''	t	'tomar banho'
4	''	t	''
0	''	t	''
''	''	t	"\
     1	lavar roupa
     2	comprar pão
     3	tomar banho
"

# Apaga
2d	''	t	''
''	''	t	"\
     1	lavar roupa
     2	tomar banho
"
0d	''	t	''
10d	''	t	''
''	''	t	"\
     1	lavar roupa
     2	tomar banho
"
1d	''	t	''
1d	''	t	''
1	''	t	''
''	''	t	''

# Comandos inválidos viram lembretes
d	''	t	''
1p	''	t	''
-x	''	t	''
''	''	t	"\
     1	d
     2	1p
     3	-x
"
)
. _lib


# Restaura o arquivo de lembretes original
test -f ~/.zzlembrete.orig && mv ~/.zzlembrete.orig ~/.zzlembrete

# Remove o arquivo de lembretes (guardando cópia do original)
$ test -f ~/.zzlembrete && cp -a ~/.zzlembrete ~/.zzlembrete.orig && rm -f ~/.zzlembrete
$

# Tudo vazio por enquanto

$ zzlembrete
$ zzlembrete	1
$ zzlembrete	0
$ zzlembrete	10
$ zzlembrete	1d
$ zzlembrete	0d
$ zzlembrete	10d
$

# Adiciona alguns lembretes

$ zzlembrete	lavar 	roupa
$ zzlembrete	comprar pão
$ zzlembrete	tomar	banho
$

# Mostra

$ zzlembrete	1
lavar roupa
$ zzlembrete	2
comprar pão
$ zzlembrete	3
tomar banho
$ zzlembrete	4
$ zzlembrete	0
$ zzlembrete
     1	lavar roupa
     2	comprar pão
     3	tomar banho
$

# Apaga

$ zzlembrete	2d
$ zzlembrete
     1	lavar roupa
     2	tomar banho
$ zzlembrete	0d
$ zzlembrete	10d
$ zzlembrete
     1	lavar roupa
     2	tomar banho
$ zzlembrete	1d
$ zzlembrete	1d
$ zzlembrete	1
$ zzlembrete
$

# Comandos inválidos viram lembretes

$ zzlembrete	d
$ zzlembrete	1p
$ zzlembrete	-x
$ zzlembrete
     1	d
     2	1p
     3	-x
$


# Restaura o arquivo de lembretes original
$ test -f ~/.zzlembrete.orig && mv ~/.zzlembrete.orig ~/.zzlembrete
$

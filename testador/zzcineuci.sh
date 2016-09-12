# Preparação filtro
$ filtro='1s/^UCI .*/UCI Cinema/;s/ *$//;s/Livre$/Censura/;s/[0-9][0-9] anos$/Censura/;s/Conteúdo Alternativo/Alternativo  /;s/[^ ]*  *Censura/Genero  Censura/;s/Duração(min) */Duracao_Filme  /;s/[0-9]\{1,\}  *Genero/Duracao_Filme  Genero/;s/.*Duracao/Nome_Filme   Duracao/'
$

$ zzcineuci | sed '1,2d;s/^[A-Z].*/Cidade/;s/ [0-9][0-9] - UCI [A-Z].*/ 99 - UCI Cinema/;/^$/d' | sort -n | uniq
Cidade
 99 - UCI Cinema
$ zzcineuci 1 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 2 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 3 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 4 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 7 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 8 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 9 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 10 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 11 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 12 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 13 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 14 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 15 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 17 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 18 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 20 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 21 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 22 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 23 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 24 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$ zzcineuci 25 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$

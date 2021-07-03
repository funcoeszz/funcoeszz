# Uso incorreto

$ zzcineuci tokyo  ;echo $?
Uso: zzcineuci [codigo_cinema]
1
$ zzcineuci 999    ;echo $?
Não encontrei o cinema 999
1
$

# Sem argumentos mostra a lista de cidades/cinemas

$ zzcineuci | sed '1,2d;s/^[A-Z].*/Cidade/;s/ [0-9][0-9] - UCI [A-Z].*/ 99 - UCI Cinema/;/^$/d' | sort -n | uniq
Cidade
 99 - UCI Cinema
$ zzcineuci
Belém
 25 - UCI Bosque Grão-Pará

Campo Grande
 20 - UCI Bosque dos Ipês

Canoas
 26 - UCI ParkShopping Canoas

Curitiba
 15 - UCI Palladium
 01 - UCI Estação

Fortaleza
 10 - UCI Kinoplex Iguatemi Fortaleza
 23 - UCI Shopping Parangaba

Juiz de Fora
 12 - UCI Kinoplex Independência

Manaus
 24 - UCI Sumaúma Park Shopping

Recife
 14 - UCI Kinoplex Plaza Casa Forte Shopping
 22 - UCI Kinoplex De Lux Shopping Recife
 04 - UCI Kinoplex Shopping Recife
 05 - UCI Kinoplex Shopping Tacaruna

Ribeirão Preto
 02 - UCI RibeirãoShopping

Rio de Janeiro
 11 - UCI Kinoplex NorteShopping
 07 - UCI New York City Center
 18 - UCI ParkShopping Campo Grande

Salvador
 21 - UCI Orient Shopping Barra
 17 - UCI Orient Paralela
 03 - UCI Orient Shopping da Bahia

São Luís
 19 - UCI Kinoplex Shopping da Ilha

São Paulo
 13 - UCI Santana Parque Shopping
 08 - UCI Jardim Sul
 09 - UCI Anália Franco
$

# Uso normal, informando número e cidade

$ filtro='1s/^UCI .*/UCI Cinema/;s/ *$//;s/Livre$/Censura/;s/[0-9][0-9] anos$/Censura/;s/Conteúdo Alternativo/Alternativo  /;s/Comédia Romântica/Comédia  /;s/Ficção Científica/Ficção/;s/[^ ]*  *Censura/Genero  Censura/;s/Duração(min) */Duracao_Filme  /;s/[0-9]\{1,\}  *Genero/Duracao_Filme  Genero/;s/.*Duracao/Nome_Filme   Duracao/'
$ zzcineuci 1 | sed "$filtro" | uniq
UCI Cinema
Nome_Filme   Duracao_Filme  Genero  Censura
$

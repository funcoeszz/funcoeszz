# Uso incorreto

$ zzcinemark 1234  ;echo $?
Não encontrei o cinema 1234
1
$

# Sem argumentos mostra a lista de cidades/cinemas

$ zzcinemark | sed '/^$/q' | sort -n

1 São Paulo
 662 Raposo Shopping
 682 Cidade Jardim
 684 Metro Santa Cruz
 687 Shopping D
 688 Market Place
 690 Boulevard Tatuape
 699 Center Norte
 705 Central Plaza
 707 Shopping Iguatemi SP
 710 SP Market
 711 Metro Tatuape
 714 Interlagos
 715 Eldorado
 716 Aricanduva
 721 Patio Higienopolis
 723 Patio Paulista
 727 Villa Lobos
 758 Metro Tucuruvi
 2103 Mooca Plaza Shopping
 2110 Tiete Plaza Shopping
 2114 Lar Center
 2119 Cidade Sao Paulo
$

# Uso normal, informando número (e data)

$ filtro='1s/.*/CINEMA/; /^Dia: [0-3][0-9]-[0-1][0-9]-[0-9]\{4\}$/s/.*/DATA/; / \(Livre\|[0-1][0-9] Anos\)$/d; /[0-2][0-9]h[0-5][0-9]/s/.*/HORARIO/; /^$/s/^/AA/; /[^A-Z][^A-Z]/{s/.*/FILME/;}'
$ zzcinemark 687 | sed "$filtro" | sort | uniq
AA
CINEMA
DATA
FILME
HORARIO
$ zzcinemark 687 sábado | sed "$filtro" | sort | uniq
AA
CINEMA
DATA
FILME
HORARIO
$

# Data inválida mostra os filmes do hoje

$ zzcinemark 687 foobar | sed "$filtro" | sort | uniq
AA
CINEMA
DATA
FILME
HORARIO
$

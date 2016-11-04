# Preparação filtro
$ filtro='1s/.*/CINEMA/; /^Dia: [0-3][0-9]-[0-1][0-9]-[0-9]\{4\}$/s/.*/DATA/; / \(Livre\|[0-1][0-9] Anos\)$/d; /[0-2][0-9]h[0-5][0-9]/s/.*/HORARIO/; /^$/s/^/AA/; /[^A-Z][^A-Z]/{s/.*/FILME/;}'
$

$ zzcinemark 687 | sed "$filtro" | sort | uniq
AA
CINEMA
DATA
FILME
HORARIO
$ zzcinemark 713 | sed "$filtro" | sort | uniq
AA
CINEMA
DATA
FILME
HORARIO
$ zzcinemark 709 | sed "$filtro" | sort | uniq
AA
CINEMA
DATA
FILME
HORARIO
$ zzcinemark 687 | sed "$filtro" | sort | uniq
AA
CINEMA
DATA
FILME
HORARIO
$ zzcinemark 2118 | sed "$filtro" | sort | uniq
AA
CINEMA
DATA
FILME
HORARIO
$ zzcinemark 768 | sed "$filtro" | sort | uniq
AA
CINEMA
DATA
FILME
HORARIO
$ zzcinemark 697 | sed "$filtro" | sort | uniq
AA
CINEMA
DATA
FILME
HORARIO
$ zzcinemark 703 | sed "$filtro" | sort | uniq
AA
CINEMA
DATA
FILME
HORARIO
$ zzcinemark 2108 | sed "$filtro" | sort | uniq
AA
CINEMA
DATA
FILME
HORARIO
$ zzcinemark 2117 | sed "$filtro" | sort | uniq
AA
CINEMA
DATA
FILME
HORARIO
$ zzcinemark 2127 | sed "$filtro" | sort | uniq
AA
CINEMA
DATA
FILME
HORARIO
$

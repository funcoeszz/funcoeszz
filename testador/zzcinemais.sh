# Uso incorreto

$ zzcinemais foo    ;echo $?
Uso: zzcinemais [código cidade]
1
$ zzcinemais 999    ;echo $?
Não encontrei o cinema 999
1
$

# Sem argumentos mostra a lista de cidades/cinemas

$ zzcinemais | tr -d -c '[0-9A-Za-z -]\n'
9 - Uberaba  - MG
11 - Patos de Minas - MG
21 - Guaratinguet - SP
32 - Anpolis - GO
34 - Montes Claros - MG
35 - Shop. Alameda - Juiz de Fora - MG
36 - Ituiutaba - MG
37 - Arax - MG
38 - Lorena - SP
39 - Jardim Norte - Juiz de Fora - MG
40 - Drive-in - Uberlndia - MG
$

# Uso normal, informando o número

$ filtro='/ - [A-Z][A-Z]$/s/.*/CIDADE/;/\/[0-9]\{4\}/s/.*/DATA/;/[0-2][0-9]h[0-5][0-9]/s/.*/HORARIO/;/^$/s/^/AA/;/[^A-Z][^A-Z]/{s/.*/FILME/;}'
$ zzcinemais 9 | sed "$filtro" | sort | uniq
AA
CIDADE
DATA
FILME
HORARIO
$

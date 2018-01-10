# Uso incorreto

$ zzcinepolis 99    ;echo $?             #→ --regex ^Uso:.*\n1
$ zzcinepolis Tokyo ;echo $?             #→ --regex ^Uso:.*\n1

# Sem argumentos mostra a lista de cidades/cinemas

$ zzcinepolis 
Cidades e cinemas disponíveis:
Barueri - SP - Iguatemi Alphaville - 8
Barueri - SP - Parque Barueri - 22
Bauru - SP - Nações Bauru - 34
Belém - PA - Boulevard Belem - 2
Belém - PA - Parque Belem - 20
Belo Horizonte - MG - Estacao BH - 24
Blumenau - SC - Norte Shopping - 10
Campinas - SP - Campinas Shopping - 14
Campo Grande - MS - Norte Sul Plaza - 13
Carapicuíba - SP - Plaza Shopping Carapicuíba - 53
Cariacica - ES - Moxuara - 46
Caxias do Sul - RS - San Pelegrino - 12
Cuiabá - MT - Três Américas - 39
Curitiba - PR - Pátio Batel - 35
Fortaleza - CE - North Shopping Jóquei - 37
Fortaleza - CE - RioMar Fortaleza - 47
Fortaleza - CE - Riomar Kennedy - 54
Goiânia - GO - Cerrado - 52
Guarulhos - SP - Parque Shopping Maia - 48
Jaboatão dos Guararapes - PE - Shopping Guararapes  - 15
João Pessoa - PB - Manaíra Shopping - 16
João Pessoa - PB - Mangabeira - 51
Jundiaí - SP - Jundiaí Shopping - 26
Macapá - AP - Amapá Garden - 49
Manaus - AM - Ponta Negra - 29
Manaus - AM - Manaus Plaza - 40
Manaus - AM - Millennium - 41
Marília - SP - Marília Shopping - 43
Natal - RN - Natal Shopping - 31
Natal - RN - Partage Norte Shopping Natal - 33
Ribeirão Preto - SP - Santa Úrsula - 1
Ribeirão Preto - SP - Iguatemi Ribeirão Preto - 30
Rio de Janeiro - RJ - Lagoon - 6
Salvador - BA - Salvador Norte - 5
Salvador - BA - Bela Vista - 23
São Bernardo do Campo - SP - São Bernardo Plaza - 27
São Gonçalo - RJ - São Gonçalo Shopping - 17
São José do Rio Preto - SP - Iguatemi São José do Rio Preto - 42
São José do Rio Preto - SP - Plaza Avenida SJRP - 44
São José/Florianópolis - SC - Continente Shopping - 25
São Luís - MA - São Luis Shopping - 18
São Paulo - SP - Mais Shopping - 3
São Paulo - SP - Metrô Itaquera - 19
São Paulo - SP - JK Iguatemi - 21
Sorocaba/Votorantim - SP - Iguatemi Esplanada - 36
Teresina - PI - Rio Poty - 50
Uberlândia - MG - Center Shopping Uberlandia - 38
$

# Uso normal, informando número e cidade

$ filtro='2s|[0-3][0-9]/[0-2][0-9]|DATA|; 3s/ filme */filme   /; 4,${ s/Legendado  *//;s/Dublado  *//; s/\([0-2][0-9]:[0-5][0-9] *\)\{1,\}$/HORARIO/; s/[0-9][0-9] anos/99 anos/; s/Livre  /99 anos/; s/NC     /99 anos/; s/^ *[0-9]\{1,\} /  9 /; s/9 .* 9/9   FILME   9/; }'
$ zzcinepolis 17 | sed "$filtro" | uniq
Cinépolis São Gonçalo Shopping
DATA
sala  filme   class.     horários
  9   FILME   99 anos    HORARIO
$ zzcinepolis São Gonçalo | sed "$filtro" | uniq
Cinépolis São Gonçalo Shopping
DATA
sala  filme   class.     horários
  9   FILME   99 anos    HORARIO
$

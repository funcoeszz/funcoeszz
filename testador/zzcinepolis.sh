# Uso incorreto

$ zzcinepolis 99    ;echo $?             #→ --regex ^Uso:.*\n1
$ zzcinepolis Tokyo ;echo $?             #→ --regex ^Uso:.*\n1

# Sem argumentos mostra a lista de cidades/cinemas

$ zzcinepolis | sed 's/  *$//'
Cidades e cinemas disponíveis:
                                             26) Cinépolis Jundiaí Shopping
Barueri - SP:
8) Cinépolis Iguatemi Alphaville             Macapá - AP:
22) Cinépolis Parque Barueri                 49) Cinépolis Amapá Garden

Bauru - SP:                                  Manaus - AM:
34) Cinépolis Nações Bauru                   29) Cinépolis Ponta Negra
                                             40) Cinépolis Manaus Plaza
Belém - PA:                                  41) Cinépolis Millennium
2) Cinépolis Boulevard Belem
20) Cinépolis Parque Belem                   Marília  - SP:
                                             43) Cinépolis Marília Shopping
Belo Horizonte - MG:
24) Cinépolis Estacao BH                     Natal  - RN:
                                             31) Cinépolis Natal Shopping
Blumenau - SC:                               33) Cinépolis Partage Norte Shopping Natal
10) Cinépolis Norte Shopping
                                             Ribeirão Preto - SP:
Campinas - SP:                               1) Cinépolis Santa Úrsula
14) Cinépolis Campinas Shopping              30) Cinépolis Iguatemi Ribeirão Preto

Campo Grande - MS:                           Rio de Janeiro - RJ:
13) Cinépolis Norte Sul Plaza                6) Cinépolis Lagoon

Carapicuíba - SP:                            Salvador - BA:
53) Cinépolis Plaza Shopping Carapicuíba     5) Cinépolis Salvador Norte
                                             23) Cinépolis Bela Vista
Cariacica - ES:
46) Cinépolis Moxuara                        São Bernardo do Campo - SP:
                                             27) Cinépolis São Bernardo Plaza
Caxias do Sul - RS:
12) Cinépolis San Pelegrino                  São Gonçalo - RJ:
                                             17) Cinépolis São Gonçalo Shopping
Cuiabá - MT:
39) Cinépolis Três Américas                  São José do Rio Preto - SP:
                                             42) Cinépolis Iguatemi São José do Rio Preto
Curitiba - PR:                               44) Cinépolis Plaza Avenida SJRP
35) Cinépolis Pátio Batel
                                             São José/Florianópolis - SC:
Fortaleza - CE:                              25) Cinépolis Continente Shopping
37) Cinépolis North Shopping Jóquei
47) Cinépolis RioMar Fortaleza               São Luís - MA:
54) Cinépolis Riomar Kennedy                 18) Cinépolis São Luis Shopping

Goiânia - GO:                                São Paulo - SP:
52) Cinépolis Cerrado                        3) Cinépolis Mais Shopping
                                             19) Cinépolis Metrô Itaquera
Guarulhos - SP:                              21) Cinépolis JK Iguatemi
48) Cinépolis Parque Shopping Maia
                                             Sorocaba/Votorantim - SP:
Jaboatão dos Guararapes - PE:                36) Cinépolis Iguatemi Esplanada
15) Cinépolis Shopping Guararapes
                                             Teresina - PI:
João Pessoa - PB:                            50)  Cinépolis Rio Poty
16) Cinépolis Manaíra Shopping
51) Cinépolis Mangabeira                     Uberlândia - MG:
                                             38) Cinépolis Center Shopping Uberlandia
Jundiaí - SP:
$

# Uso normal, informando número e cidade

$ filtro='2s|[0-3][0-9]/[0-2][0-9] .*|DATA|; 3s/ filme */filme   /; 4,${ s/Legendado  *//;s/Dublado  *//; s/\([0-2][0-9]:[0-5][0-9] *\)\{1,\}$/HORARIO/; s/[0-9][0-9] anos/99 anos/; s/Livre  /99 anos/; s/NC     /99 anos/; s/^ *[0-9]\{1,\} /  9 /; s/9 .* 9/9   FILME   9/; }'
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

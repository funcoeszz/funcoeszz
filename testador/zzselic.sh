# Taxa para uma data específica
$ zzselic 05/11/1987
Data        Taxa (%a.a.)
05/11/1987  287,57
$

# Saída como CSV
$ zzselic -c 05/11/1987
Data;Taxa (%a.a.)
05/11/1987;287,57
$

# Todas as informações disponíveis além da data e taxa em CSV
$ zzselic -e -c 05/11/1987
Data;Taxa (%a.a.);Fator diário;Base de cálculo (R$);Média;Mediana;Moda;Desvio padrão;Índice de curtose
05/11/1987;287,57;1,00539041;0,00;0,00;0,00;0,00;0,00;0,00
$

# Taxa nos dias úteis num dado intervalo
# Dia 4 foi feriado e os dias 6 e 7 foram um final de semana
# A taxa só é divulgada em dias úteis
$ zzselic 01/06/2015 07/06/2015
Data        Taxa (%a.a.)
01/06/2015  13,15
02/06/2015  13,15
03/06/2015  13,15
05/06/2015  13,65
$

# Informação completa para um período de 2 meses
$ zzselic -e 01/02/2016 01/03/2016
Data        Taxa (%a.a.)  Fator diário  Base de cálculo (R$)  Média  Mediana  Moda   Desvio padrão  Índice de curtose
01/02/2016  14,15         1,00052531    508.556.347.180,82    14,15  14,14    14,15  0,02           1.273,30
02/02/2016  14,15         1,00052531    505.313.661.912,77    14,15  14,14    14,15  0,02           811,79
03/02/2016  14,15         1,00052531    517.982.799.190,54    14,15  14,14    14,15  0,02           1.500,87
04/02/2016  14,15         1,00052531    508.713.690.983,08    14,15  14,14    14,15  0,02           1.724,92
05/02/2016  14,15         1,00052531    468.586.271.662,16    14,15  14,14    14,15  0,02           2.154,98
10/02/2016  14,15         1,00052531    495.862.304.302,51    14,15  14,14    14,15  0,02           787,38
11/02/2016  14,15         1,00052531    511.203.046.451,66    14,15  14,14    14,15  0,02           510,49
12/02/2016  14,15         1,00052531    502.132.741.707,17    14,15  14,14    14,15  0,02           937,43
15/02/2016  14,15         1,00052531    544.352.401.489,07    14,15  14,14    14,15  0,02           946,69
16/02/2016  14,15         1,00052531    552.534.634.704,54    14,14  14,14    14,15  0,10           239,43
17/02/2016  14,15         1,00052531    558.888.721.712,81    14,15  14,14    14,15  0,02           3.088,74
18/02/2016  14,15         1,00052531    555.335.654.990,37    14,15  14,14    14,15  0,02           2.518,93
19/02/2016  14,15         1,00052531    549.346.758.044,96    14,15  14,14    14,15  0,02           1.891,23
22/02/2016  14,15         1,00052531    527.565.609.965,87    14,15  14,14    14,15  0,02           2.474,61
23/02/2016  14,15         1,00052531    518.506.693.214,99    14,15  14,14    14,15  0,02           1.276,78
24/02/2016  14,15         1,00052531    523.175.749.697,64    14,15  14,14    14,15  0,02           636,49
25/02/2016  14,15         1,00052531    513.631.397.709,67    14,15  14,14    14,15  0,02           600,12
26/02/2016  14,15         1,00052531    499.627.411.173,89    14,15  14,14    14,15  0,02           613,15
29/02/2016  14,15         1,00052531    502.515.813.722,75    14,15  14,14    14,15  0,03           388,84
01/03/2016  14,15         1,00052531    526.984.539.616,98    14,14  14,14    14,15  0,05           262,46
$

# Datas em formatos inválidos não devem ser aceitas
$ zzselic 01-jan-2015 hoje
Número inválido '01-jan-2015'
$

# Opções desconhecidas não devem ser aceitas
$ zzselic -t hoje #→ --regex ^Opção
$

# O site do BC não informa a taxa antes de 04/06/1986
$ zzselic 03/06/1986
Dados disponíveis apenas a partir de 04/06/1986.
$ zzselic 04/06/1986
Data        Taxa (%a.a.)
04/06/1986  17,80
$

# A data inicial é depois da data final?
$ zzselic hoje ontem
Data inicial depois da final.
$ zzselic 10/06/2015 15/05/2015
Data inicial depois da final.
$

# Temos dias úteis no intervalo? A taxa só divulgada em dias úteis.
$ zzselic 18/04/2014 20/04/2014
Não há dias úteis entre as datas informadas.
$

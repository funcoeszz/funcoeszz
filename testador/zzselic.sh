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

# Datas em formatos inválidos não devem ser aceitas
$ zzselic 01-jan-2015 hoje
Número inválido '01-jan-2015'
$

# Opções desconhecidas não devem ser aceitas
$ zzselic -t hoje #=> --regex ^Opção
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

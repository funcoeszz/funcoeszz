#!/usr/bin/env bash

values=2
tests=(
''	foo		r	'^Data inv.lida .*'
''	1		r	'^Data inv.lida .*'
-l	foo		r	'^Ano inv.lido .*'
-l	25/12		r	'^Ano inv.lido .*'

''	25/12/2008	t	'É feriado: 25/12/2008'
''	26/12/2008	t	'Não é feriado: 26/12/2008'

-l	2010	t	"\
01/01 sexta-feira     Confraternização Universal
16/02 terça-feira     Carnaval
02/04 sexta-feira     Sexta-ferida da Paixao
21/04 quarta-feira    Tiradentes
01/05 sábado          Dia do Trabalho
03/06 quinta-feira    Corpu Christi
07/09 terça-feira     Independência do Brasil
12/10 terça-feira     Nossa Sra. Aparecida
02/11 terça-feira     Finados
15/11 segunda-feira   Proclamação da República
25/12 sábado          Natal"


)
. _lib

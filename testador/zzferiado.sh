$ zzferiado		foo		#→ --regex ^Data inválida 
$ zzferiado		1		#→ --regex ^Data inválida 
$ zzferiado	-l	foo		#→ --regex ^Ano inválido 
$ zzferiado	-l	25/12		#→ --regex ^Ano inválido 

$ zzferiado		25/12/2008	#→ É feriado: 25/12/2008
$ zzferiado		26/12/2008	#→ Não é feriado: 26/12/2008

$ zzferiado -l 2010
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
25/12 sábado          Natal
$


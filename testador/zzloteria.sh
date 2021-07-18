$ zzloteria quina | tr '[0-9]' 'N' | head -3 | sed 's|()|(NN/NN/NNNN)|;s|Hoje|NN/NN/NNNN|;s/?[ ]\{,1\}/NN/g;s/?[ ]\{,1\}/NN/g;3s/^\(.\{15\}\).*/\1/'
quina:
Concurso NNNN (NN/NN/NNNN)
	NN	NN	NN	NN	NN
$

$ zzloteria megasena | tr '[0-9]' 'N' | head -3 | sed 's|()|(NN/NN/NNNN)|;s|Hoje|NN/NN/NNNN|;s/?[ ]\{,1\}/NN/g'
megasena:
Concurso NNNN (NN/NN/NNNN)
	NN	NN	NN	NN	NN	NN
$

$ zzloteria duplasena | tr '[0-9]' 'N' | head -6 | sed 's|()|(NN/NN/NNNN)|;s|Hoje|NN/NN/NNNN|;s/?[ ]\{,1\}/NN/g;s/ *Nº/Nº/'
duplasena:
Concurso NNNN (NN/NN/NNNN)

Nº Sorteio
	NN	NN	NN	NN	NN	NN

$

$ zzloteria lotomania | tr '[0-9]' 'N' | head -6 | sed 's|()|(NN/NN/NNNN)|;s|Hoje|NN/NN/NNNN|;s/?[ ]\{,1\}/NN/g'
lotomania:
Concurso NNNN (NN/NN/NNNN)
	NN	NN	NN	NN	NN
	NN	NN	NN	NN	NN
	NN	NN	NN	NN	NN
	NN	NN	NN	NN	NN
$

$ zzloteria lotofacil | tr '[0-9]' 'N' | head -5 | sed 's|()|(NN/NN/NNNN)|;s|Hoje|NN/NN/NNNN|;s/?[ ]\{,1\}/NN/g'
lotofacil:
Concurso NNNN (NN/NN/NNNN)
	NN	NN	NN	NN	NN
	NN	NN	NN	NN	NN
	NN	NN	NN	NN	NN
$

$ zzloteria federal | tr '[0-9.]' 'N' | sed 's/NN*/N/g;s|Hoje|N/N/N|'
federal:
Concurso N (N/N/N)
Nº	N	N	N,N
Nº	N	N	N,N
Nº	N	N	N,N
Nº	N	N	N,N
Nº	N	N	N,N

$

$ zzloteria timemania | tr '[0-9.]' 'N' | head -3 | sed 's|()|(NN/NN/NNNN)|;s|Hoje|NN/NN/NNNN|;s/?[ ]\{,1\}/NN/g'
timemania:
Concurso NNNN (NN/NN/NNNN)
	NN	NN	NN	NN	NN	NN	NN
$

$ zzloteria sorte | tr '[0-9]' 'N' | sed 's|Hoje|NN/NN/NNNN|'| head -n 3
sorte:
Concurso NNN (NN/NN/NNNN)
	NN	NN	NN	NN	NN	NN	NN
$

$ zzloteria sete | tr '[0-9]' 'N' | sed 's|Hoje|NN/NN/NNNN|'| head -n 3
sete:
Concurso NNN (NN/NN/NNNN)
	N	N	N	N	N	N	N
$

$ zzloteria loteca 500 | tr '[0-9]' 'N' | head -17 | sed 's/Col. Meio/  Col. N/'
loteca:
Concurso NNN (NN/NN/NNNN)
 Jogo   Resultado
  N      Col. N
  N      Col. N
  N      Col. N
  N      Col. N
  N      Col. N
  N      Col. N
  N      Col. N
  N      Col. N
  N      Col. N
 NN      Col. N
 NN      Col. N
 NN      Col. N
 NN      Col. N
 NN      Col. N
$

$ zzloteria timemania 600 | tr '[0-9]' 'N' | head -3
timemania:
Concurso NNN (NN/NN/NNNN)
   NN   NN   NN   NN   NN   NN   NN
$

$ zzloteria federal 2500 2>&1 | grep -v ^Aguarde
federal:
Concurso 2500 (11/01/1989)

   1º Premio     66069   R$ 200000.00
   2º Premio     77589   R$ 8000.00
   3º Premio     60325   R$ 5000.00
   4º Premio     03547   R$ 4000.00
   5º Premio     48642   R$ 2000.00

$

$ zzloteria duplasena 1000 2>&1 | grep -v ^Aguarde
duplasena:
Concurso 1000 (06/09/2011)

  1º sorteio
   07   09   18   42   45   46

  2º sorteio
   03   13   31   32   36   39

  1º Sorteio
   Sena  	0	R$ 0,00
   Quina 	55	R$ 2.224,60
   Quadra	2368	R$ 49,20

  2º Sorteio
   Sena  	1	R$ 163.137,83
   Quina 	77	R$ 1.589,00
   Quadra	2560	R$ 45,51

$

$ zzloteria quina 3000 2>&1 | grep -v ^Aguarde
quina:
Concurso 3000 (20/09/2012)
   02   21   31   37   57

   Quina       0         R$ 0,00
   Quadra      54        R$ 6.681,90
   Terno       4528      R$ 113,83

$

# Testa o resultado histórico da megasena em dois casos diferentes:
# quando há uma cidade informada no segundo campo dos dados oficiais
# (concurso 1111) e quando não há (concurso 100)

$ zzloteria megasena 1111 2>&1 | grep -v ^Aguarde
megasena:
Concurso 1111 (23/09/2009)
  04   09   25   32   33   43

   Sena        1         R$ 2.100.928,15
   Quina       52        R$ 21.932,77
   Quadra      5266      R$ 309,39

$ zzloteria megasena 100
megasena:
Concurso 100 (01/02/1998)
  14   29   30   46   48   51

   Sena        0         R$ 0,00
   Quina       56        R$ 15.930,48
   Quadra      3600      R$ 247,32

$

$ zzloteria lotomania 750
lotomania:
Concurso 750 (18/08/2007)
   04     07     19     22     24
   30     38     41     45     53
   57     66     68     72     75
   77     80     83     92     94

   20 pts.     5         R$ 1.364.031,89
   19 pts.     66        R$ 7.504,25
   18 pts.     595       R$ 832,40
   17 pts.     4489      R$ 54,96
   16 pts.     21493     R$ 11,48
    0 pts.     3         R$ 82.546,71

$

$ zzloteria lotofacil 1099
lotofacil:
Concurso 1099 (25/08/2014)
   02     03     06     07     08
   11     12     13     14     16
   21     22     23     24     25

   15 pts.     Nao houve acertador! 
   14 pts.     445       R$ 1.278,83
   13 pts.     13926     R$ 15,00
   12 pts.     204099    R$ 6,00
   11 pts.     1108572   R$ 3,00

$

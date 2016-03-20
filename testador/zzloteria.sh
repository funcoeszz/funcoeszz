$ ZZCOR=0 zzloteria quina | tr '[0-9]' 'N' | head -3
quina:
Concurso NNNN (NN/NN/NNNN)
   NN   NN   NN   NN   NN
$

$ ZZCOR=0 zzloteria megasena | tr '[0-9]' 'N' | head -3
megasena:
Concurso NNNN (NN/NN/NNNN)
   NN   NN   NN   NN   NN   NN
$

$ ZZCOR=0 zzloteria duplasena | tr '[0-9]' 'N' | head -8
duplasena:
Concurso NNNN (NN/NN/NNNN)

  Nº sorteio
   NN   NN   NN   NN   NN   NN

  Nº sorteio
   NN   NN   NN   NN   NN   NN
$

$ ZZCOR=0 zzloteria lotomania | tr '[0-9]' 'N' | head -6 | sed 's/ *$//'
lotomania:
Concurso NNNN (NN/NN/NNNN)
   NN     NN     NN     NN     NN
   NN     NN     NN     NN     NN
   NN     NN     NN     NN     NN
   NN     NN     NN     NN     NN
$
$ ZZCOR=0 zzloteria lotofacil | tr '[0-9]' 'N' | head -5 | sed 's/ *$//'
lotofacil:
Concurso NNNN (NN/NN/NNNN)
   NN     NN     NN     NN     NN
   NN     NN     NN     NN     NN
   NN     NN     NN     NN     NN
$

$ ZZCOR=0 zzloteria federal | tr '[0-9.]' 'N' | sed 's/ *$//'
federal:
Concurso NNNNN (NN/NN/NNNN)

   Destino Bilhete Valor do Prêmio (R$)
   Nº      NNNNN   R$ NNNNNNN,NN
   Nº      NNNNN   R$ NNNNNN,NN
   Nº      NNNNN   R$ NNNNNN,NN
   Nº      NNNNN   R$ NNNNNN,NN
   Nº      NNNNN   R$ NNNNNN,NN

$

$ ZZCOR=0 zzloteria timemania | tr '[0-9.]' 'N' | head -3
timemania:
Concurso NNN (NN/NN/NNNN)
   NN   NN   NN   NN   NN   NN   NN
$

$ ZZCOR=0 zzloteria loteca | tr '[0-9]' 'N' | head -17 | sed 's/Meio/N/;s/^ *N\{1,2\} .*\(N X\)/NN TIME1 N X/; s/X N.* Col\./X N TIME2 Col./;s/ *Jogo *Resultado/Jogo                 Resultado/'
loteca:
Concurso NNN (NN/NN/NNNN)
Jogo                 Resultado
NN TIME1 N X N TIME2 Col. N
NN TIME1 N X N TIME2 Col. N
NN TIME1 N X N TIME2 Col. N
NN TIME1 N X N TIME2 Col. N
NN TIME1 N X N TIME2 Col. N
NN TIME1 N X N TIME2 Col. N
NN TIME1 N X N TIME2 Col. N
NN TIME1 N X N TIME2 Col. N
NN TIME1 N X N TIME2 Col. N
NN TIME1 N X N TIME2 Col. N
NN TIME1 N X N TIME2 Col. N
NN TIME1 N X N TIME2 Col. N
NN TIME1 N X N TIME2 Col. N
NN TIME1 N X N TIME2 Col. N
$

$ ZZCOR=0 zzloteria loteca 500 | tr '[0-9]' 'N' | head -17 | sed 's/Col. Meio/  Col. N/'
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

$ ZZCOR=0 zzloteria timemania 600 | tr '[0-9]' 'N' | head -3
timemania:
Concurso NNN (NN/NN/NNNN)
   NN   NN   NN   NN   NN   NN   NN
$

$ ZZCOR=0 zzloteria federal 2500
federal:
Concurso 02500 (11/01/1989)

   1º Premio     66069   R$ 200.000,00
   2º Premio     77589   R$ 8.000,00
   3º Premio     60325   R$ 5.000,00
   4º Premio     03547   R$ 4.000,00
   5º Premio     48642   R$ 2.000,00

$

$ zzloteria duplasena 1000
duplasena:
Concurso 1000 (06/09/2011)

  1º sorteio
   07   09   18   42   45   46

  2º sorteio
   03   13   31   32   36   39

  1º Sorteio
   Sena  	Nao houve acertador	
   Quina 	55	R$ 2.224,60
   Quadra	2368	R$ 2368

  2º Sorteio
   Sena  	1	R$ 163.137,83
   Quina 	77	R$ 1.589,00
   Quadra	2560	R$ 45,51

$

$ zzloteria quina 3000
quina:
Concurso 3000 (20/09/2012)
   02   21   31   37   57

   Quina       Nao houve acertador 
   Quadra      54        R$ 6.681,90
   Terno       4528      R$ 4528

$

$ zzloteria megasena 1111
megasena:
Concurso 1111 (23/09/2009)
  04   09   25   32   33   43

   Sena        1         R$ 2.100.928,15
   Quina       52        R$ 21.932,77
   Quadra      5266      R$ 309,39

$

$ zzloteria lotomania 750
lotomania:
Concurso 750 (18/08/2007)
   04     07     19     22     24
   30     38     41     45     53
   57     66     68     72     75
   77     80     83     92     94

   20 pts.     5         R$ 3
   19 pts.     AM        R$ 1.364.031,89
   18 pts.     66        R$ 7.504,25
   17 pts.     595       R$ 832,40
   16 pts.     4489      R$ 54,96
    0 pts.     21493     R$ 11,48

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

$ zzloteria2 quina | sed '2{s/[0-9][0-9]/99/g;};3{s/[0-9]\{1,\}/NUM/;};s|[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]|DATA|;4,${s/ [0-9.]\{1,\} \{1,\}/ QTDE           /;s/ [0-9.,]\{1,\}/ VALOR/;}'
quina:
   99 - 99 - 99 - 99 - 99 
   Concurso NUM (DATA)
   Acumulado em R$ VALOR para DATA
     Faixa       Qtde.          Prêmio
     Quina       QTDE           VALOR
     Quadra      QTDE           VALOR
     Terno       QTDE           VALOR

$
$ zzloteria2 megasena | sed '2{s/[0-9][0-9]/99/g;};3{s/[0-9]\{1,\}/NUM/;};s|[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]|DATA|;4,${s/ [0-9.]\{1,\} \{1,\}/ QTDE           /;s/ [0-9.,]\{1,\}/ VALOR/;}'
megasena:
   99 - 99 - 99 - 99 - 99 - 99 
   Concurso NUM (DATA)
   Acumulado em R$ VALOR para DATA
     Faixa       Qtde.          Prêmio
     Sena        QTDE           VALOR
     Quina       QTDE           VALOR
     Quadra      QTDE           VALOR

$

$ zzloteria2 duplasena | sed '2,3{s/[0-9][0-9]/99/g;};4{s/[0-9]\{1,\}/NUM/;};s|[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]|DATA|;5,${s/[123]a/Pa/;s/ [0-9.]\{1,\} \{1,\}/ QTDE           /;s/ [0-9.,]\{1,\}/ VALOR/;}'
duplasena:
   99 - 99 - 99 - 99 - 99 - 99 
   99 - 99 - 99 - 99 - 99 - 99 
   Concurso NUM (DATA)
   Acumulado em R$ VALOR para DATA
     Faixa       Qtde.          Prêmio
     Pa Sena     QTDE           VALOR
     Pa Quina    QTDE           VALOR
     Pa Quadra   QTDE           VALOR
                 
     Pa Sena     QTDE           VALOR
     Pa Quina    QTDE           VALOR
     Pa Quadra   QTDE           VALOR

$

$ zzloteria2 lotomania | sed '2,3{s/[0-9][0-9]/99/g;};4{s/[0-9]\{1,\}/NUM/;};s|[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]|DATA|;5,${s/[ 12][09876] ptos/XX ptos/;s/ [0-9.]\{1,\} \{1,\}/ QTDE           /;s/ [0-9.,]\{1,\}/ VALOR/;}'
lotomania:
   99 - 99 - 99 - 99 - 99 - 99 - 99 - 99 - 99 - 99
   99 - 99 - 99 - 99 - 99 - 99 - 99 - 99 - 99 - 99
   Concurso NUM (DATA)
   Acumulado em R$ VALOR para DATA
     Faixa       Qtde.          Prêmio
     XX ptos     QTDE           VALOR
     XX ptos     QTDE           VALOR
     XX ptos     QTDE           VALOR
     XX ptos     QTDE           VALOR
     XX ptos     QTDE           VALOR
     XX ptos     QTDE           VALOR

$

$ zzloteria2 lotofacil | sed '2,4{s/[0-9][0-9]/99/g;};5{s/[0-9]\{1,\}/NUM/;};s|[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]|DATA|;6,${s/1[1-5] ptos/XX ptos/;s/ [0-9.]\{1,\} \{1,\}/ QTDE           /;s/ [0-9.,]\{1,\}/ VALOR/;}'
lotofacil:
   99 - 99 - 99 - 99 - 99
   99 - 99 - 99 - 99 - 99
   99 - 99 - 99 - 99 - 99
   Concurso NUM (DATA)
   Acumulado em R$ VALOR para DATA
     Faixa       Qtde.          Prêmio
     XX ptos     QTDE           VALOR
     XX ptos     QTDE           VALOR
     XX ptos     QTDE           VALOR
     XX ptos     QTDE           VALOR
     XX ptos     QTDE           VALOR

$

$ zzloteria2 federal| sed '7{s/[0-9]\{1,\}/NUM/;};s|[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]|DATA|;2,6{s/[1-5]o /Po /;s/[0-9.]\{1,\}/NUMERO/;s/[0-9.,]\{1,\}/VALOR/;}'
federal:
   Po Prêmio	NUMERO	VALOR
   Po Prêmio	NUMERO	VALOR
   Po Prêmio	NUMERO	VALOR
   Po Prêmio	NUMERO	VALOR
   Po Prêmio	NUMERO	VALOR
   Concurso NUM (DATA)

$

$ zzloteria2 timemania | sed '2{s/[0-9][0-9]/99/g;};3s/^ *Time:.*/TIME/;4{s/[0-9]\{1,\}/NUM/;};s|[0-9]\{1,2\}/[0-9]\{1,2\}/[0-9][0-9][0-9][0-9]|DATA|;5,${s/[3-7] ptos/X ptos/;s/ [0-9.]\{1,\} \{1,\}/ QTDE           /;s/ [0-9.,]\{1,\}/ VALOR/;}'
timemania:
   99 - 99 - 99 - 99 - 99 - 99 - 99 
TIME
   Concurso NUM (DATA)
   Acumulado em R$ VALOR para DATA
     Faixa       Qtde.          Prêmio
     X ptos      QTDE           VALOR
     X ptos      QTDE           VALOR
     X ptos      QTDE           VALOR
     X ptos      QTDE           VALOR
     X ptos      QTDE           VALOR

$

$ zzloteria2 loteca | sed 's|[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]|DATA|;s/ cinco / NUM /;s/ zero / NUM /;s/[0-9.]\{1,\},[0-9]\{2\}/VALOR/;s/1a /Pa /;3,20{s/[0-9]/N/g;s/Meio/ N/;};22,23{s/1[432]   /FAIXA/;s/ [.0-9]\{1,6\} */QTDE           /;};3,16s/\(.\{15\}\)\(.\{57\}\)/\1TIME1                                              TIME2 /'
loteca:
      Jogo     Coluna 1                                        Coluna 2     Coluna 
       N    N  TIME1                                              TIME2  N  Col.  N
       N    N  TIME1                                              TIME2  N  Col.  N
       N    N  TIME1                                              TIME2  N  Col.  N
       N    N  TIME1                                              TIME2  N  Col.  N
       N    N  TIME1                                              TIME2  N  Col.  N
       N    N  TIME1                                              TIME2  N  Col.  N
       N    N  TIME1                                              TIME2  N  Col.  N
       N    N  TIME1                                              TIME2  N  Col.  N
       N    N  TIME1                                              TIME2  N  Col.  N
       NN   N  TIME1                                              TIME2  N  Col.  N
       NN   N  TIME1                                              TIME2  N  Col.  N
       NN   N  TIME1                                              TIME2  N  Col.  N
       NN   N  TIME1                                              TIME2  N  Col.  N
       NN   N  TIME1                                              TIME2  N  Col.  N
   Concurso NNN (DATA)
   Acumulado em R$ VALOR para DATA
   Acumulado para a Pa faixa VALOR
   Acumulado para o proximo concurso de final NUM (NNN): R$ VALOR
     Faixa       Qtde.          Prêmio
     FAIXA       QTDE           VALOR 
     FAIXA       QTDE           VALOR   

$

$ zzloteria2 loteca 500
loteca:
      Jogo     Coluna 1                                        Coluna 2     Coluna 
       1    1  SANTOS/SP                                 CORINTHIANS/SP  0  Col.  1
       2    3  BOTAFOGO/RJ                             VOLTA REDONDA/RJ  1  Col.  1
       3    0  FLUMINENSE/BA                                   BAHIA/BA  2  Col.  2
       4    3  GAMA/DF                                   BRASILIENSE/DF  2  Col.  1
       5    0  PALMEIRAS/SP                              SAO CAETANO/SP  0  Col. Meio
       6    3  VILA NOVA/GO                                ITUMBIARA/GO  2  Col.  1
       7    1  BRAGANTINO/SP                                 GUARANI/SP  0  Col.  1
       8    0  XV PIRACICABA/SP                            SAO PAULO/SP  1  Col.  2
       9    2  SANTA CRUZ/PE                           SERRA TALHADA/PE  0  Col.  1
       10   1  FERROVIARIO/CE                              HORIZONTE/CE  4  Col.  2
       11   0  OLARIA/RJ                               VASCO DA GAMA/RJ  2  Col.  2
       12   1  DUQUE DE CAXIAS/RJ                           FLAMENGO/RJ  2  Col.  2
       13   0  CRICIUMA/SC                                      AVAI/SC  2  Col.  2
       14   1  AMERICA/MG                                   ATLETICO/MG  2  Col.  2
   Concurso 500 (05/03/2012)
   Acumulado em R$ 300.000,00 para 12/03/2012
   Acumulado para a 1a faixa 0,00
   Acumulado para o proximo concurso de final cinco (505): R$ 91.107,15
     Faixa       Qtde.          Prêmio
     14           93            9.644,55 
     13           2.969         43,83   

$

$ zzloteria2 timemania 600
timemania:
   13 - 19 - 27 - 29 - 42 - 44 - 57 
   Time: YPIRANGA/AP
   Concurso 600 (15/07/2014)
   Acumulado em R$ 4.200.000,00 para 17/07/2014
     Faixa       Qtde.          Prêmio
     7 ptos      0              0,00
     6 ptos      12             8.895,15
     5 ptos      288            529,47
     4 ptos      4886           6,00
     3 ptos      42593          2,00

$

$ zzloteria2 federal 2500
federal:
   1o Prêmio	66.069	200.000,00
   2o Prêmio	77.589	8.000,00
   3o Prêmio	60.325	5.000,00
   4o Prêmio	03.547	4.000,00
   5o Prêmio	48.642	2.000,00
   Concurso 02500 (11/01/1989)

$

$ zzloteria2 duplasena 1000
duplasena:
   07 - 09 - 18 - 42 - 45 - 46 
   03 - 13 - 31 - 32 - 36 - 39 
   Concurso 1000 (06/09/2011)
   Acumulado em R$ 1.950.000,00 para 09/09/2011
     Faixa       Qtde.          Prêmio
     1a Sena     0              0,00
     1a Quina    55             2.224,60
     1a Quadra   2368           49,20
                 
     2a Sena     1              163.137,83
     2a Quina    77             1.589,00
     2a Quadra   2560           45,51

$

$ zzloteria2 quina 3000
quina:
   02 - 21 - 31 - 37 - 57
   Concurso 3000 (20/09/2012)
   Acumulado em R$ 944.644,57
     Faixa       Qtde.          Prêmio
     Quina       0              0,00
     Quadra      54             6.681,90
     Terno       4528           113,83

$

$ zzloteria2 megasena 1111
megasena:
   04 - 09 - 25 - 32 - 33 - 43
   Concurso 1111 (23/09/2009)
   Acumulado em R$ 0,00
     Faixa       Qtde.          Prêmio
     Sena        1              2.100.928,15
     Quina       52             21.932,77
     Quadra      5266           309,39

$

$ zzloteria2 lotomania 750
lotomania:
   04 - 07 - 19 - 22 - 24 - 30 - 38 - 41 - 45 - 53
   57 - 66 - 68 - 72 - 75 - 77 - 80 - 83 - 92 - 94
   Concurso 750 (18/08/2007)
   Acumulado em R$ 350.000,00
     Faixa       Qtde.          Prêmio
     20 ptos     5              1.364.031,89
     19 ptos     66             7.504,25
     18 ptos     595            832,40
     17 ptos     4489           54,96
     16 ptos     21493          11,48
      0 ptos     3              82.546,71

$

$ zzloteria2 lotofacil 1099
lotofacil:
   02 - 03 - 06 - 07 - 08
   11 - 12 - 13 - 14 - 16
   21 - 22 - 23 - 24 - 25
   Concurso 1099 (25/08/2014)
   Acumulado em R$ 1.849.509,79
     Faixa       Qtde.          Prêmio
     15 ptos     0              0,00
     14 ptos     445            1.278,83
     13 ptos     13926          15,00
     12 ptos     204099         6,00
     11 ptos     1108572        3,00

$

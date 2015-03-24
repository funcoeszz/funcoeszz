$ zzloteria2 quina | sed '2{s/[0-9][0-9]/99/g};3{s/[0-9]\{1,\}/NUM/};s|[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]|DATA|;4,${s/ [0-9.]\{1,\} \{1,\}/ QTDE           /;s/ [0-9.,]\{1,\}/ VALOR/}'
quina:
   99 - 99 - 99 - 99 - 99 
   Concurso NUM (DATA)
   Acumulado em R$ VALOR para DATA
     Faixa       Qtde.          Prêmio
     Quina       QTDE           VALOR
     Quadra      QTDE           VALOR
     Terno       QTDE           VALOR

$
$ zzloteria2 megasena | sed '2{s/[0-9][0-9]/99/g};3{s/[0-9]\{1,\}/NUM/};s|[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]|DATA|;4,${s/ [0-9.]\{1,\} \{1,\}/ QTDE           /;s/ [0-9.,]\{1,\}/ VALOR/}'
megasena:
   99 - 99 - 99 - 99 - 99 - 99 
   Concurso NUM (DATA)
   Acumulado em R$ VALOR para DATA
     Faixa       Qtde.          Prêmio
     Sena        QTDE           VALOR
     Quina       QTDE           VALOR
     Quadra      QTDE           VALOR

$

$ zzloteria2 duplasena | sed '2,3{s/[0-9][0-9]/99/g};4{s/[0-9]\{1,\}/NUM/};s|[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]|DATA|;5,${s/[123]ª/Pª/;s/ [0-9.]\{1,\} \{1,\}/ QTDE           /;s/ [0-9.,]\{1,\}/ VALOR/}'
duplasena:
   99 - 99 - 99 - 99 - 99 - 99 
   99 - 99 - 99 - 99 - 99 - 99 
   Concurso NUM (DATA)
   Acumulado em R$ VALOR para DATA
     Faixa       Qtde.          Prêmio
     Pª Sena    QTDE           VALOR
     Pª Quina   QTDE           VALOR
     Pª Quadra  QTDE           VALOR
                 
     Pª Sena    QTDE           VALOR
     Pª Quina   QTDE           VALOR
     Pª Quadra  QTDE           VALOR

$

$ zzloteria2 lotomania | sed '2,3{s/[0-9][0-9]/99/g};4{s/[0-9]\{1,\}/NUM/};s|[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]|DATA|;5,${s/[ 12][09876] ptos/XX ptos/;s/ [0-9.]\{1,\} \{1,\}/ QTDE           /;s/ [0-9.,]\{1,\}/ VALOR/}'
lotomania:
   99 - 99 - 99 - 99 - 99 - 99 - 99 - 99 - 99 - 99
   99 - 99 - 99 - 99 - 99 - 99 - 99 - 99 - 99 - 99
   Concurso NUM (DATA)
   Acumulado em R$ VALOR
     Faixa       Qtde.          Prêmio
     XX ptos     QTDE           VALOR
     XX ptos     QTDE           VALOR
     XX ptos     QTDE           VALOR
     XX ptos     QTDE           VALOR
     XX ptos     QTDE           VALOR
     XX ptos     QTDE           VALOR

$

$ zzloteria2 lotofacil | sed '2,4{s/[0-9][0-9]/99/g};5{s/[0-9]\{1,\}/NUM/};s|[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]|DATA|;6,${s/1[1-5] ptos/XX ptos/;s/ [0-9.]\{1,\} \{1,\}/ QTDE           /;s/ [0-9.,]\{1,\}/ VALOR/}'
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

$ zzloteria2 federal| sed '7{s/[0-9]\{1,\}/NUM/};s|[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]|DATA|;2,6{s/[1-5]º/Pº/;s/[0-9.]\{1,\}/NUMERO/;s/[0-9.,]\{1,\}/VALOR/}'
federal:
   Pº Prêmio	NUMERO	VALOR
   Pº Prêmio	NUMERO	VALOR
   Pº Prêmio	NUMERO	VALOR
   Pº Prêmio	NUMERO	VALOR
   Pº Prêmio	NUMERO	VALOR
   Concurso NUM (DATA)

$

$ zzloteria2 timemania | sed '2{s/[0-9][0-9]/99/g};3s/^ *Time:.*/TIME/;4{s/[0-9]\{1,\}/NUM/};s|[0-9]\{1,2\}/[0-9]\{1,2\}/[0-9][0-9][0-9][0-9]|DATA|;5,${s/[3-7] ptos/X ptos/;s/ [0-9.]\{1,\} \{1,\}/ QTDE           /;s/ [0-9.,]\{1,\}/ VALOR/}'
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

$ zzloteria2 loteca | sed 's|[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]|DATA|;s/ cinco / NUM /;s/ zero / NUM /;s/[0-9.]\{1,\},[0-9]\{2\}/VALOR/;s/1ª/Pª/;3,20{s/[0-9]/N/g;s/Meio/ N/};22,23{s/1[432]   /FAIXA/;s/ [.0-9]\{1,6\} */QTDE           /};3,16s/\(.\{15\}\)\(.\{57\}\)/\1TIME1                                              TIME2 /'
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
   Acumulado para a Pª faixa VALOR
   Acumulado para o proximo concurso de final NUM (NNN): R$ VALOR
     Faixa       Qtde.          Prêmio
     FAIXA       QTDE           VALOR 
     FAIXA       QTDE           VALOR   

$

$ limpa='s/[0-9]/9/g;s/\(99*\.\)*99*,99/DINHEIRO/'
$ zzloteria duplasena | sed "$limpa"
duplasena:
   99 - 99 - 99 - 99 - 99 - 99
   99 - 99 - 99 - 99 - 99 - 99
   Concurso 9999 (99/99/9999)
   Acumulado em R$ DINHEIRO para 99/99/9999
$ zzloteria lotofacil | sed "$limpa"
lotofacil:
   99 - 99 - 99 - 99 - 99
   99 - 99 - 99 - 99 - 99
   99 - 99 - 99 - 99 - 99
   Concurso 999 (99/99/9999)
   Acumulado em R$ DINHEIRO para 99/99/9999
$ zzloteria lotomania | sed "$limpa"
lotomania:
   99 - 99 - 99 - 99 - 99 - 99 - 99 - 99 - 99 - 99
   99 - 99 - 99 - 99 - 99 - 99 - 99 - 99 - 99 - 99
   Concurso 9999 (99/99/9999)
   Acumulado em R$ DINHEIRO para 99/99/9999
$ zzloteria megasena | sed "$limpa"
megasena:
   99 - 99 - 99 - 99 - 99 - 99
   Concurso 9999 (99/99/9999)
   Acumulado em R$ DINHEIRO para 99/99/9999
$ zzloteria quina | sed "$limpa"
quina:
   99 - 99 - 99 - 99 - 99
   Concurso 9999 (99/99/9999)
   Acumulado em R$ DINHEIRO para 99/99/9999
$ zzloteria foo
$

$ cut -f 1 zzunicode2ascii.in.txt > _tmp1
$ cut -f 2 zzunicode2ascii.in.txt > _tmp2
$ zzunicode2ascii _tmp1   #→ --file _tmp2
$ rm -f _tmp[12]
$

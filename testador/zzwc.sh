# Preparando arquivo de nome incomun
$ cat zzwc.in.txt > "-_tmp1"
$

$ zzwc -l zzwc.in.txt	#=> 15
$ zzwc -c zzwc.in.txt	#=> 115
$ zzwc -m zzwc.in.txt	#=> 76
$ zzwc -w zzwc.in.txt	#=> 19
$ zzwc -C zzwc.in.txt	#=> 12
$ zzwc -L zzwc.in.txt	#=> 7
$ zzwc -W zzwc.in.txt	#=> 3
$ zzwc -L -p zzwc.in.txt	#=> k l mno
$ zzwc -W -p zzwc.in.txt	#=> k l mno
$ zzwc -C -p zzwc.in.txt
9 €®ŧ←
↓→øþæ
ł»©“”
$

$ zzwc -l -- -_tmp1	#=> 15
$ zzwc -c -- -_tmp1	#=> 115
$ zzwc -m -- -_tmp1	#=> 76
$ zzwc -w -- -_tmp1	#=> 19
$ zzwc -C -- -_tmp1	#=> 12
$ zzwc -L -- -_tmp1	#=> 7
$ zzwc -W -- -_tmp1	#=> 3
$ zzwc -L -p -- -_tmp1	#=> k l mno
$ zzwc -W -p -- -_tmp1	#=> k l mno
$ zzwc -C -p -- -_tmp1
9 €®ŧ←
↓→øþæ
ł»©“”
$

$ zzwc -l zzunescape.in.txt	#=> 253
$ zzwc -c zzunescape.in.txt	#=> 6398
$ zzwc -m zzunescape.in.txt	#=> 6057
$ zzwc -C zzunescape.in.txt	#=> 30
$ zzwc -L zzunescape.in.txt	#=> 28
$ zzwc -C -p zzunescape.in.txt
ℵ	&#8501;	&#x2135;	&alefsym;
$

# Limpeza
$ rm -f ./-_tmp1
$

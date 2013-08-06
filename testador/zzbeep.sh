$ printf '\033[10;750]\033[11;100]\a' > _tmp1
$ printf 'Vou bipar em 0 minutos... ' > _tmp2
$ printf '\033[11;900]'              >> _tmp2
$ printf '\033[10;500]\a'            >> _tmp2
$ printf '\033[10;400]\a'            >> _tmp2
$ printf '\033[10;500]\a'            >> _tmp2
$ printf '\033[10;400]\a'            >> _tmp2
$ printf '\033[10;750]\033[11;100]'  >> _tmp2
$ printf 'OK\n'                      >> _tmp2
$

$ zzbeep                             #→ --file _tmp1
$ zzbeep 0                           #→ --file _tmp2

# faxina
$ rm -f _tmp[12]
$

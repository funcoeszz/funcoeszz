$ zzfilme                                       #→ --regex ^Uso:
$ zzfilme matrix | sed -n '1p'                  #→ Matrix:
$ zzfilme 'matrix revolutions' | sed -n '1p'    #→ Matrix Revolutions:
$ zzfilme 'Funções ZZ' > /dev/null; echo $?     #→ 1

$ zzaleatorio                           #→ --regex ^\d+$
$ zzaleatorio 9                         #→ --regex ^\d$
$ zzaleatorio 2300 2359                 #→ --regex ^23[0-5][0-9]$

# Detectando erro
$ zzaleatorio texto; echo $?            #→ 1

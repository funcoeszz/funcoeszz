$ zzaleatorio                           #=> --regex ^\d+$
$ zzaleatorio 9                         #=> --regex ^\d$
$ zzaleatorio 2300 2359                 #=> --regex ^23[0-5][0-9]$

# Os números devem mudar a cada execução
$ zzaleatorio > _tmp1
$ zzaleatorio > _tmp2
$ zzaleatorio > _tmp3
$ diff -q _tmp1 _tmp2 > /dev/null; echo $?	#=> 1
$ diff -q _tmp1 _tmp3 > /dev/null; echo $?	#=> 1
$ diff -q _tmp2 _tmp3 > /dev/null; echo $?	#=> 1
$ rm -f _tmp[123]
$

# Detectando erro
$ zzaleatorio texto; echo $?            #=> 1

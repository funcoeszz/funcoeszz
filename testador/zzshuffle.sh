# Preparação
$ seq 5 > _tmp1
$
$ zzshuffle _tmp1 > _tmp2
$
$ zzshuffle _tmp1 > _tmp3
$

$ diff -q _tmp1 _tmp2 > /dev/null; echo $?	#→ 1
$ diff -q _tmp1 _tmp3 > /dev/null; echo $?	#→ 1
$ diff -q _tmp2 _tmp3 > /dev/null; echo $?	#→ 1

# Limpeza
$ rm -f _tmp[123]
$

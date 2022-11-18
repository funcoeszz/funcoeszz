# Preparação

$ seq 20 > _tmp1
$ zzshuffle _tmp1 > _tmp2
$ zzshuffle _tmp1 > _tmp3
$

# Confere que os arquivos misturados são diferentes do original

$ diff -q _tmp1 _tmp2 > /dev/null; echo $?	#=> 1
$ diff -q _tmp1 _tmp3 > /dev/null; echo $?	#=> 1
$

# Confere que os arquivos misturados são diferentes entre si, ou seja,
# cada misturada deve produzir um resultado diferente

$ diff -q _tmp2 _tmp3 > /dev/null; echo $?	#=> 1
$

# Limpeza

$ rm -f _tmp[123]
$

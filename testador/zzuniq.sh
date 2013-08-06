$ cat _dados.txt
1:um:one
2:dois:two
3:tres:three
4:quatro:four
5:cinco:five
$

# Nada a remover

$ zzuniq _dados.txt	#→ --file _dados.txt

# Cada linha aparece 3x

$ cat _dados.txt _dados.txt _dados.txt > _tmp1
$ zzuniq _tmp1		#→ --file _dados.txt

# Faxina

$ rm -f _tmp1
$

$ cat _dados.txt _numeros.txt > _tmp1
$ zzsplit 2 _tmp1
$ cat _tmp1.1
1:um:one
3:tres:three
5:cinco:five
2
4
$

$ cat _tmp1.2
2:dois:two
4:quatro:four
1
3
5
$

$ rm -f _tmp1 _tmp1.1 _tmp1.2

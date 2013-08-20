$ cat _vazio.txt
$ cat _dados.txt
1:um:one
2:dois:two
3:tres:three
4:quatro:four
5:cinco:five
$

$ zzmd5 _vazio.txt _dados.txt
d41d8cd98f00b204e9800998ecf8427e	_vazio.txt
a48adf5366ffc7e0a6eb60447502c18e	_dados.txt
$

$ echo abcdef | zzmd5 | sed -n l
5ab557c937e38f15291c04b7e99544ad$
$

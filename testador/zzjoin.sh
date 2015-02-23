# Arquivos temporários para uso
$ head -n 3 _dados.txt > _tmp1; tail -n 4 _numeros.txt > _tmp2
$

$ zzjoin _tmp1 _tmp2
1:um:one	2
2:dois:two	3
3:tres:three	4
$

$ zzjoin _tmp2 _tmp1
2	1:um:one
3	2:dois:two
4	3:tres:three
5
$

$ zzjoin -m _tmp2 _tmp1
2	1:um:one
3	2:dois:two
4	3:tres:three
$

$ zzjoin -M _tmp1 _tmp2
1:um:one	2
2:dois:two	3
3:tres:three	4
	5
$

$ zzjoin -d "<>"  _tmp1 _tmp2
1:um:one<>2
2:dois:two<>3
3:tres:three<>4
$

# Apagando os temporários
$ rm -f _tmp1 _tmp2

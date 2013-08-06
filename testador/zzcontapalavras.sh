$ echo "um! dois, dois? três; quatro: três.TrÊs quatro - quatro QUATRO." > _tmp1
$

# Normal

$ zzcontapalavras _tmp1
3	quatro
2	três
2	dois
1	um
1	TrÊs
1	QUATRO
$ zzcontapalavras -n 3 _tmp1
3	quatro
2	três
2	dois
$

# -i

$ zzcontapalavras -i _tmp1
4	quatro
3	três
2	dois
1	um
$ zzcontapalavras -i -n 2 _tmp1
4	quatro
3	três
$

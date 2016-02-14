# Preparativos
$ sed 's/:/♦/g' _dados.txt > _tmp1
$

$ zzcut		-c7,3	_dados.txt
nu
:d
:t
rq
oc
$ zzcut	-v	-c7,3	_dados.txt
1:m:oe
2:oistwo
3:resthree
4:uato:four
5:inc:five
$ zzcut	-d:	-f1,3	_dados.txt
1:one
2:two
3:three
4:four
5:five
$ zzcut	-v	-d:	-f1,3	_dados.txt
um
dois
tres
quatro
cinco
$ zzcut		-c-5	_tmp1
1♦um♦
2♦doi
3♦tre
4♦qua
5♦cin
$ zzcut	-c	7-	_tmp1
ne
♦two
♦three
ro♦four
o♦five
$ zzcut	-v	-c	-5	_tmp1
one
s♦two
s♦three
tro♦four
co♦five
$ zzcut	-d	♦	-f1,3	_tmp1
1♦one
2♦two
3♦three
4♦four
5♦five
$ zzcut	-v	-d♦	-f	1,3	_tmp1
um
dois
tres
quatro
cinco
$

# Faxina
$ rm -f _tmp1
$

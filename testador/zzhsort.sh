$ cat _dados.txt | zzhsort -d ":"
1:one:um
2:dois:two
3:three:tres
4:four:quatro
5:cinco:five
$

$ cat _dados.txt | zzhsort -r -d ":" --ofs _
um_one_1
two_dois_2
tres_three_3
quatro_four_4
five_cinco_5
$

$ zzhsort --ofs "-" "1 a z x 5 o"				#→ 1-5-a-o-x-z
$ zzhsort -r -d ":" --ofs "\t" "1:a:z:x:5:o"	#→ z	x	o	a	5	1
$ zzhsort -r --ofs "-" "1 a z x 5 o"			#→ z-x-o-a-5-1
$ zzhsort "isso está desordenado"				#→ desordenado está isto

$ cat _dados.txt | zzhsort -d ":"
one:um:1
dois:two:2
three:tres:3
four:quatro:4
cinco:five:5
$

$ cat _dados.txt | zzhsort -r -d ":" -D _
1_um_one
2_two_dois
3_tres_three
4_quatro_four
5_five_cinco
$

$ zzhsort -D "-" "1 a z x 5 o"				#=> a-o-x-z-1-5
$ zzhsort -r -d ":" -D "\t" "1:a:z:x:5:o"	#=> 5	1	z	x	o	a
$ zzhsort -r -D "-" "1 a z x 5 o"			#=> 5-1-z-x-o-a
$ zzhsort "isso está desordenado"				#=> desordenado está isso

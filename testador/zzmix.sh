$ zzmix _dados.txt _numeros.txt
1:um:one
1
2:dois:two
2
3:tres:three
3
4:quatro:four
4
5:cinco:five
5
$

$ zzmix -p 2 _dados.txt _numeros.txt
1:um:one
2:dois:two
1
2
3:tres:three
4:quatro:four
3
4
5:cinco:five
5
$

$ zzmix -p 2,1 _dados.txt _numeros.txt
1:um:one
2:dois:two
1
3:tres:three
4:quatro:four
2
5:cinco:five
3
$

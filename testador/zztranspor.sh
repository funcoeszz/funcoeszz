$ zztranspor -d ":" _dados.txt
1:2:3:4:5
um:dois:tres:quatro:cinco
one:two:three:four:five
$

$ paste _dados.txt _numeros.txt | zztranspor
1:um:one 2:dois:two 3:tres:three 4:quatro:four 5:cinco:five
1 2 3 4 5
$

$ zztranspor _numeros.txt
1 2 3 4 5
$

$ zztabuada 3 | zztranspor --ofs '\t'
3	3	3	3	3	3	3	3	3	3	3
x	x	x	x	x	x	x	x	x	x	x
0	1	2	3	4	5	6	7	8	9	10
=	=	=	=	=	=	=	=	=	=	=
0	3	6	9	12	15	18	21	24	27	30
$

$ zztabuada 7 | zztranspor -d ' x ' --ofs '\t'
7	7	7	7	7	7	7	7	7	7	7
0  = 0	1  = 7	2  = 14	3  = 21	4  = 28	5  = 35	6  = 42	7  = 49	8  = 56	9  = 63	10 = 70
$

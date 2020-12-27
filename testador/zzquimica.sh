$ zzquimica                             #=> --lines 119
$ zzquimica | head
N.º  Nome          Símbolo Massa        Orbital            Classificação (Estado)
1    Hidrogênio    H       1,00794      1                  Não Metal (Gasoso)
2    Hélio         He      4,002602     2                  Gás Nobre (Gasoso)
3    Lítio         Li      6,941        2-1                Alcalino (Sólido)
4    Berílio       Be      9,012182     2-2                Alcalino-Terroso (Sólido)
5    Boro          B       10,811       2-3                Semi-Metal [Família do Boro] (Sólido)
6    Carbono       C       12,0107      2-4                Não Metal [Família do Carbono] (Sólido)
7    Nitrogênio    N       14,0067      2-5                Não Metal [Família do Nitrogênio] (Gasoso)
8    Oxigênio      O       15,9994      2-6                Não Metal [Calcogênio] (Gasoso)
9    Flúor         F       18,9984032   2-7                Halogênio (Gasoso)
$ zzquimica | grep Família
5    Boro          B       10,811       2-3                Semi-Metal [Família do Boro] (Sólido)
6    Carbono       C       12,0107      2-4                Não Metal [Família do Carbono] (Sólido)
7    Nitrogênio    N       14,0067      2-5                Não Metal [Família do Nitrogênio] (Gasoso)
13   Alumínio      Al      26,9815386   2-8-3              Metal Representativo [Família do Boro] (Sólido)
14   Silício       Si      28,0855      2-8-4              Semi-Metal [Família do Carbono] (Sólido)
15   Fósforo       P       30,973762    2-8-5              Não Metal [Família do Nitrogênio] (Sólido)
31   Gálio         Ga      69,723       2-8-18-3           Metal Representativo [Família do Boro] (Sólido)
32   Germânio      Ge      72,63        2-8-18-4           Semi-Metal [Família do Carbono] (Sólido)
33   Arsênio       As      74,9216      2-8-18-5           Semi-Metal [Família do Nitrogênio] (Sólido)
49   Índio         In      114,818      2-8-18-18-3        Metal Representativo [Família do Boro] (Sólido)
50   Estanho       Sn      118,71       2-8-18-18-4        Metal Representativo [Família do Carbono] (Sólido)
51   Antimônio     Sb      121,76       2-8-18-18-5        Semi-Metal [Família do Nitrogênio] (Sólido)
81   Tálio         Tl      204,3833     2-8-18-32-18-3     Metal Representativo [Família do Boro] (Sólido)
82   Chumbo        Pb      207,2        2-8-18-32-18-4     Metal Representativo [Família do Carbono] (Sólido)
83   Bismuto       Bi      208,9804     2-8-18-32-18-5     Metal Representativo [Família do Nitrogênio] (Sólido)
113  Nihonium      Nh      (284)        2-8-18-32-32-18-3  Metal Representativo [Família do Boro] (Desconhecido)
114  Fleróvio      Fl      (289)        2-8-18-32-32-18-4  Metal Representativo [Família do Carbono] (Desconhecido)
115  Moscovium     Mc      (288)        2-8-18-32-32-18-5  Metal Representativo [Família do Nitrogênio] (Desconhecido)
$ zzquimica | sed 's/^\(.\{26\}\).*/\1/' | sed 's/$/~/'
N.º  Nome          Símbolo~
1    Hidrogênio    H      ~
2    Hélio         He     ~
3    Lítio         Li     ~
4    Berílio       Be     ~
5    Boro          B      ~
6    Carbono       C      ~
7    Nitrogênio    N      ~
8    Oxigênio      O      ~
9    Flúor         F      ~
10   Neônio        Ne     ~
11   Sódio         Na     ~
12   Magnésio      Mg     ~
13   Alumínio      Al     ~
14   Silício       Si     ~
15   Fósforo       P      ~
16   Enxofre       S      ~
17   Cloro         Cl     ~
18   Argônio       Ar     ~
19   Potássio      K      ~
20   Cálcio        Ca     ~
21   Escândio      Sc     ~
22   Titânio       Ti     ~
23   Vanádio       V      ~
24   Cromo         Cr     ~
25   Manganês      Mn     ~
26   Ferro         Fe     ~
27   Cobalto       Co     ~
28   Níquel        Ni     ~
29   Cobre         Cu     ~
30   Zinco         Zn     ~
31   Gálio         Ga     ~
32   Germânio      Ge     ~
33   Arsênio       As     ~
34   Selênio       Se     ~
35   Bromo         Br     ~
36   Cripitônio    Kr     ~
37   Rubídio       Rb     ~
38   Estrôncio     Sr     ~
39   Ítrio         Y      ~
40   Zircônio      Zr     ~
41   Nióbio        Nb     ~
42   Molibdênio    Mo     ~
43   Tecnécio      Tc     ~
44   Rutênio       Ru     ~
45   Ródio         Rh     ~
46   Paládio       Pd     ~
47   Prata         Ag     ~
48   Cádmio        Cd     ~
49   Índio         In     ~
50   Estanho       Sn     ~
51   Antimônio     Sb     ~
52   Telúrio       Te     ~
53   Iodo          I      ~
54   Xenônio       Xe     ~
55   Césio         Cs     ~
56   Bário         Ba     ~
57   Lantânio      La     ~
58   Cério         Ce     ~
59   Praseodímio   Pr     ~
60   Neodímio      Nd     ~
61   Promécio      Pm     ~
62   Samário       Sm     ~
63   Európio       Eu     ~
64   Gadolínio     Gd     ~
65   Térbio        Tb     ~
66   Disprósio     Dy     ~
67   Hólmio        Ho     ~
68   Érbio         Er     ~
69   Túlio         Tm     ~
70   Itérbio       Yb     ~
71   Lutécio       Lu     ~
72   Háfnio        Hf     ~
73   Tântalo       Ta     ~
74   Tungstênio    W      ~
75   Rênio         Re     ~
76   Ósmio         Os     ~
77   Irídio        Ir     ~
78   Platina       Pt     ~
79   Ouro          Au     ~
80   Mercúrio      Hg     ~
81   Tálio         Tl     ~
82   Chumbo        Pb     ~
83   Bismuto       Bi     ~
84   Polônio       Po     ~
85   Astato        At     ~
86   Radônio       Rn     ~
87   Frâncio       Fr     ~
88   Rádio         Ra     ~
89   Actínio       Ac     ~
90   Tório         Th     ~
91   Protactínio   Pa     ~
92   Urânio        U      ~
93   Neptúnio      Np     ~
94   Plutônio      Pu     ~
95   Amerício      Am     ~
96   Cúrio         Cm     ~
97   Berquélio     Bk     ~
98   Califórnio    Cf     ~
99   Einstênio     Es     ~
100  Férmio        Fm     ~
101  Mendelévio    Md     ~
102  Nobélio       No     ~
103  Laurêncio     Lr     ~
104  Rutherfórdio  Rf     ~
105  Dúbnio        Db     ~
106  Seabórgio     Sg     ~
107  Bóhrio        Bh     ~
108  Hássio        Hs     ~
109  Meitnério     Mt     ~
110  Darmstádio    Ds     ~
111  Roentgênio    Rg     ~
112  Copernício    Cn     ~
113  Nihonium      Nh     ~
114  Fleróvio      Fl     ~
115  Moscovium     Mc     ~
116  Livermório    Lv     ~
117  Tennessine    Ts     ~
118  Oganesson     Og     ~
$

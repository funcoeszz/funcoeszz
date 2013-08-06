# Erro

$ zzromanos	foo		#→ --regex ^Uso:
$ zzromanos	-1		#→ --regex ^Uso:
$ zzromanos	+1		#→ --regex ^Uso:
$ zzromanos	1.0		#→ --regex ^Uso:
$ zzromanos	1,0		#→ --regex ^Uso:
$ zzromanos	0		#→ 

# Sem argumentos, mostra a lista de números

$ zzromanos
1	I
5	V
10	X
50	L
100	C
500	D
1000	M
$

### 5   ->   V
# Para gerar esta lista de testes:
# cat zzromanos.in.txt | sed 's/:/@#→ /g; s/^/$ zzromanos@/' | tr @ '\t'
$ zzromanos	1	#→ I
$ zzromanos	2	#→ II
$ zzromanos	3	#→ III
$ zzromanos	4	#→ IV
$ zzromanos	5	#→ V
$ zzromanos	6	#→ VI
$ zzromanos	7	#→ VII
$ zzromanos	8	#→ VIII
$ zzromanos	9	#→ IX
$ zzromanos	10	#→ X
$ zzromanos	11	#→ XI
$ zzromanos	12	#→ XII
$ zzromanos	13	#→ XIII
$ zzromanos	14	#→ XIV
$ zzromanos	15	#→ XV
$ zzromanos	16	#→ XVI
$ zzromanos	17	#→ XVII
$ zzromanos	18	#→ XVIII
$ zzromanos	19	#→ XIX
$ zzromanos	20	#→ XX
$ zzromanos	25	#→ XXV
$ zzromanos	30	#→ XXX
$ zzromanos	35	#→ XXXV
$ zzromanos	40	#→ XL
$ zzromanos	45	#→ XLV
$ zzromanos	50	#→ L
$ zzromanos	60	#→ LX
$ zzromanos	70	#→ LXX
$ zzromanos	80	#→ LXXX
$ zzromanos	90	#→ XC
$ zzromanos	99	#→ XCIX
$ zzromanos	100	#→ C
$ zzromanos	101	#→ CI
$ zzromanos	111	#→ CXI
$ zzromanos	199	#→ CXCIX
$ zzromanos	200	#→ CC
$ zzromanos	300	#→ CCC
$ zzromanos	400	#→ CD
$ zzromanos	500	#→ D
$ zzromanos	600	#→ DC
$ zzromanos	700	#→ DCC
$ zzromanos	800	#→ DCCC
$ zzromanos	900	#→ CM
$ zzromanos	990	#→ CMXC
$ zzromanos	999	#→ CMXCIX
$ zzromanos	1000	#→ M
$ zzromanos	1100	#→ MC
$ zzromanos	1110	#→ MCX
$ zzromanos	1111	#→ MCXI
$ zzromanos	2000	#→ MM
$ zzromanos	3000	#→ MMM
$ zzromanos	3999	#→ MMMCMXCIX


### V   ->   5
# Para gerar esta lista de testes:
# cat zzromanos.in.txt | sed 's/\([0-9]*\):\([A-Z]*\)/\2:\1/g' | sed 's/:/@@#→ /g; s/^/$ zzromanos@/' | tr @ '\t'
$ zzromanos	I		#→ 1
$ zzromanos	II		#→ 2
$ zzromanos	III		#→ 3
$ zzromanos	IV		#→ 4
$ zzromanos	V		#→ 5
$ zzromanos	VI		#→ 6
$ zzromanos	VII		#→ 7
$ zzromanos	VIII		#→ 8
$ zzromanos	IX		#→ 9
$ zzromanos	X		#→ 10
$ zzromanos	XI		#→ 11
$ zzromanos	XII		#→ 12
$ zzromanos	XIII		#→ 13
$ zzromanos	XIV		#→ 14
$ zzromanos	XV		#→ 15
$ zzromanos	XVI		#→ 16
$ zzromanos	XVII		#→ 17
$ zzromanos	XVIII		#→ 18
$ zzromanos	XIX		#→ 19
$ zzromanos	XX		#→ 20
$ zzromanos	XXV		#→ 25
$ zzromanos	XXX		#→ 30
$ zzromanos	XXXV		#→ 35
$ zzromanos	XL		#→ 40
$ zzromanos	XLV		#→ 45
$ zzromanos	L		#→ 50
$ zzromanos	LX		#→ 60
$ zzromanos	LXX		#→ 70
$ zzromanos	LXXX		#→ 80
$ zzromanos	XC		#→ 90
$ zzromanos	XCIX		#→ 99
$ zzromanos	C		#→ 100
$ zzromanos	CI		#→ 101
$ zzromanos	CXI		#→ 111
$ zzromanos	CXCIX		#→ 199
$ zzromanos	CC		#→ 200
$ zzromanos	CCC		#→ 300
$ zzromanos	CD		#→ 400
$ zzromanos	D		#→ 500
$ zzromanos	DC		#→ 600
$ zzromanos	DCC		#→ 700
$ zzromanos	DCCC		#→ 800
$ zzromanos	CM		#→ 900
$ zzromanos	CMXC		#→ 990
$ zzromanos	CMXCIX		#→ 999
$ zzromanos	M		#→ 1000
$ zzromanos	MC		#→ 1100
$ zzromanos	MCX		#→ 1110
$ zzromanos	MCXI		#→ 1111
$ zzromanos	MM		#→ 2000
$ zzromanos	MMM		#→ 3000
$ zzromanos	MMMCMXCIX	#→ 3999

### v   ->   5
# Para gerar esta lista de testes:
# $ cat zzromanos.in.txt | tr IVXLCDM ivxlcdm | sed 's/\([0-9]*\):\([a-z]*\)/\2:\1/g' | sed 's/:/@@#→ /g; s/^/$ zzromanos@/' | tr @ '\t'
$ zzromanos	i		#→ 1
$ zzromanos	ii		#→ 2
$ zzromanos	iii		#→ 3
$ zzromanos	iv		#→ 4
$ zzromanos	v		#→ 5
$ zzromanos	vi		#→ 6
$ zzromanos	vii		#→ 7
$ zzromanos	viii		#→ 8
$ zzromanos	ix		#→ 9
$ zzromanos	x		#→ 10
$ zzromanos	xi		#→ 11
$ zzromanos	xii		#→ 12
$ zzromanos	xiii		#→ 13
$ zzromanos	xiv		#→ 14
$ zzromanos	xv		#→ 15
$ zzromanos	xvi		#→ 16
$ zzromanos	xvii		#→ 17
$ zzromanos	xviii		#→ 18
$ zzromanos	xix		#→ 19
$ zzromanos	xx		#→ 20
$ zzromanos	xxv		#→ 25
$ zzromanos	xxx		#→ 30
$ zzromanos	xxxv		#→ 35
$ zzromanos	xl		#→ 40
$ zzromanos	xlv		#→ 45
$ zzromanos	l		#→ 50
$ zzromanos	lx		#→ 60
$ zzromanos	lxx		#→ 70
$ zzromanos	lxxx		#→ 80
$ zzromanos	xc		#→ 90
$ zzromanos	xcix		#→ 99
$ zzromanos	c		#→ 100
$ zzromanos	ci		#→ 101
$ zzromanos	cxi		#→ 111
$ zzromanos	cxcix		#→ 199
$ zzromanos	cc		#→ 200
$ zzromanos	ccc		#→ 300
$ zzromanos	cd		#→ 400
$ zzromanos	d		#→ 500
$ zzromanos	dc		#→ 600
$ zzromanos	dcc		#→ 700
$ zzromanos	dccc		#→ 800
$ zzromanos	cm		#→ 900
$ zzromanos	cmxc		#→ 990
$ zzromanos	cmxcix		#→ 999
$ zzromanos	m		#→ 1000
$ zzromanos	mc		#→ 1100
$ zzromanos	mcx		#→ 1110
$ zzromanos	mcxi		#→ 1111
$ zzromanos	mm		#→ 2000
$ zzromanos	mmm		#→ 3000
$ zzromanos	mmmcmxcix	#→ 3999

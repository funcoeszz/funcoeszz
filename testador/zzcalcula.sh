# básico
$ zzcalcula	1	+	1		#→ 2
$ zzcalcula	1	-	1		#→ 0
$ zzcalcula	1	\*	1		#→ 1
$ zzcalcula	1	/	1		#→ 1,00

# scale
$ zzcalcula	1.0	+	1		#→ 2,0
$ zzcalcula	1,0	+	1		#→ 2,0
$ zzcalcula	1.10	+	1		#→ 2,10
$ zzcalcula	1,10	+	1		#→ 2,10
$ zzcalcula	10	/	3		#→ 3,33
$ zzcalcula	2,20	+	3.30		#→ 5,50

# tudo junto
$ zzcalcula	1+1				#→ 2
$ zzcalcula	1+	1			#→ 2
$ zzcalcula	1	+1			#→ 2
$ zzcalcula		1+1			#→ 2
$ zzcalcula			1+1		#→ 2

# números parciais
$ zzcalcula	.5	+	.5		#→ 1,0
$ zzcalcula	,5	+	,5		#→ 1,0
$ zzcalcula	1	+	.5		#→ 1,5

# separador de milhares na entrada e saída
$ zzcalcula	100*10				#→ 1.000
$ zzcalcula	100*10,00			#→ 1.000,00
$ zzcalcula	1000*1000			#→ 1.000.000
$ zzcalcula	1000*1000,00			#→ 1.000.000,00
$ zzcalcula	100^10				#→ 100.000.000.000.000.000.000
$ zzcalcula	1.000		+	1	#→ 1.001
$ zzcalcula	1.000,00	+	1	#→ 1.001,00
$ zzcalcula	1.000.000	+	1	#→ 1.000.001
$ zzcalcula	1.000.000,00	+	1	#→ 1.000.001,00

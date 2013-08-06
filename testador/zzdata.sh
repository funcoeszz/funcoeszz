$ now=$(date +%d/%m/%Y)
$

# Sem argumentos, mostra a data atual
$ zzdata						#→ --eval echo "$now"

# Apelidos: hoje, ontem, ...
$ zzdata	hoje					#→ --eval echo "$now"
$ zzdata	today					#→ --eval echo "$now"
$ zzdata	hoje		+	0		#→ --eval echo "$now"
$ zzdata	today		+	0		#→ --eval echo "$now"
$ zzdata	amanhã		-	1		#→ --eval echo "$now"
$ zzdata	amanha		-	1		#→ --eval echo "$now"
$ zzdata	tomorrow	-	1		#→ --eval echo "$now"
$ zzdata	ontem		+	1		#→ --eval echo "$now"
$ zzdata	yesterday	+	1		#→ --eval echo "$now"
$ zzdata	anteontem	+	2		#→ --eval echo "$now"
$ zzdata	hoje		+	0d		#→ --eval echo "$now"
$ zzdata	amanhã		-	1d		#→ --eval echo "$now"
$ zzdata	ontem		+	1d		#→ --eval echo "$now"
$ zzdata	anteontem	+	2d		#→ --eval echo "$now"

# Um delta sozinho é aplicado à data atual
$ zzdata	0d					#→ --eval echo "$now"
$ zzdata	0m					#→ --eval echo "$now"
$ zzdata	0a					#→ --eval echo "$now"

# Se há um delta, o outro valor deve ser uma data ou número
$ zzdata	1d		+	1m		#→ --regex ^Uso:
$ zzdata	1a		+	1m		#→ --regex ^Uso:
$ zzdata	1m		+	0a		#→ --regex ^Uso:

# Cálculo com zero 
$ zzdata	22/12/1999	+	0		#→ 22/12/1999
$ zzdata	22/12/1999	-	0		#→ 22/12/1999

# Cálculos estranhos
$ zzdata	0		+	0		#→ 01/01/1970
$ zzdata	1		-	1		#→ 01/01/1970
$ zzdata	1		+	0		#→ 02/01/1970
$ zzdata	0		+	1		#→ 02/01/1970
$ zzdata	0		-	1		#→ 31/12/1969

# Anos com 2, 3, 5 dígitos
$ zzdata	01/01/1		+	0		#→ 01/01/1
$ zzdata	01/01/10	+	0		#→ 01/01/10
$ zzdata	01/01/100	+	0		#→ 01/01/100
$ zzdata	01/01/1000	+	0		#→ 01/01/1000
$ zzdata	01/01/10000	+	0		#→ Data inválida '01/01/10000', deve ser dd/mm/aaaa

# Anos com zeros à esquerda (pode confundir com octal)
$ zzdata	01/01/0008	+	0		#→ 01/01/8
$ zzdata	01/01/008	+	0		#→ 01/01/8
$ zzdata	01/01/08	+	0		#→ 01/01/8
$ zzdata	01/01/08	+	1d		#→ 02/01/8
$ zzdata	01/01/08	+	1m		#→ 01/02/8
$ zzdata	01/01/08	+	1a		#→ 01/01/9

# Erros
$ zzdata	hoje		/	2		#→ Operação inválida '/'. Deve ser + ou -.
$ zzdata	hoje		1	2		#→ Operação inválida '1'. Deve ser + ou -.
#
$ zzdata	foo					#→ Data inválida 'foo', deve ser dd/mm/aaaa
$ zzdata	foo		+	1		#→ Data inválida 'foo', deve ser dd/mm/aaaa
$ zzdata	1		+	foo		#→ Data inválida 'foo', deve ser dd/mm/aaaa
$ zzdata	01/01/1970	+	foo		#→ Data inválida 'foo', deve ser dd/mm/aaaa
$ zzdata	1d		+	foo		#→ Data inválida 'foo', deve ser dd/mm/aaaa
#
$ zzdata	99/99/9999				#→ Data inválida '99/99/9999', deve ser dd/mm/aaaa
$ zzdata	99/99/9999	+	1		#→ Data inválida '99/99/9999', deve ser dd/mm/aaaa
$ zzdata	1		+	99/99/9999	#→ Data inválida '99/99/9999', deve ser dd/mm/aaaa
#
$ zzdata	77.0					#→ Número inválido '77.0'
$ zzdata	-77.0					#→ Número inválido '-77.0'
$ zzdata	77,0					#→ Número inválido '77,0'
$ zzdata	-77,0					#→ Número inválido '-77,0'
$ zzdata	01/01/1970	+	5x		#→ Número inválido '5x'
$ zzdata	5x		+	01/01/1970	#→ Número inválido '5x'
$ zzdata	01/01/1970	+	-5d		#→ Número inválido '-5d'
$ zzdata	-5d		+	01/01/1970	#→ Número inválido '-5d'
#
$ zzdata	01/01/1970	+	5.5d		#→ Delta inválido '5.5d'. Deve ser algo como 5d, 5m ou 5a.
$ zzdata	01/01/1970	+	5,5d		#→ Delta inválido '5,5d'. Deve ser algo como 5d, 5m ou 5a.
$ zzdata	5.5d		+	01/01/1970	#→ Delta inválido '5.5d'. Deve ser algo como 5d, 5m ou 5a.
$ zzdata	5,5d		+	01/01/1970	#→ Delta inválido '5,5d'. Deve ser algo como 5d, 5m ou 5a.
#
$ zzdata	01/01/1970	-			#→ --regex ^Uso:
$ zzdata	01/01/1970	+			#→ --regex ^Uso:
$ zzdata	hoje		+			#→ --regex ^Uso:
$ zzdata	today		+			#→ --regex ^Uso:
$ zzdata	111		+			#→ --regex ^Uso:
$ zzdata	1m		+			#→ --regex ^Uso:
$ zzdata	-		01/01/1970		#→ --regex ^Uso:
$ zzdata	+		01/01/1970		#→ --regex ^Uso:
$ zzdata	+		hoje			#→ --regex ^Uso:
$ zzdata	+		today			#→ --regex ^Uso:
$ zzdata	+		111			#→ --regex ^Uso:
$ zzdata	+		1m			#→ --regex ^Uso:

# Exemplos do --help
$ zzdata	22/12/1999	+	69		#→ 29/02/2000
$ zzdata	01/03/2000	-	69		#→ 23/12/1999
$ zzdata	01/03/2000	-	11/11/1999	#→ 111

# Checagem de ano bissexto
$ zzdata	29/02/2000				#→ 11016
$ zzdata	1	+	29/02/2000		#→ 01/03/2000
$ zzdata	29/02/2001				#→ Data inválida '29/02/2001', pois 2001 não é um ano bissexto
$ zzdata	1	 + 	29/02/2001		#→ Data inválida '29/02/2001', pois 2001 não é um ano bissexto

# Troca de 29/02 pra 28/02 quando o resultado do delta não é bissexto
$ zzdata	29/02/2000	+	1a		#→ 28/02/2001
$ zzdata	29/02/2000	+	4a		#→ 29/02/2004

# delta
$ zzdata	01/01/2000 + 0		#→ 01/01/2000
$ zzdata	01/01/2000 + 0d		#→ 01/01/2000
$ zzdata	01/01/2000 + 0m		#→ 01/01/2000
$ zzdata	01/01/2000 + 0a		#→ 01/01/2000
$ zzdata	01/01/2000 + 1		#→ 02/01/2000
$ zzdata	01/01/2000 + 1d		#→ 02/01/2000
$ zzdata	01/01/2000 + 1m		#→ 01/02/2000
$ zzdata	01/01/2000 + 1a		#→ 01/01/2001
$ zzdata	01/01/2000 + 10		#→ 11/01/2000
$ zzdata	01/01/2000 + 10d	#→ 11/01/2000
$ zzdata	01/01/2000 + 10m	#→ 01/11/2000
$ zzdata	01/01/2000 + 10a	#→ 01/01/2010
$ zzdata	01/01/2000 + 100	#→ 10/04/2000
$ zzdata	01/01/2000 + 100d	#→ 10/04/2000
$ zzdata	01/01/2000 + 100m	#→ 01/05/2008
$ zzdata	01/01/2000 + 100a	#→ 01/01/2100
$ zzdata	01/01/2000 - 1		#→ 31/12/1999
$ zzdata	01/01/2000 - 1d		#→ 31/12/1999
$ zzdata	01/01/2000 - 1m		#→ 01/12/1999
$ zzdata	01/01/2000 - 1a		#→ 01/01/1999
$ zzdata	01/01/2000 - 10		#→ 22/12/1999
$ zzdata	01/01/2000 - 10d	#→ 22/12/1999
$ zzdata	01/01/2000 - 10m	#→ 01/03/1999
$ zzdata	01/01/2000 - 10a	#→ 01/01/1990
$ zzdata	01/01/2000 - 100	#→ 23/09/1999
$ zzdata	01/01/2000 - 100d	#→ 23/09/1999
$ zzdata	01/01/2000 - 100m	#→ 01/09/1991
$ zzdata	01/01/2000 - 100a	#→ 01/01/1900
# delta negativo, porém com resultado positivo (não muda o ano)
$ zzdata	01/10/2000 - 5m		#→ 01/05/2000

# Delta com números
$ zzdata	0	+	1d	#→ 02/01/1970
$ zzdata	1	+	1d	#→ 03/01/1970
$ zzdata	1	+	1m	#→ 02/02/1970
$ zzdata	1	+	1a	#→ 02/01/1971
$ zzdata	1d	+	0	#→ 02/01/1970
$ zzdata	1d	+	1	#→ 03/01/1970
$ zzdata	1m	+	1	#→ 02/02/1970
$ zzdata	1a	+	1	#→ 02/01/1971

# Limites do Epoch
$ zzdata	30/12/1968		#→ -367
$ zzdata	31/12/1968		#→ -366
$ zzdata	01/01/1969		#→ -365
$ zzdata	02/01/1969		#→ -364
$ zzdata	30/12/1969		#→ -2
$ zzdata	31/12/1969		#→ -1
$ zzdata	01/01/1970		#→ 0
$ zzdata	02/01/1970		#→ 1
$ zzdata	03/01/1970		#→ 2
$ zzdata	31/12/1970		#→ 364
$ zzdata	01/01/1971		#→ 365
$ zzdata	02/01/1971		#→ 366
$ zzdata	-367			#→ 30/12/1968
$ zzdata	-366			#→ 31/12/1968
$ zzdata	-365			#→ 01/01/1969
$ zzdata	-364			#→ 02/01/1969
$ zzdata	-2			#→ 30/12/1969
$ zzdata	-1			#→ 31/12/1969
$ zzdata	0			#→ 01/01/1970
$ zzdata	1			#→ 02/01/1970
$ zzdata	2			#→ 03/01/1970
$ zzdata	364			#→ 31/12/1970
$ zzdata	365			#→ 01/01/1971
$ zzdata	366			#→ 02/01/1971

# Bissexto antes de Epoch
$ zzdata	-673			#→ 28/02/1968
$ zzdata	-672			#→ 29/02/1968
$ zzdata	-671			#→ 01/03/1968
$ zzdata	28/02/1968		#→ -673
$ zzdata	29/02/1968		#→ -672
$ zzdata	01/03/1968		#→ -671

# Bissexto depois de Epoch
$ zzdata	788			#→ 28/02/1972
$ zzdata	789			#→ 29/02/1972
$ zzdata	790			#→ 01/03/1972
$ zzdata	28/02/1972		#→ 788
$ zzdata	29/02/1972		#→ 789
$ zzdata	01/03/1972		#→ 790

# Data -> Número
$ zzdata	01/01/1970		#→ 0
$ zzdata	28/02/1970		#→ 58
$ zzdata	01/03/1970		#→ 59
$ zzdata	31/12/1970		#→ 364
$ zzdata	01/01/1971		#→ 365
$ zzdata	28/02/1972		#→ 788
$ zzdata	29/02/1972		#→ 789
$ zzdata	01/03/1972		#→ 790
$ zzdata	31/12/1972		#→ 1095
$ zzdata	01/01/1973		#→ 1096
$ zzdata	28/02/1973		#→ 1154
$ zzdata	01/03/1973		#→ 1155
$ zzdata	28/02/1976		#→ 2249
$ zzdata	29/02/1976		#→ 2250
$ zzdata	31/12/1976		#→ 2556
$ zzdata	01/01/1977		#→ 2557
$ zzdata	01/01/1980		#→ 3652
$ zzdata	02/01/1980		#→ 3653
$ zzdata	28/02/1980		#→ 3710
$ zzdata	29/02/1980		#→ 3711
$ zzdata	01/03/1980		#→ 3712
$ zzdata	31/12/1980		#→ 4017
$ zzdata	01/01/1981		#→ 4018
$ zzdata	02/01/1981		#→ 4019
$ zzdata	28/02/1981		#→ 4076
$ zzdata	01/03/1981		#→ 4077
$ zzdata	31/12/1981		#→ 4382
$ zzdata	01/01/1982		#→ 4383
$ zzdata	02/01/1982		#→ 4384
$ zzdata	10/09/1983		#→ 5000
$ zzdata	31/12/1983		#→ 5112
$ zzdata	01/01/1984		#→ 5113
$ zzdata	02/01/1984		#→ 5114
$ zzdata	28/02/1984		#→ 5171
$ zzdata	29/02/1984		#→ 5172
$ zzdata	01/03/1984		#→ 5173
$ zzdata	31/12/1984		#→ 5478
$ zzdata	01/01/1985		#→ 5479
$ zzdata	02/01/1985		#→ 5480
$ zzdata	28/02/1985		#→ 5537
$ zzdata	01/03/1985		#→ 5538
$ zzdata	31/12/1985		#→ 5843
$ zzdata	01/01/1986		#→ 5844
$ zzdata	02/01/1986		#→ 5845
$ zzdata	31/12/1986		#→ 6208
$ zzdata	01/01/1987		#→ 6209
$ zzdata	02/01/1987		#→ 6210
$ zzdata	31/12/1987		#→ 6573
$ zzdata	01/01/1988		#→ 6574
$ zzdata	02/01/1988		#→ 6575
$ zzdata	31/12/1988		#→ 6939
$ zzdata	01/01/1989		#→ 6940
$ zzdata	02/01/1989		#→ 6941
$ zzdata	31/12/1989		#→ 7304
$ zzdata	01/01/1990		#→ 7305
$ zzdata	02/01/1990		#→ 7306
$ zzdata	27/11/1991		#→ 8000
$ zzdata	23/08/1994		#→ 9000
$ zzdata	19/05/1997		#→ 10000
$ zzdata	13/02/2000		#→ 11000
$ zzdata	29/01/2003		#→ 12081

# Número -> Data
$ zzdata	0			#→ 01/01/1970
$ zzdata	58			#→ 28/02/1970
$ zzdata	59			#→ 01/03/1970
$ zzdata	364			#→ 31/12/1970
$ zzdata	365			#→ 01/01/1971
$ zzdata	788			#→ 28/02/1972
$ zzdata	789			#→ 29/02/1972
$ zzdata	790			#→ 01/03/1972
$ zzdata	1095			#→ 31/12/1972
$ zzdata	1096			#→ 01/01/1973
$ zzdata	1154			#→ 28/02/1973
$ zzdata	1155			#→ 01/03/1973
$ zzdata	2249			#→ 28/02/1976
$ zzdata	2250			#→ 29/02/1976
$ zzdata	2556			#→ 31/12/1976
$ zzdata	2557			#→ 01/01/1977
$ zzdata	3652			#→ 01/01/1980
$ zzdata	3653			#→ 02/01/1980
$ zzdata	3710			#→ 28/02/1980
$ zzdata	3711			#→ 29/02/1980
$ zzdata	3712			#→ 01/03/1980
$ zzdata	4017			#→ 31/12/1980
$ zzdata	4018			#→ 01/01/1981
$ zzdata	4019			#→ 02/01/1981
$ zzdata	4076			#→ 28/02/1981
$ zzdata	4077			#→ 01/03/1981
$ zzdata	4382			#→ 31/12/1981
$ zzdata	4383			#→ 01/01/1982
$ zzdata	4384			#→ 02/01/1982
$ zzdata	5000			#→ 10/09/1983
$ zzdata	5112			#→ 31/12/1983
$ zzdata	5113			#→ 01/01/1984
$ zzdata	5114			#→ 02/01/1984
$ zzdata	5171			#→ 28/02/1984
$ zzdata	5172			#→ 29/02/1984
$ zzdata	5173			#→ 01/03/1984
$ zzdata	5478			#→ 31/12/1984
$ zzdata	5479			#→ 01/01/1985
$ zzdata	5480			#→ 02/01/1985
$ zzdata	5537			#→ 28/02/1985
$ zzdata	5538			#→ 01/03/1985
$ zzdata	5843			#→ 31/12/1985
$ zzdata	5844			#→ 01/01/1986
$ zzdata	5845			#→ 02/01/1986
$ zzdata	6208			#→ 31/12/1986
$ zzdata	6209			#→ 01/01/1987
$ zzdata	6210			#→ 02/01/1987
$ zzdata	6573			#→ 31/12/1987
$ zzdata	6574			#→ 01/01/1988
$ zzdata	6575			#→ 02/01/1988
$ zzdata	6939			#→ 31/12/1988
$ zzdata	6940			#→ 01/01/1989
$ zzdata	6941			#→ 02/01/1989
$ zzdata	7304			#→ 31/12/1989
$ zzdata	7305			#→ 01/01/1990
$ zzdata	7306			#→ 02/01/1990
$ zzdata	8000			#→ 27/11/1991
$ zzdata	9000			#→ 23/08/1994
$ zzdata	10000			#→ 19/05/1997
$ zzdata	11000			#→ 13/02/2000
$ zzdata	12081			#→ 29/01/2003

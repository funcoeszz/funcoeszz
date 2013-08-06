# Preparativos

$ cat _dados.txt
1:um:one
2:dois:two
3:tres:three
4:quatro:four
5:cinco:five
$ cat _dados.txt | tr : ' ' > _tmp1
$ sed 's/um/UM/;s/ three//;s/cinco/& mil/' _tmp1 > _tmp2
$ sed 's/five/FIVE/' _tmp1 > _tmp3
$ sed 's/ five//' _tmp1 > _tmp4
$

# Uso incorreto

$ zzdiffpalavra			#→ --regex ^Uso:
$ zzdiffpalavra	_tmp1		#→ --regex ^Uso:

# Arquivo não existente

$ zzdiffpalavra	_fake_	_tmp2_	#→ Não consegui ler o arquivo _fake_
$ zzdiffpalavra	_tmp1	_fake_	#→ Não consegui ler o arquivo _fake_

# Nenhuma diferença

$ zzdiffpalavra	_tmp1	_tmp1				# no diff
$ zzdiffpalavra	_vazio.txt	_vazio.txt		# both empty
$

# Há diferenças

$ zzdiffpalavra	_tmp1	_tmp2				# termina normal
 1
-um
+UM
 one 2 dois two 3 tres
-three
 4 quatro four 5 cinco
+mil
 five
$ zzdiffpalavra	_tmp1	_vazio.txt			# só -antigo
-1 um one 2 dois two 3 tres three 4 quatro four 5 cinco five
$ zzdiffpalavra	_vazio.txt	_tmp1			# só +novo
+1 um one 2 dois two 3 tres three 4 quatro four 5 cinco five
$ zzdiffpalavra	_tmp1	_tmp3				# termina +novo
 1 um one 2 dois two 3 tres three 4 quatro four 5 cinco
-five
+FIVE
$ zzdiffpalavra	_tmp1	_tmp4				# termina -antigo
 1 um one 2 dois two 3 tres three 4 quatro four 5 cinco
-five
$

# Faxina
$ rm -f _tmp[1-4]
$

# Linhas 1 a 4 são sempre apagadas, por ser comentários ou em branco

$ cat _dados.txt | sed '1s/^/#/; 2s/^/   #/;3s/^/	#/;4s/.*//' > _tmp1
$ cat _dados.txt | sed '1s/^/"/; 2s/^/   "/;3s/^/	"/;4s/.*//' > _tmp.vim
$ cat _dados.txt | sed '1,4d' > _tmp3				# só a última linha
$ cat _dados.txt | sed 's/.*/   	       	/' > _tmp4	# só brancos
$ cat _tmp1 _tmp1 _tmp1 > _tmp5					# testa o uniq
$

$ zzlimpalixo	_tmp1		#→ --file _tmp3
$ zzlimpalixo	_tmp.vim	#→ --file _tmp3
$ zzlimpalixo	_tmp4
$ zzlimpalixo	_tmp5		#→ --file _tmp3

# Faxina
$ rm -f _tmp[1-5] _tmp.vim
$

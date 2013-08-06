$ cat _dados.txt
1:um:one
2:dois:two
3:tres:three
4:quatro:four
5:cinco:five
$

# Erros

$ zztrocapalavra				#→ --regex ^Uso:
$ zztrocapalavra	dois			#→ --regex ^Uso:
$ zztrocapalavra	dois	DOIS		#→ --regex ^Uso:
$ zztrocapalavra	dois	DOIS	_fake_	#→ Não consegui ler o arquivo _fake_

# Troca simples

$ cp _dados.txt _tmp
$ zztrocapalavra dois DOIS _tmp
Feito _tmp
$ sed 's/dois/DOIS/g' _dados.txt | diff - _tmp
$

# Troca global

$ cp _dados.txt _tmp
$ zztrocapalavra : ' ' _tmp
Feito _tmp
$ sed 's/:/ /g' _dados.txt | diff - _tmp
$

# Faxina

$ rm -f _tmp
$

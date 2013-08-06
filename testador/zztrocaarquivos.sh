# Preparativos

$ echo 1 > _tmp1
$ echo 2 > _tmp2
$

# Erros

$ zztrocaarquivos			#→ --regex ^Uso:
$ zztrocaarquivos	_tmp1		#→ --regex ^Uso:
$ zztrocaarquivos	_fake_	_tmp2_	#→ Não consegui ler o arquivo _fake_
$ zztrocaarquivos	_tmp1	_fake_	#→ Não consegui ler o arquivo _fake_

# Ignora quando é o mesmo arquivo

$ zztrocaarquivos	_tmp1	_tmp1
$

# Operação normal

$ zztrocaarquivos	_tmp1	_tmp2
Feito: _tmp1 <-> _tmp2
$ cat _tmp1
2
$ cat _tmp2
1
$

# Faxina

$ rm -f _tmp[12]
$

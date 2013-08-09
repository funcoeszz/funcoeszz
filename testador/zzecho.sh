# Uso incorreto

$ zzecho	'-l'			#→ --regex ^Uso:
$ zzecho	'-f'			#→ --regex ^Uso:
$ zzecho	'-l'	'xxx'		#→ --regex ^Uso:
$ zzecho	'-f'	'xxx'		#→ --regex ^Uso:
$ zzecho	'-f'	'azulx'		#→ --regex ^Uso:

# Antigamente era uso incorreto, hoje mostra o -X

$ zzecho	'-X'			#→ -X
$ zzecho	'-s'	'-N'	'-X'	#→ -X

# Texto sem cores

$ zzecho	Foo	Bar		#→ Foo Bar
$ zzecho	-l	azul	Foo	#→ Foo
$ zzecho	-p	-s	Foo	#→ Foo

# Linha parcial (sem \n) tem que usar o --regex
$ zzecho	-n	Foo	Bar	#→ --regex ^Foo Bar$


# Texto colorido

$ ZZCOR=1
$ zzecho	-n	Foo	Bar				#→ --regex ^Foo Bar$
$ zzecho	-n	-l	azul	Foo			#→ --regex ^.\[;34mFoo.\[m$
$ zzecho	-n	-f	azul	Foo			#→ --regex ^.\[44mFoo.\[m$
$ zzecho	-n	-f	azul	-l	azul	Foo	#→ --regex ^.\[44;34mFoo.\[m$
$ zzecho	-n	-N	-p	-s	Foo		#→ --regex ^.\[;1;5;4mFoo.\[m$
$ zzecho --nao-quebra --fundo azul --letra azul		Foo	#→ --regex ^.\[44;34mFoo.\[m$
$ zzecho --nao-quebra --negrito --pisca	--sublinhado	Foo	#→ --regex ^.\[;1;5;4mFoo.\[m$
$ ZZCOR=0

$ cat _numeros.txt
1
2
3
4
5
$

# sem opções

$ zzjuntalinhas	_numeros.txt
1	2	3	4	5
$

# -d

$ zzjuntalinhas	-d	''	_numeros.txt	#→ 12345
$ zzjuntalinhas	-d	@	_numeros.txt	#→ 1@2@3@4@5
$ zzjuntalinhas	-d	::	_numeros.txt	#→ 1::2::3::4::5
$ zzjuntalinhas	 -d	'{ }'	_numeros.txt	#→ 1{ }2{ }3{ }4{ }5

# Números e $

# depende do sed, o GNU entende endereço zero, BSD não
# $ zzjuntalinhas	-d	@	-i	0	_numeros.txt
# 1@2@3@4@5
$ zzjuntalinhas	-d	@	-i	1	_numeros.txt
1@2@3@4@5
$ zzjuntalinhas	-d	@	-i	3	_numeros.txt
1
2
3@4@5
$ zzjuntalinhas	-d	@	-i	$	_numeros.txt
1
2
3
4
5
$ zzjuntalinhas	-d	@	-f	1	_numeros.txt
1
2
3
4
5
$ zzjuntalinhas	-d	@	-f	3	_numeros.txt
1@2@3
4
5
$ zzjuntalinhas	-d	@	-f	$	_numeros.txt
1@2@3@4@5
$ zzjuntalinhas	-i	2	-f	4	_numeros.txt
1
2	3	4
5
$ zzjuntalinhas	-i	4	-f	2	_numeros.txt
1
2
3
4	5
$ zzjuntalinhas	-i	4	-f	$	_numeros.txt
1
2
3
4	5
$ zzjuntalinhas	-i	1	-f	$	_numeros.txt
1	2	3	4	5
$ zzjuntalinhas	-i	4	-f	4	_numeros.txt
1
2
3
4
5
$ zzjuntalinhas	-i	99	-f	$	_numeros.txt
1
2
3
4
5
$ zzjuntalinhas	-i	4	-f	99	_numeros.txt
1
2
3
4
5
$

# Regex

$ zzjuntalinhas	-d	@	-i	^1$	_numeros.txt
1@2@3@4@5
$ zzjuntalinhas	-d	@	-i	^3$	_numeros.txt
1
2
3@4@5
$ zzjuntalinhas	-d	@	-f	^1$	_numeros.txt
1
2
3
4
5
$ zzjuntalinhas	-d	@	-f	^3$	_numeros.txt
1@2@3
4
5
$ zzjuntalinhas	-i	^2$	-f	^4$	_numeros.txt
1
2	3	4
5
$

# Escape da /

$ zzjuntalinhas	-d	@	-f	a/b	_numeros.txt
1
2
3
4
5
$ zzjuntalinhas	-d	@	-i	a/b	_numeros.txt
1
2
3
4
5
$ zzjuntalinhas	-d	/	-i	1	_numeros.txt
1/2/3/4/5
$ zzjuntalinhas	-i	a/b	-f	a/b	_numeros.txt
1
2
3
4
5
$

# Início e fim na mesma linha

$ zzjuntalinhas	-i	^2	-f	:	_dados.txt
1:um:one
2:dois:two
3:tres:three
4:quatro:four
5:cinco:five
$

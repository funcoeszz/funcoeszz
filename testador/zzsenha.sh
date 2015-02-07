# Erros

$ zzsenha		FOO	#→ Número inválido 'FOO'
$ zzsenha		-8	#→ Número inválido '-8'
$ zzsenha		--foo	#→ Número inválido '--foo'

$ zzsenha	--num	FOO	#→ Número inválido 'FOO'
$ zzsenha	--num	-8	#→ Número inválido '-8'

$ zzsenha	--pro	FOO	#→ Número inválido 'FOO'
$ zzsenha	--pro	-8	#→ Número inválido '-8'

$ zzsenha	--uniq	FOO	#→ Número inválido 'FOO'
$ zzsenha	--uniq	-8	#→ Número inválido '-8'
$ zzsenha	--uniq	63	#→ O tamanho máximo desse tipo de senha é 62

$ zzsenha	--num	--uniq	FOO	#→ Número inválido 'FOO'
$ zzsenha	--num	--uniq	-8	#→ Número inválido '-8'
$ zzsenha	--num	--uniq	12	#→ O tamanho máximo desse tipo de senha é 10
$ zzsenha	--uniq	--num	FOO	#→ Número inválido 'FOO'
$ zzsenha	--uniq	--num	-8	#→ Número inválido '-8'
$ zzsenha	--uniq	--num	12	#→ O tamanho máximo desse tipo de senha é 10

$ zzsenha	--pro	--uniq	FOO	#→ Número inválido 'FOO'
$ zzsenha	--pro	--uniq	-8	#→ Número inválido '-8'
$ zzsenha	--pro	--uniq	76	#→ O tamanho máximo desse tipo de senha é 75
$ zzsenha	--uniq	--pro	FOO	#→ Número inválido 'FOO'
$ zzsenha	--uniq	--pro	-8	#→ Número inválido '-8'
$ zzsenha	--uniq	--pro	76	#→ O tamanho máximo desse tipo de senha é 75

# Normal

$ zzsenha		0
$ zzsenha		1	#→ --regex ^[A-Za-z0-9]$
$ zzsenha		10	#→ --regex ^[A-Za-z0-9]{10}$
$ zzsenha		62	#→ --regex ^[A-Za-z0-9]{62}$
$ zzsenha			#→ --regex ^[A-Za-z0-9]{8}$

# --num

$ zzsenha	--num	0
$ zzsenha	--num	1	#→ --regex ^[0-9]$
$ zzsenha	--num	10	#→ --regex ^[0-9]{10}$
$ zzsenha	--num		#→ --regex ^[0-9]{8}$

# --pro

$ zzsenha	--pro	0
$ zzsenha	--pro	1	#→ --regex ^[A-Za-z0-9/:;()$&@.,?!-]$
$ zzsenha	--pro	10	#→ --regex ^[A-Za-z0-9/:;()$&@.,?!-]{10}$
$ zzsenha	--pro	75	#→ --regex ^[A-Za-z0-9/:;()$&@.,?!-]{75}$
$ zzsenha	--pro		#→ --regex ^[A-Za-z0-9/:;()$&@.,?!-]{8}$

# --uniq

$ zzsenha	--uniq	0
$ zzsenha	--uniq	1	#→ --regex ^[A-Za-z0-9]$
$ zzsenha	--uniq	10	#→ --regex ^[A-Za-z0-9]{10}$
$ zzsenha	--uniq	62	#→ --regex ^[A-Za-z0-9]{62}$
$ zzsenha	--uniq		#→ --regex ^[A-Za-z0-9]{8}$

# combinado --num --uniq / --uniq --num

$ zzsenha	--num	--uniq	0
$ zzsenha	--num	--uniq	1	#→ --regex ^[0-9]$
$ zzsenha	--num	--uniq	10	#→ --regex ^[0-9]{10}$
$ zzsenha	--num	--uniq		#→ --regex ^[0-9]{8}$
$ zzsenha	--uniq	--num	0
$ zzsenha	--uniq	--num	1	#→ --regex ^[0-9]$
$ zzsenha	--uniq	--num	10	#→ --regex ^[0-9]{10}$
$ zzsenha	--uniq	--num		#→ --regex ^[0-9]{8}$

# combinado --pro --uniq / --uniq --pro

$ zzsenha	--pro	--uniq	0
$ zzsenha	--pro	--uniq	1	#→ --regex ^[A-Za-z0-9/:;()$&@.,?!-]$
$ zzsenha	--pro	--uniq	10	#→ --regex ^[A-Za-z0-9/:;()$&@.,?!-]{10}$
$ zzsenha	--pro	--uniq		#→ --regex ^[A-Za-z0-9/:;()$&@.,?!-]{8}$
$ zzsenha	--uniq	--num	0
$ zzsenha	--uniq	--num	1	#→ --regex ^[A-Za-z0-9/:;()$&@.,?!-]$
$ zzsenha	--uniq	--num	10	#→ --regex ^[A-Za-z0-9/:;()$&@.,?!-]{10}$
$ zzsenha	--uniq	--num		#→ --regex ^[A-Za-z0-9/:;()$&@.,?!-]{8}$

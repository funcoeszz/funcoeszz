$ ZZMONEYLOG='zzmoneylog.in.txt'
$

# Erros

$ zzmoneylog	-z				#→ Opção inválida -z
$ zzmoneylog	--foo				#→ Opção inválida --foo
$ zzmoneylog	-a	foo			#→ Não consegui ler o arquivo foo
$ zzmoneylog	-a	foo/			#→ Não consegui ler o arquivo foo/

# Pesquisa normal

$ zzmoneylog	--	Baú			#→ 2009-08-20	-10,00	Carnê do Baú
$ zzmoneylog	Baú				#→ 2009-08-20	-10,00	Carnê do Baú

# Data parcial (final opcional)

$ zzmoneylog	-d	2		Baú	#→ 2009-08-20	-10,00	Carnê do Baú
$ zzmoneylog	-d	20		Baú	#→ 2009-08-20	-10,00	Carnê do Baú
$ zzmoneylog	-d	200		Baú	#→ 2009-08-20	-10,00	Carnê do Baú
$ zzmoneylog	-d	2009		Baú	#→ 2009-08-20	-10,00	Carnê do Baú
$ zzmoneylog	-d	2009-		Baú	#→ 2009-08-20	-10,00	Carnê do Baú
$ zzmoneylog	-d	2009-0		Baú	#→ 2009-08-20	-10,00	Carnê do Baú
$ zzmoneylog	-d	2009-08		Baú	#→ 2009-08-20	-10,00	Carnê do Baú
$ zzmoneylog	-d	2009-08-	Baú	#→ 2009-08-20	-10,00	Carnê do Baú
$ zzmoneylog	-d	2009-08-2	Baú	#→ 2009-08-20	-10,00	Carnê do Baú
$ zzmoneylog	-d	2009-08-20	Baú	#→ 2009-08-20	-10,00	Carnê do Baú

# Data no formato brasileiro é convertida

$ zzmoneylog	-d	03/06/2009		#→ 2009-06-03	-342,59	presente| Um Shrubbery
$ zzmoneylog	-d	03/06/09		#→ 2009-06-03	-342,59	presente| Um Shrubbery

# Faltando zeros

$ zzmoneylog	-d	3/06/2009		#→ 2009-06-03	-342,59	presente| Um Shrubbery
$ zzmoneylog	-d	03/6/2009		#→ 2009-06-03	-342,59	presente| Um Shrubbery
$ zzmoneylog	-d	3/6/2009		#→ 2009-06-03	-342,59	presente| Um Shrubbery

# Faltando zeros e ano com dois dígitos

$ zzmoneylog	-d	3/06/09			#→ 2009-06-03	-342,59	presente| Um Shrubbery
$ zzmoneylog	-d	03/6/09			#→ 2009-06-03	-342,59	presente| Um Shrubbery
$ zzmoneylog	-d	3/6/09			#→ 2009-06-03	-342,59	presente| Um Shrubbery

# Só mês e ano

$ zzmoneylog	-d	06/2009	        Shru	#→ 2009-06-03	-342,59	presente| Um Shrubbery
$ zzmoneylog	-d	6/2009	        Shru	#→ 2009-06-03	-342,59	presente| Um Shrubbery

# Valor informado com ponto ou vírgula

$ zzmoneylog	-v	10,00			#→ 2009-08-20	-10,00	Carnê do Baú
$ zzmoneylog	-v	10.00			#→ 2009-08-20	-10,00	Carnê do Baú
$ zzmoneylog	-v	-10.00			#→ 2009-08-20	-10,00	Carnê do Baú
$ zzmoneylog	-v	-10,00			#→ 2009-08-20	-10,00	Carnê do Baú

# Tag parcial (início ou fim)

$ zzmoneylog	-t	livro			#→ 2009-05-23	-39,90	presente, livro| Livro Horóscopo dos Duendes
$ zzmoneylog	-t	livr			#→ 2009-05-23	-39,90	presente, livro| Livro Horóscopo dos Duendes
$ zzmoneylog	-t	liv			#→ 2009-05-23	-39,90	presente, livro| Livro Horóscopo dos Duendes
$ zzmoneylog	-t	vro			#→ 2009-05-23	-39,90	presente, livro| Livro Horóscopo dos Duendes


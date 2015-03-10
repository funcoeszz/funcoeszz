# Número incorreto de dígitos
$ zzcnpj 123456780001			#→ CNPJ inválido (deve ter 14 dígitos)
$ zzcnpj 123456780001000		#→ CNPJ inválido (deve ter 14 dígitos)

# Apenas números zeros
$ zzcnpj 00000000000000			#→ CNPJ inválido (não pode conter apenas zeros)
$ zzcnpj 00.000.000/0000-00		#→ CNPJ inválido (não pode conter apenas zeros)

# Dígito verificador incorreto
$ zzcnpj 12345678000100			#→ CNPJ inválido (deveria terminar em 95)

# Números válidos, com ou sem pontuação
$ zzcnpj 12345678000195			#→ CNPJ válido
$ zzcnpj 12.345.678/0001-95		#→ CNPJ válido

# Qualquer caractere não numérico é removido
$ zzcnpj '12 345 678 0001 95'		#→ CNPJ válido
$ zzcnpj 'z1_23	4=5*6@7+8?00a0195'	#→ CNPJ válido

# Sem argumentos, gera um CNPJ aleatório
$ zzcnpj 				#→ --regex ^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$

# Sem argumentos numéricos pós-limpeza, gera um CNPJ aleatório
$ zzcnpj	foo		 	#→ --regex ^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$

# -f: Formata um CNPJ (sem validar)
$ zzcnpj -f	12345678000123		#→ 12.345.678/0001-23

# -f: Qualquer caractere não numérico é removido
$ zzcnpj -f	12.345.678/0001-23	#→ 12.345.678/0001-23
$ zzcnpj -f	12.345.678.0001.23	#→ 12.345.678/0001-23
$ zzcnpj -f	'12 345 678 0001 23'	#→ 12.345.678/0001-23
$ zzcnpj -f	'(1234=5*6@7+8?00a0123'	#→ 12.345.678/0001-23

# -f: Erro se informar mais de 14 dígitos
$ zzcnpj -f	12.345.678/0001-234	#→ CNPJ inválido (passou de 14 dígitos)
$ zzcnpj -f	123456789123456789	#→ CNPJ inválido (passou de 14 dígitos)

# -f: Completa com zeros quando tiver menos de 14 dígitos
$ zzcnpj -f	1			#→ 00.000.000/0000-01
$ zzcnpj -f	21			#→ 00.000.000/0000-21
$ zzcnpj -f	321			#→ 00.000.000/0003-21
$ zzcnpj -f	4321			#→ 00.000.000/0043-21
$ zzcnpj -f	54321			#→ 00.000.000/0543-21
$ zzcnpj -f	654321			#→ 00.000.000/6543-21
$ zzcnpj -f	7654321			#→ 00.000.007/6543-21
$ zzcnpj -f	87654321		#→ 00.000.087/6543-21
$ zzcnpj -f	987654321		#→ 00.000.987/6543-21
$ zzcnpj -f	1987654321		#→ 00.001.987/6543-21
$ zzcnpj -f	21987654321		#→ 00.021.987/6543-21
$ zzcnpj -f	321987654321		#→ 00.321.987/6543-21
$ zzcnpj -f	4321987654321		#→ 04.321.987/6543-21

# -f: zeros à esquerda na entrada são removidos/ignorados
$ zzcnpj -f	0			#→ 00.000.000/0000-00
$ zzcnpj -f	00000000000000000000	#→ 00.000.000/0000-00
$ zzcnpj -f	000054321		#→ 00.000.000/0543-21
$ zzcnpj -f	00000000000000054321	#→ 00.000.000/0543-21

# -f: Sem argumentos numéricos, assume zero
$ zzcnpj -f				#→ 00.000.000/0000-00
$ zzcnpj -f	foo			#→ 00.000.000/0000-00

# -f: remove símbolos e completa com zeros ao mesmo tempo
$ zzcnpj -f	'(1_2=3*4@5+6?7a8.'	#→ 00.000.012/3456-78

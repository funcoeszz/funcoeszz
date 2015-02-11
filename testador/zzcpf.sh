# Número incorreto de dígitos
$ zzcpf 123456789			#→ CPF inválido (deve ter 11 dígitos)
$ zzcpf 123456789012			#→ CPF inválido (deve ter 11 dígitos)

# Dígito verificador incorreto
$ zzcpf 12345678900			#→ CPF inválido (deveria terminar em 09)

# Números válidos, com ou sem pontuação
$ zzcpf 12345678909			#→ CPF válido
$ zzcpf 123.456.789-09			#→ CPF válido

# Qualquer caractere não numérico é removido
$ zzcpf '123 456 789 09'		#→ CPF válido
$ zzcpf 'z123	4_5=6*7@8+9?0a9'	#→ CPF válido

# Sem argumentos, gera um CPF aleatório
$ zzcpf				 	#→ --regex ^\d{3}\.\d{3}\.\d{3}-\d{2}$

# Sem argumentos numéricos pós-limpeza, gera um CPF aleatório
$ zzcpf	foo		 		#→ --regex ^\d{3}\.\d{3}\.\d{3}-\d{2}$

# -f: Formata um CPF (sem validar)
$ zzcpf -f	12345678912		#→ 123.456.789-12

# -f: Qualquer caractere não numérico é removido
$ zzcpf -f	123.456.789-12		#→ 123.456.789-12
$ zzcpf -f	123.456.789.12		#→ 123.456.789-12
$ zzcpf -f	'123 456 789 12'	#→ 123.456.789-12
$ zzcpf -f	'(1234_5=6*7@8+9?1a2'	#→ 123.456.789-12

# -f: Erro se informar mais de 11 dígitos
$ zzcpf -f	1234.567.891-23		#→ CPF inválido (passou de 11 dígitos)
$ zzcpf -f	123456789123456789	#→ CPF inválido (passou de 11 dígitos)

# -f: Completa com zeros quando tiver menos de 11 dígitos
$ zzcpf -f	1			#→ 000.000.000-01
$ zzcpf -f	21			#→ 000.000.000-21
$ zzcpf -f	321			#→ 000.000.003-21
$ zzcpf -f	4321			#→ 000.000.043-21
$ zzcpf -f	54321			#→ 000.000.543-21
$ zzcpf -f	654321			#→ 000.006.543-21
$ zzcpf -f	7654321			#→ 000.076.543-21
$ zzcpf -f	87654321		#→ 000.876.543-21
$ zzcpf -f	987654321		#→ 009.876.543-21
$ zzcpf -f	1987654321		#→ 019.876.543-21

# -f: zeros à esquerda na entrada são removidos/ignorados
$ zzcpf -f	0			#→ 000.000.000-00
$ zzcpf -f	00000000000000000000	#→ 000.000.000-00
$ zzcpf -f	000054321		#→ 000.000.543-21
$ zzcpf -f	00000000000000054321	#→ 000.000.543-21

# -f: Sem argumentos numéricos, assume zero
$ zzcpf -f				#→ 000.000.000-00
$ zzcpf -f	foo			#→ 000.000.000-00

# -f: remove símbolos e completa com zeros ao mesmo tempo
$ zzcpf -f	'(1_2=3*4@5+6?7a8.'	#→ 000.123.456-78

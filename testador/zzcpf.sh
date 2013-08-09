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

# Número incorreto de dígitos
$ zzcnpj 123456780001			#→ CNPJ inválido (deve ter 14 dígitos)
$ zzcnpj 123456780001000		#→ CNPJ inválido (deve ter 14 dígitos)

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

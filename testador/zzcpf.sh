# Número incorreto de dígitos
$ zzcpf 123456789012		#→ CPF inválido (deve ter 11 dígitos)
$ zzcpf 987654321987		#→ CPF inválido (deve ter 11 dígitos)

# Apenas números zeros
$ zzcpf 00000000000			#→ CPF inválido (não pode conter os 9 primeiros digitos iguais)
$ zzcpf 000.000.000-00		#→ CPF inválido (não pode conter os 9 primeiros digitos iguais)
$ zzcpf 11111111111			#→ CPF inválido (não pode conter os 9 primeiros digitos iguais)
$ zzcpf 22222222222			#→ CPF inválido (não pode conter os 9 primeiros digitos iguais)
$ zzcpf 33333333333			#→ CPF inválido (não pode conter os 9 primeiros digitos iguais)
$ zzcpf 44444444444			#→ CPF inválido (não pode conter os 9 primeiros digitos iguais)
$ zzcpf 55555555555			#→ CPF inválido (não pode conter os 9 primeiros digitos iguais)
$ zzcpf 66666666666			#→ CPF inválido (não pode conter os 9 primeiros digitos iguais)
$ zzcpf 77777777777			#→ CPF inválido (não pode conter os 9 primeiros digitos iguais)
$ zzcpf 88888888888			#→ CPF inválido (não pode conter os 9 primeiros digitos iguais)
$ zzcpf 99999999999			#→ CPF inválido (não pode conter os 9 primeiros digitos iguais)

# Dígito verificador incorreto
$ zzcpf 12345678900			#→ CPF inválido (deveria terminar em 09)

# Números válidos, com ou sem pontuação
$ zzcpf 12345678909			#→ CPF válido
$ zzcpf 123.456.789-09		#→ CPF válido

# Qualquer caractere não numérico é removido
$ zzcpf '123 456 789 09'			#→ CPF válido
$ zzcpf 'z123	4_5=6*7@8+9?0a9'	#→ CPF válido

# Sem argumentos, gera um CPF aleatório
$ zzcpf				 	#→ --regex ^\d{3}\.\d{3}\.\d{3}-\d{2}$

# Sem argumentos numéricos pós-limpeza, gera um CPF aleatório
$ zzcpf	foo		 		#→ --regex ^\d{3}\.\d{3}\.\d{3}-\d{2}$

# -f: Formata um CPF
$ zzcpf -f	12345678909		#→ 123.456.789-09

# -f: Desformata um CPF
$ zzcpf -F	123.456.789-09		#→ 12345678909

# -f: Qualquer caractere não numérico é removido
$ zzcpf -f	123.456.789-09			#→ 123.456.789-09
$ zzcpf -f	123.456.789.09			#→ 123.456.789-09
$ zzcpf -f	'123 456 789 09'		#→ 123.456.789-09
$ zzcpf -f	'(1234_5=6*7@8+9?0a9'	#→ 123.456.789-09

# -F: Qualquer caractere não numérico é removido
$ zzcpf -F	123.456.789-09			#→ 12345678909
$ zzcpf -F	123.456.789.09			#→ 12345678909
$ zzcpf -F	'123 456 789 09'		#→ 12345678909
$ zzcpf -F	'(1234_5=6*7@8+9?0a9'	#→ 12345678909

# -f: Erro se informar mais de 11 dígitos
$ zzcpf -f	1234.567.891-23		#→ CPF inválido (deve ter 11 dígitos)
$ zzcpf -f	123456789123456789	#→ CPF inválido (deve ter 11 dígitos)

# -F: Erro se informar mais de 11 dígitos
$ zzcpf -F	1234.567.891-23		#→ CPF inválido (deve ter 11 dígitos)
$ zzcpf -F	123456789123456789	#→ CPF inválido (deve ter 11 dígitos)

# -f: Completa com zeros quando tiver menos de 11 dígitos
$ zzcpf -f	353				#→ 000.000.003-53
$ zzcpf -f	4340			#→ 000.000.043-40
$ zzcpf -f	54364			#→ 000.000.543-64
$ zzcpf -f	654396			#→ 000.006.543-96
$ zzcpf -f	7654308			#→ 000.076.543-08
$ zzcpf -f	87654300		#→ 000.876.543-00
$ zzcpf -f	987654349		#→ 009.876.543-49
$ zzcpf -f	1987654366		#→ 019.876.543-66

# -F: Completa com zeros quando tiver menos de 11 dígitos
$ zzcpf -F	353				#→ 00000000353
$ zzcpf -F	4340			#→ 00000004340
$ zzcpf -F	54364			#→ 00000054364
$ zzcpf -F	654396			#→ 00000654396
$ zzcpf -F	7654308			#→ 00007654308
$ zzcpf -F	87654300		#→ 00087654300
$ zzcpf -F	987654349		#→ 00987654349
$ zzcpf -F	1987654366		#→ 01987654366

# -f: zeros à esquerda na entrada são removidos/ignorados
$ zzcpf -f	000054364				#→ 000.000.543-64
$ zzcpf -f	00000000000000054364	#→ 000.000.543-64

# -F: zeros à esquerda na entrada são removidos/ignorados
$ zzcpf -F	000054364				#→ 00000054364
$ zzcpf -F	00000000000000054364	#→ 00000054364

# -f: Sem argumentos numéricos, gera um CPF aleatório
$ zzcpf -f				#→ --regex ^\d{3}\.\d{3}\.\d{3}-\d{2}$
$ zzcpf -f	foo			#→ --regex ^\d{3}\.\d{3}\.\d{3}-\d{2}$

# -F: Sem argumentos numéricos, gera um CPF aleatório
$ zzcpf -F				#→ --regex ^\d{11}$
$ zzcpf -F	foo			#→ --regex ^\d{11}$

# -f: remove símbolos e completa com zeros ao mesmo tempo
$ zzcpf -f	'(1_2=3*4@5+6?0a1.'	#→ 000.123.456-01

# -F: remove símbolos e completa com zeros ao mesmo tempo
$ zzcpf -F	'(1_2=3*4@5+6?0a1.'	#→ 00012345601

# -q: Modo silencioso
$ zzcpf -q	123.456.789-09; echo $?	#→ 0
$ zzcpf -q	123.456.789-12; echo $?	#→ 1

# -e: Identificando o estado
$ zzcpf -e	21232411647		#→ Minas Gerais
$ zzcpf -e	55671434432		#→ Paraíba, Pernambuco, Alagoas ou Rio Grande do Norte
$ zzcpf -e	14522122101		#→ Distrito Federal, Goiás, Mato Grosso, Mato Grosso do Sul ou Tocantins
$ zzcpf -e	31311775862		#→ São Paulo
$ zzcpf -e	46545335596		#→ Bahia ou Sergipe
$ zzcpf -e	71656506360		#→ Ceará, Maranhão ou Piauí
$ zzcpf -e	33618235283		#→ Amazonas, Pará, Roraima, Amapá, Acre ou Rondônia
$ zzcpf -e	11341622789		#→ Rio de Janeiro ou Espírito Santo
$ zzcpf -e	68622361055		#→ Rio Grande do Sul
$ zzcpf -e	26664841908		#→ Paraná ou Santa Catarina

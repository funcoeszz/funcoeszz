# Número incorreto de dígitos
$ zzcnpj 123456780001000		#=> CNPJ inválido (deve ter 14 dígitos)

# Apenas números repetidos
$ zzcnpj 00000000000000			#=> CNPJ inválido (não pode conter os 12 primeiros digitos iguais)
$ zzcnpj 00.000.000/0000-00		#=> CNPJ inválido (não pode conter os 12 primeiros digitos iguais)
$ zzcnpj 11111111111111			#=> CNPJ inválido (não pode conter os 12 primeiros digitos iguais)
$ zzcnpj 22222222222222			#=> CNPJ inválido (não pode conter os 12 primeiros digitos iguais)
$ zzcnpj 33333333333333			#=> CNPJ inválido (não pode conter os 12 primeiros digitos iguais)
$ zzcnpj 44444444444444			#=> CNPJ inválido (não pode conter os 12 primeiros digitos iguais)
$ zzcnpj 55555555555555			#=> CNPJ inválido (não pode conter os 12 primeiros digitos iguais)
$ zzcnpj 66666666666666			#=> CNPJ inválido (não pode conter os 12 primeiros digitos iguais)
$ zzcnpj 77777777777777			#=> CNPJ inválido (não pode conter os 12 primeiros digitos iguais)
$ zzcnpj 88888888888888			#=> CNPJ inválido (não pode conter os 12 primeiros digitos iguais)
$ zzcnpj 99999999999999			#=> CNPJ inválido (não pode conter os 12 primeiros digitos iguais)

# Dígito verificador incorreto
$ zzcnpj 12345678000100			#=> CNPJ inválido (deveria terminar em 95)

# Números válidos, com ou sem pontuação
$ zzcnpj 12345678000195			#=> CNPJ válido
$ zzcnpj 12.345.678/0001-95		#=> CNPJ válido
$ zzcnpj 07213984000138			#=> CNPJ válido
$ zzcnpj 07.213.984/0001-38		#=> CNPJ válido

# Qualquer caractere não numérico é removido
$ zzcnpj '12 345 678 0001 95'		#=> CNPJ válido
$ zzcnpj 'z1_23	4=5*6@7+8?00a0195'	#=> CNPJ válido

# Sem argumentos, gera um CNPJ aleatório
$ zzcnpj 				#=> --regex ^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$

# Sem argumentos numéricos pós-limpeza, gera um CNPJ aleatório
$ zzcnpj	foo		 	#=> --regex ^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$

# -f: Formata um CNPJ
$ zzcnpj -f	12345678000195			#=> 12.345.678/0001-95

# -F: Desformata um CNPJ
$ zzcnpj -F	12.345.678/0001-95		#=> 12345678000195

# -f: Qualquer caractere não numérico é removido
$ zzcnpj -f	12.345.678/0001-95		#=> 12.345.678/0001-95
$ zzcnpj -f	12.345.678.0001.95		#=> 12.345.678/0001-95
$ zzcnpj -f	'12 345 678 0001 95'	#=> 12.345.678/0001-95
$ zzcnpj -f	'(1234=5*6@7+8?00a0195'	#=> 12.345.678/0001-95

# -F: Qualquer caractere não numérico é removido
$ zzcnpj -F	12.345.678/0001-95		#=> 12345678000195
$ zzcnpj -F	12.345.678.0001.95		#=> 12345678000195
$ zzcnpj -F	'12 345 678 0001 95'	#=> 12345678000195
$ zzcnpj -F	'(1234=5*6@7+8?00a0195'	#=> 12345678000195

# Erro se informar mais de 14 dígitos
$ zzcnpj -F	12.345.678/0001-234	#=> CNPJ inválido (deve ter 14 dígitos)
$ zzcnpj -f	123456789123456789	#=> CNPJ inválido (deve ter 14 dígitos)

# -f: Completa com zeros quando tiver menos de 14 dígitos
$ zzcnpj -f	353				#=> 00.000.000/0003-53
$ zzcnpj -f	4340			#=> 00.000.000/0043-40
$ zzcnpj -f	54364			#=> 00.000.000/0543-64
$ zzcnpj -f	654396			#=> 00.000.000/6543-96
$ zzcnpj -f	7654308			#=> 00.000.007/6543-08
$ zzcnpj -f	87654300		#=> 00.000.087/6543-00
$ zzcnpj -f	987654349		#=> 00.000.987/6543-49
$ zzcnpj -f	1987654363		#=> 00.001.987/6543-63
$ zzcnpj -f	21987654325		#=> 00.021.987/6543-25
$ zzcnpj -f	321987654340	#=> 00.321.987/6543-40
$ zzcnpj -f	4321987654300	#=> 04.321.987/6543-00

# -F: Completa com zeros quando tiver menos de 14 dígitos
$ zzcnpj -F	353				#=> 00000000000353
$ zzcnpj -F	4340			#=> 00000000004340
$ zzcnpj -F	54364			#=> 00000000054364
$ zzcnpj -F	654396			#=> 00000000654396
$ zzcnpj -F	7654308			#=> 00000007654308
$ zzcnpj -F	87654300		#=> 00000087654300
$ zzcnpj -F	987654349		#=> 00000987654349
$ zzcnpj -F	1987654363		#=> 00001987654363
$ zzcnpj -F	21987654325		#=> 00021987654325
$ zzcnpj -F	321987654340	#=> 00321987654340
$ zzcnpj -F	4321987654300	#=> 04321987654300

# -f: zeros à esquerda na entrada são removidos/ignorados
$ zzcnpj -f	000054364				#=> 00.000.000/0543-64
$ zzcnpj -f	00000000000000054364	#=> 00.000.000/0543-64

# -F: zeros à esquerda na entrada são removidos/ignorados
$ zzcnpj -F	000054364				#=> 00000000054364
$ zzcnpj -F	00000000000000054364	#=> 00000000054364

# -f: Sem argumentos numéricos, gera um CNPJ aleatório
$ zzcnpj -f				#=> --regex ^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$
$ zzcnpj -f	foo			#=> --regex ^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$

# -F: Sem argumentos numéricos, gera um CNPJ aleatório
$ zzcnpj -F				#=> --regex ^\d{14}$
$ zzcnpj -F	foo			#=> --regex ^\d{14}$

# -f: remove símbolos e completa com zeros ao mesmo tempo
$ zzcnpj -f	'(1_2=3*4@5+6?0a1.'	#=> 00.000.012/3456-01

# -F: remove símbolos e completa com zeros ao mesmo tempo
$ zzcnpj -F	'(1_2=3*4@5+6?0a1.'	#=> 00000012345601

# -q: Modo silencioso
$ zzcnpj -q	12345678000195; echo $?	#=> 0
$ zzcnpj -q	12345678000123; echo $?	#=> 1

# Consultando um CNPJ

$ zzcnpj -c 33041260102595
 atividade principal : Comércio varejista especializado de eletrodomésticos e equipamentos de áudio e vídeo 
 data situacao : 08/08/2012 
 tipo : FILIAL 
 nome : VIA VAREJO S/A 
 uf : SP 
 telefone : (11) 4225-6555 
 email : setorfiscal.csc@viavarejo.com.br 
 situacao : ATIVA 
 bairro : PIRAJUSSARA 
 logradouro : EST DO CAMPO LIMPO 
 numero : 3935 
 cep : 05.787-000 
 municipio : SAO PAULO 
 porte : DEMAIS 
 abertura : 08/08/2012 
 natureza juridica : 204-6 - Sociedade Anônima Aberta 
 cnpj : 33.041.260/1025-95 
 ultima atualizacao : 2021-03-07T22:06:47.958Z 
 status : OK 
 capital social : 0.00 
$

$ zzcnpj -c 27865757000102
 atividade principal : Atividades de televisão aberta 
 data situacao : 03/11/2005 
 tipo : MATRIZ 
 nome : GLOBO COMUNICACAO E PARTICIPACOES S/A 
 uf : RJ 
 telefone : (21) 2155-4551/ (21) 2155-4552 
 situacao : ATIVA 
 bairro : JARDIM BOTANICO 
 logradouro : R LOPES QUINTAS 
 numero : 303 
 cep : 22.460-901 
 municipio : RIO DE JANEIRO 
 porte : DEMAIS 
 abertura : 31/01/1986 
 natureza juridica : 205-4 - Sociedade Anônima Fechada 
 fantasia : TV/REDE/CANAIS/G2C+GLOBO SOMLIVRE GLOBO.COM GLOBOPLAY 
 cnpj : 27.865.757/0001-02 
 ultima atualizacao : 2021-06-29T23:24:56.960Z 
 status : OK 
 capital social : 6983568523.86 
$

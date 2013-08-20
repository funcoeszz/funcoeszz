# XXX aceitar prefixo + também?
# Sim aceita-se o prefixo, e será exibido junto ao resultado numérico.
# Ou terá um sufixo adicional 'positivo'

# número inválido ou não reconhecido
# Não exibe nada, exceto pelo código de retorno 1
# $ zznumero			foo		#→ Número inválido 'foo'
# $ zznumero			a5		#→ Número inválido 'a5'
# $ zznumero			5a		#→ Número inválido '5a'
$ zznumero			foo
$ zznumero			a5
$ zznumero			5a
$

# decimais e fracionários, incompletos
# XXX Aqui devemos tentar adivinhar ou simplesmente retornar 'número inválido'?
#     Acho que quanto menos "espertezas", melhor.
# Alguns combinaçãos já advinha, mas sempre suprimindo os 0 não significativos.
# $ zznumero			1.	#→ 1,00
# $ zznumero			1,	#→ 1,00
# $ zznumero			,1	#→ 0,1
# $ zznumero			.	#→ 0
# $ zznumero			,	#→ 0
# $ zznumero			-1.	#→ -1,00
# $ zznumero			-1,	#→ -1,00
# $ zznumero			-,1	#→ -0,1
# $ zznumero			-.	#→ 0
# $ zznumero			-,	#→ 0
$ zznumero			1.	#→ 1
$ zznumero			1,	#→ 1
$ zznumero			,1	#→ 0,1
$ zznumero			.
$ zznumero			,
$ zznumero			-1.	#→ -1
$ zznumero			-1,	#→ -1
$ zznumero			-,1	#→ -0,1
$ zznumero			+1.	#→ +1
$ zznumero			+1,	#→ +1
$ zznumero			+,1	#→ +0,1
$ zznumero			-.
$ zznumero			-,
$

### Sem argumentos, formata no padrão brasileiro: 1.234.567,89
## Mesmo caso, sempre suprimindo os zeros não significativos.
# zero
# $ zznumero			0		#→ 0
# $ zznumero			0,00		#→ 0,00
# $ zznumero			0,0000		#→ 0,0000		# XXX o certo é manter as casas ou deixar 2?
$ zznumero			0		#→ 0
$ zznumero			0,00		#→ 0
$ zznumero			0,0000		#→ 0

# decimais positivos
$ zznumero			1		#→ 1
$ zznumero			12		#→ 12
$ zznumero			123		#→ 123
$ zznumero			1234		#→ 1.234
$ zznumero			12345		#→ 12.345
$ zznumero			123456		#→ 123.456
$ zznumero			1234567		#→ 1.234.567
$ zznumero			12345678	#→ 12.345.678
$ zznumero			123456789	#→ 123.456.789
$ zznumero			1234567890	#→ 1.234.567.890
# decimais negativos
$ zznumero			-1		#→ -1
$ zznumero			-12		#→ -12
$ zznumero			-123		#→ -123
$ zznumero			-1234		#→ -1.234
$ zznumero			-12345		#→ -12.345
$ zznumero			-123456		#→ -123.456
$ zznumero			-1234567	#→ -1.234.567
$ zznumero			-12345678	#→ -12.345.678
$ zznumero			-123456789	#→ -123.456.789
$ zznumero			-1234567890	#→ -1.234.567.890
# fracionários positivos (00)
# sempre suprimindo os zeros não significativos.
# $ zznumero			1,00		#→ 1,00
# $ zznumero			12,00		#→ 12,00
# $ zznumero			123,00		#→ 123,00
# $ zznumero			1234,00		#→ 1.234,00
# $ zznumero			12345,00	#→ 12.345,00
# $ zznumero			123456,00	#→ 123.456,00
# $ zznumero			1234567,00	#→ 1.234.567,00
# $ zznumero			12345678,00	#→ 12.345.678,00
# $ zznumero			123456789,00	#→ 123.456.789,00
# $ zznumero			1234567890,00	#→ 1.234.567.890,00
$ zznumero			1,00		#→ 1
$ zznumero			12,00		#→ 12
$ zznumero			123,00		#→ 123
$ zznumero			1234,00		#→ 1.234
$ zznumero			12345,00	#→ 12.345
$ zznumero			123456,00	#→ 123.456
$ zznumero			1234567,00	#→ 1.234.567
$ zznumero			12345678,00	#→ 12.345.678
$ zznumero			123456789,00	#→ 123.456.789
$ zznumero			1234567890,00	#→ 1.234.567.890
# fracionários positivos (uma casa)
# XXX o certo é deixar 1 ou 2?
$ zznumero			1,1		#→ 1,1
$ zznumero			12,1		#→ 12,1
$ zznumero			123,1		#→ 123,1
$ zznumero			1234,1		#→ 1.234,1
$ zznumero			12345,1		#→ 12.345,1
$ zznumero			123456,1	#→ 123.456,1
$ zznumero			1234567,1	#→ 1.234.567,1
$ zznumero			12345678,1	#→ 12.345.678,1
$ zznumero			123456789,1	#→ 123.456.789,1
$ zznumero			1234567890,1	#→ 1.234.567.890,1
# fracionários positivos (duas casas)
$ zznumero			1,12		#→ 1,12
$ zznumero			12,12		#→ 12,12
$ zznumero			123,12		#→ 123,12
$ zznumero			1234,12		#→ 1.234,12
$ zznumero			12345,12	#→ 12.345,12
$ zznumero			123456,12	#→ 123.456,12
$ zznumero			1234567,12	#→ 1.234.567,12
$ zznumero			12345678,12	#→ 12.345.678,12
$ zznumero			123456789,12	#→ 123.456.789,12
$ zznumero			1234567890,12	#→ 1.234.567.890,12
# fracionários positivos (muitas casas)
# XXX o certo é manter as casas ou deixar 2?
$ zznumero			1,123456789		#→ 1,123456789
$ zznumero			12,123456789		#→ 12,123456789
$ zznumero			123,123456789		#→ 123,123456789
$ zznumero			1234,123456789		#→ 1.234,123456789
$ zznumero			12345,123456789		#→ 12.345,123456789
$ zznumero			123456,123456789	#→ 123.456,123456789
$ zznumero			1234567,123456789	#→ 1.234.567,123456789
$ zznumero			12345678,123456789	#→ 12.345.678,123456789
$ zznumero			123456789,123456789	#→ 123.456.789,123456789
$ zznumero			1234567890,123456789	#→ 1.234.567.890,123456789
# fracionários negativos (00)
# sempre suprimindo os zeros não significativos.
# $ zznumero			-1,00		#→ -1,00
# $ zznumero			-12,00		#→ -12,00
# $ zznumero			-123,00		#→ -123,00
# $ zznumero			-1234,00	#→ -1.234,00
# $ zznumero			-12345,00	#→ -12.345,00
# $ zznumero			-123456,00	#→ -123.456,00
# $ zznumero			-1234567,00	#→ -1.234.567,00
# $ zznumero			-12345678,00	#→ -12.345.678,00
# $ zznumero			-123456789,00	#→ -123.456.789,00
# $ zznumero			-1234567890,00	#→ -1.234.567.890,00
$ zznumero			-1,00		#→ -1
$ zznumero			-12,00		#→ -12
$ zznumero			-123,00		#→ -123
$ zznumero			-1234,00	#→ -1.234
$ zznumero			-12345,00	#→ -12.345
$ zznumero			-123456,00	#→ -123.456
$ zznumero			-1234567,00	#→ -1.234.567
$ zznumero			-12345678,00	#→ -12.345.678
$ zznumero			-123456789,00	#→ -123.456.789
$ zznumero			-1234567890,00	#→ -1.234.567.890
# fracionários negativos (uma casa)
# XXX o certo é deixar 1 ou 2?
$ zznumero			-1,1		#→ -1,1
$ zznumero			-12,1		#→ -12,1
$ zznumero			-123,1		#→ -123,1
$ zznumero			-1234,1		#→ -1.234,1
$ zznumero			-12345,1	#→ -12.345,1
$ zznumero			-123456,1	#→ -123.456,1
$ zznumero			-1234567,1	#→ -1.234.567,1
$ zznumero			-12345678,1	#→ -12.345.678,1
$ zznumero			-123456789,1	#→ -123.456.789,1
$ zznumero			-1234567890,1	#→ -1.234.567.890,1
# fracionários negativos (duas casas)
$ zznumero			-1,12		#→ -1,12
$ zznumero			-12,12		#→ -12,12
$ zznumero			-123,12		#→ -123,12
$ zznumero			-1234,12	#→ -1.234,12
$ zznumero			-12345,12	#→ -12.345,12
$ zznumero			-123456,12	#→ -123.456,12
$ zznumero			-1234567,12	#→ -1.234.567,12
$ zznumero			-12345678,12	#→ -12.345.678,12
$ zznumero			-123456789,12	#→ -123.456.789,12
$ zznumero			-1234567890,12	#→ -1.234.567.890,12
# fracionários negativos (muitas casas)
# XXX o certo é manter as casas ou deixar 2?
$ zznumero			-1,123456789		#→ -1,123456789
$ zznumero			-12,123456789		#→ -12,123456789
$ zznumero			-123,123456789		#→ -123,123456789
$ zznumero			-1234,123456789		#→ -1.234,123456789
$ zznumero			-12345,123456789	#→ -12.345,123456789
$ zznumero			-123456,123456789	#→ -123.456,123456789
$ zznumero			-1234567,123456789	#→ -1.234.567,123456789
$ zznumero			-12345678,123456789	#→ -12.345.678,123456789
$ zznumero			-123456789,123456789	#→ -123.456.789,123456789
$ zznumero			-1234567890,123456789	#→ -1.234.567.890,123456789
# decimais e fracionários, já pontuados (não altera nada)
$ zznumero			1.234			#→ 1.234
$ zznumero			12.345			#→ 12.345
$ zznumero			123.456			#→ 123.456
$ zznumero			1.234.567		#→ 1.234.567
$ zznumero			12.345.678		#→ 12.345.678
$ zznumero			123.456.789		#→ 123.456.789
$ zznumero			1.234.567.890		#→ 1.234.567.890
$ zznumero			-1.234			#→ -1.234
$ zznumero			-12.345			#→ -12.345
$ zznumero			-123.456		#→ -123.456
$ zznumero			-1.234.567		#→ -1.234.567
$ zznumero			-12.345.678		#→ -12.345.678
$ zznumero			-123.456.789		#→ -123.456.789
$ zznumero			-1.234.567.890		#→ -1.234.567.890
$ zznumero			1.234,12		#→ 1.234,12
$ zznumero			12.345,12		#→ 12.345,12
$ zznumero			123.456,12		#→ 123.456,12
$ zznumero			1.234.567,12		#→ 1.234.567,12
$ zznumero			12.345.678,12		#→ 12.345.678,12
$ zznumero			123.456.789,12		#→ 123.456.789,12
$ zznumero			1.234.567.890,12	#→ 1.234.567.890,12
$ zznumero			-1.234,12		#→ -1.234,12
$ zznumero			-12.345,12		#→ -12.345,12
$ zznumero			-123.456,12		#→ -123.456,12
$ zznumero			-1.234.567,12		#→ -1.234.567,12
$ zznumero			-12.345.678,12		#→ -12.345.678,12
$ zznumero			-123.456.789,12		#→ -123.456.789,12
$ zznumero			-1.234.567.890,12	#→ -1.234.567.890,12


#########################################################################

### Mesmos testes, agora com a opção -m

# Nota: para números monetários negativos, estes são os padrões utilizados:
#
# Google Docs: -R$ 1,23
# LibreOffice: -R$ 1,23
# Excel      : -R$ 1,23
# Numbers    : -R$1,23

# zero
$ zznumero		-m	0		#→ R$ 0,00
$ zznumero		-m	0,00		#→ R$ 0,00
$ zznumero		-m	0,0000		#→ R$ 0,00

# decimais positivos
$ zznumero		-m	1		#→ R$ 1,00
$ zznumero		-m	12		#→ R$ 12,00
$ zznumero		-m	123		#→ R$ 123,00
$ zznumero		-m	1234		#→ R$ 1.234,00
$ zznumero		-m	12345		#→ R$ 12.345,00
$ zznumero		-m	123456		#→ R$ 123.456,00
$ zznumero		-m	1234567		#→ R$ 1.234.567,00
$ zznumero		-m	12345678	#→ R$ 12.345.678,00
$ zznumero		-m	123456789	#→ R$ 123.456.789,00
$ zznumero		-m	1234567890	#→ R$ 1.234.567.890,00
# decimais negativos
$ zznumero		-m	-1		#→ -R$ 1,00
$ zznumero		-m	-12		#→ -R$ 12,00
$ zznumero		-m	-123		#→ -R$ 123,00
$ zznumero		-m	-1234		#→ -R$ 1.234,00
$ zznumero		-m	-12345		#→ -R$ 12.345,00
$ zznumero		-m	-123456		#→ -R$ 123.456,00
$ zznumero		-m	-1234567	#→ -R$ 1.234.567,00
$ zznumero		-m	-12345678	#→ -R$ 12.345.678,00
$ zznumero		-m	-123456789	#→ -R$ 123.456.789,00
$ zznumero		-m	-1234567890	#→ -R$ 1.234.567.890,00
# fracionários positivos (00)
$ zznumero		-m	1,00		#→ R$ 1,00
$ zznumero		-m	12,00		#→ R$ 12,00
$ zznumero		-m	123,00		#→ R$ 123,00
$ zznumero		-m	1234,00		#→ R$ 1.234,00
$ zznumero		-m	12345,00	#→ R$ 12.345,00
$ zznumero		-m	123456,00	#→ R$ 123.456,00
$ zznumero		-m	1234567,00	#→ R$ 1.234.567,00
$ zznumero		-m	12345678,00	#→ R$ 12.345.678,00
$ zznumero		-m	123456789,00	#→ R$ 123.456.789,00
$ zznumero		-m	1234567890,00	#→ R$ 1.234.567.890,00
# fracionários positivos (uma casa)
$ zznumero		-m	1,1		#→ R$ 1,10
$ zznumero		-m	12,1		#→ R$ 12,10
$ zznumero		-m	123,1		#→ R$ 123,10
$ zznumero		-m	1234,1		#→ R$ 1.234,10
$ zznumero		-m	12345,1		#→ R$ 12.345,10
$ zznumero		-m	123456,1	#→ R$ 123.456,10
$ zznumero		-m	1234567,1	#→ R$ 1.234.567,10
$ zznumero		-m	12345678,1	#→ R$ 12.345.678,10
$ zznumero		-m	123456789,1	#→ R$ 123.456.789,10
$ zznumero		-m	1234567890,1	#→ R$ 1.234.567.890,10
# fracionários positivos (duas casas)
$ zznumero		-m	1,12		#→ R$ 1,12
$ zznumero		-m	12,12		#→ R$ 12,12
$ zznumero		-m	123,12		#→ R$ 123,12
$ zznumero		-m	1234,12		#→ R$ 1.234,12
$ zznumero		-m	12345,12	#→ R$ 12.345,12
$ zznumero		-m	123456,12	#→ R$ 123.456,12
$ zznumero		-m	1234567,12	#→ R$ 1.234.567,12
$ zznumero		-m	12345678,12	#→ R$ 12.345.678,12
$ zznumero		-m	123456789,12	#→ R$ 123.456.789,12
$ zznumero		-m	1234567890,12	#→ R$ 1.234.567.890,12
# fracionários positivos (muitas casas)
$ zznumero		-m	1,123456789		#→ R$ 1,12
$ zznumero		-m	12,123456789		#→ R$ 12,12
$ zznumero		-m	123,123456789		#→ R$ 123,12
$ zznumero		-m	1234,123456789		#→ R$ 1.234,12
$ zznumero		-m	12345,123456789		#→ R$ 12.345,12
$ zznumero		-m	123456,123456789	#→ R$ 123.456,12
$ zznumero		-m	1234567,123456789	#→ R$ 1.234.567,12
$ zznumero		-m	12345678,123456789	#→ R$ 12.345.678,12
$ zznumero		-m	123456789,123456789	#→ R$ 123.456.789,12
$ zznumero		-m	1234567890,123456789	#→ R$ 1.234.567.890,12
# fracionários negativos (00)
$ zznumero		-m	-1,00		#→ -R$ 1,00
$ zznumero		-m	-12,00		#→ -R$ 12,00
$ zznumero		-m	-123,00		#→ -R$ 123,00
$ zznumero		-m	-1234,00	#→ -R$ 1.234,00
$ zznumero		-m	-12345,00	#→ -R$ 12.345,00
$ zznumero		-m	-123456,00	#→ -R$ 123.456,00
$ zznumero		-m	-1234567,00	#→ -R$ 1.234.567,00
$ zznumero		-m	-12345678,00	#→ -R$ 12.345.678,00
$ zznumero		-m	-123456789,00	#→ -R$ 123.456.789,00
$ zznumero		-m	-1234567890,00	#→ -R$ 1.234.567.890,00
# fracionários negativos (uma casa)
$ zznumero		-m	-1,1		#→ -R$ 1,10
$ zznumero		-m	-12,1		#→ -R$ 12,10
$ zznumero		-m	-123,1		#→ -R$ 123,10
$ zznumero		-m	-1234,1		#→ -R$ 1.234,10
$ zznumero		-m	-12345,1	#→ -R$ 12.345,10
$ zznumero		-m	-123456,1	#→ -R$ 123.456,10
$ zznumero		-m	-1234567,1	#→ -R$ 1.234.567,10
$ zznumero		-m	-12345678,1	#→ -R$ 12.345.678,10
$ zznumero		-m	-123456789,1	#→ -R$ 123.456.789,10
$ zznumero		-m	-1234567890,1	#→ -R$ 1.234.567.890,10
# fracionários negativos (duas casas)
$ zznumero		-m	-1,12		#→ -R$ 1,12
$ zznumero		-m	-12,12		#→ -R$ 12,12
$ zznumero		-m	-123,12		#→ -R$ 123,12
$ zznumero		-m	-1234,12	#→ -R$ 1.234,12
$ zznumero		-m	-12345,12	#→ -R$ 12.345,12
$ zznumero		-m	-123456,12	#→ -R$ 123.456,12
$ zznumero		-m	-1234567,12	#→ -R$ 1.234.567,12
$ zznumero		-m	-12345678,12	#→ -R$ 12.345.678,12
$ zznumero		-m	-123456789,12	#→ -R$ 123.456.789,12
$ zznumero		-m	-1234567890,12	#→ -R$ 1.234.567.890,12
# fracionários negativos (muitas casas)
$ zznumero		-m	-1,123456789		#→ -R$ 1,12
$ zznumero		-m	-12,123456789		#→ -R$ 12,12
$ zznumero		-m	-123,123456789		#→ -R$ 123,12
$ zznumero		-m	-1234,123456789		#→ -R$ 1.234,12
$ zznumero		-m	-12345,123456789	#→ -R$ 12.345,12
$ zznumero		-m	-123456,123456789	#→ -R$ 123.456,12
$ zznumero		-m	-1234567,123456789	#→ -R$ 1.234.567,12
$ zznumero		-m	-12345678,123456789	#→ -R$ 12.345.678,12
$ zznumero		-m	-123456789,123456789	#→ -R$ 123.456.789,12
$ zznumero		-m	-1234567890,123456789	#→ -R$ 1.234.567.890,12
# decimais e fracionários, já pontuados (não altera nada)
# No caso uso da opção -m, sempre será 2 casas decimais
# $ zznumero		-m	1.234			#→ R$ 1.234
# $ zznumero		-m	12.345			#→ R$ 12.345
# $ zznumero		-m	123.456			#→ R$ 123.456
# $ zznumero		-m	1.234.567		#→ R$ 1.234.567
# $ zznumero		-m	12.345.678		#→ R$ 12.345.678
# $ zznumero		-m	123.456.789		#→ R$ 123.456.789
# $ zznumero		-m	1.234.567.890		#→ R$ 1.234.567.890
# $ zznumero		-m	-1.234			#→ -R$ 1.234
# $ zznumero		-m	-12.345			#→ -R$ 12.345
# $ zznumero		-m	-123.456		#→ -R$ 123.456
# $ zznumero		-m	-1.234.567		#→ -R$ 1.234.567
# $ zznumero		-m	-12.345.678		#→ -R$ 12.345.678
# $ zznumero		-m	-123.456.789		#→ -R$ 123.456.789
# $ zznumero		-m	-1.234.567.890		#→ -R$ 1.234.567.890
$ zznumero		-m	1.234			#→ R$ 1.234,00
$ zznumero		-m	12.345			#→ R$ 12.345,00
$ zznumero		-m	123.456			#→ R$ 123.456,00
$ zznumero		-m	1.234.567		#→ R$ 1.234.567,00
$ zznumero		-m	12.345.678		#→ R$ 12.345.678,00
$ zznumero		-m	123.456.789		#→ R$ 123.456.789,00
$ zznumero		-m	1.234.567.890		#→ R$ 1.234.567.890,00
$ zznumero		-m	-1.234			#→ -R$ 1.234,00
$ zznumero		-m	-12.345			#→ -R$ 12.345,00
$ zznumero		-m	-123.456		#→ -R$ 123.456,00
$ zznumero		-m	-1.234.567		#→ -R$ 1.234.567,00
$ zznumero		-m	-12.345.678		#→ -R$ 12.345.678,00
$ zznumero		-m	-123.456.789		#→ -R$ 123.456.789,00
$ zznumero		-m	-1.234.567.890		#→ -R$ 1.234.567.890,00
$ zznumero		-m	1.234,12		#→ R$ 1.234,12
$ zznumero		-m	12.345,12		#→ R$ 12.345,12
$ zznumero		-m	123.456,12		#→ R$ 123.456,12
$ zznumero		-m	1.234.567,12		#→ R$ 1.234.567,12
$ zznumero		-m	12.345.678,12		#→ R$ 12.345.678,12
$ zznumero		-m	123.456.789,12		#→ R$ 123.456.789,12
$ zznumero		-m	1.234.567.890,12	#→ R$ 1.234.567.890,12
$ zznumero		-m	-1.234,12		#→ -R$ 1.234,12
$ zznumero		-m	-12.345,12		#→ -R$ 12.345,12
$ zznumero		-m	-123.456,12		#→ -R$ 123.456,12
$ zznumero		-m	-1.234.567,12		#→ -R$ 1.234.567,12
$ zznumero		-m	-12.345.678,12		#→ -R$ 12.345.678,12
$ zznumero		-m	-123.456.789,12		#→ -R$ 123.456.789,12
$ zznumero		-m	-1.234.567.890,12	#→ -R$ 1.234.567.890,12

# Arredondamento
$ zznumero		-m	1,234			#→ R$ 1,23
$ zznumero		-m	1,235			#→ R$ 1,24
$ zznumero		-m	1,236			#→ R$ 1,24

# opção -t
$ zznumero		-t	1		#→ 1
$ zznumero		-t	12		#→ 12
$ zznumero		-t	123		#→ 123
$ zznumero		-t	1234		#→ 1 mil 234
$ zznumero		-t	12345		#→ 12 mil 345
$ zznumero		-t	123456		#→ 123 mil 456
$ zznumero		-t	1234567		#→ 1 milhão 234 mil 567
$ zznumero		-t	12345678	#→ 12 milhões 345 mil 678
$ zznumero		-t	123456789	#→ 123 milhões 456 mil 789
$ zznumero		-t	1234567890	#→ 1 bilhão 234 milhões 567 mil 890
$ zznumero		-t	12345678901	#→ 12 bilhões 345 milhões 678 mil 901
$ zznumero		-t	123456789012	#→ 123 bilhões 456 milhões 789 mil 12
$ zznumero		-t	1234567890123	#→ 1 trilhão 234 bilhões 567 milhões 890 mil 123
$ zznumero		-t	12345678901234	#→ 12 trilhões 345 bilhões 678 milhões 901 mil 234
# $ zznumero		-t	-1		#→ -1
$ zznumero		-t	-1		#→ 1 negativo
$ zznumero		-t	+1		#→ 1 positivo
$ zznumero		-t	0		#→ 0
$ zznumero		-t	-0		#→ 0
$ zznumero		-t	+0		#→ 0
$ zznumero		-t	9		#→ 9
$ zznumero		-t	10		#→ 10
$ zznumero		-t	11		#→ 11
$ zznumero		-t	99		#→ 99
$ zznumero		-t	100		#→ 100
$ zznumero		-t	101		#→ 101
$ zznumero		-t	999		#→ 999
$ zznumero		-t	1000		#→ 1 mil
$ zznumero		-t	1001		#→ 1 mil 1
$ zznumero		-t	1099		#→ 1 mil 99
$ zznumero		-t	1100		#→ 1 mil 100
$ zznumero		-t	1101		#→ 1 mil 101
$ zznumero		-t	9999		#→ 9 mil 999
$ zznumero		-t	10000		#→ 10 mil
$ zznumero		-t	10001		#→ 10 mil 1
$ zznumero		-t	99999		#→ 99 mil 999
$ zznumero		-t	100000		#→ 100 mil
$ zznumero		-t	100001		#→ 100 mil 1
$ zznumero		-t	999999		#→ 999 mil 999
$ zznumero		-t	1000000		#→ 1 milhão
$ zznumero		-t	1100100		#→ 1 milhão 100 mil 100
$ zznumero		-t	9999999		#→ 9 milhões 999 mil 999

### opção --texto
#
# Tabela padrão
$ zznumero		--texto	1	#→ um
$ zznumero		--texto	2	#→ dois
$ zznumero		--texto	3	#→ três
$ zznumero		--texto	4	#→ quatro
$ zznumero		--texto	5	#→ cinco
$ zznumero		--texto	6	#→ seis
$ zznumero		--texto	7	#→ sete
$ zznumero		--texto	8	#→ oito
$ zznumero		--texto	9	#→ nove
$ zznumero		--texto	10	#→ dez
$ zznumero		--texto	11	#→ onze
$ zznumero		--texto	12	#→ doze
$ zznumero		--texto	13	#→ treze
$ zznumero		--texto	14	#→ catorze
$ zznumero		--texto	15	#→ quinze
$ zznumero		--texto	16	#→ dezesseis
$ zznumero		--texto	17	#→ dezessete
$ zznumero		--texto	18	#→ dezoito
$ zznumero		--texto	19	#→ dezenove
$ zznumero		--texto	20	#→ vinte
$ zznumero		--texto	30	#→ trinta
$ zznumero		--texto	40	#→ quarenta
$ zznumero		--texto	50	#→ cinquenta
$ zznumero		--texto	60	#→ sessenta
$ zznumero		--texto	70	#→ setenta
$ zznumero		--texto	80	#→ oitenta
$ zznumero		--texto	90	#→ noventa
$ zznumero		--texto	100	#→ cem
$ zznumero		--texto	200	#→ duzentos
$ zznumero		--texto	300	#→ trezentos
$ zznumero		--texto	400	#→ quatrocentos
$ zznumero		--texto	500	#→ quinhentos
$ zznumero		--texto	600	#→ seiscentos
$ zznumero		--texto	700	#→ setecentos
$ zznumero		--texto	800	#→ oitocentos
$ zznumero		--texto	900	#→ novecentos

$ zznumero		--texto	1.000  #→ mil
$ zznumero		--texto	1.000.000  #→ um milhão
$ zznumero		--texto	1.000.000.000  #→ um bilhão
$ zznumero		--texto	1.000.000.000.000  #→ um trilhão
$ zznumero		--texto	1.000.000.000.000.000  #→ um quadrilhão
$ zznumero		--texto	1.000.000.000.000.000.000  #→ um quintilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000  #→ um sextilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000  #→ um septilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000  #→ um octilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000  #→ um nonilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000  #→ um decilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000  #→ um undecilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ um duodecilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ um tredecilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ um quattuordecilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ um quindecilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ um sexdecilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ um septendecilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ um octodecilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ um novendecilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ um vigintilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ um unvigintilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ um douvigintilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ um tresvigintilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ um quatrivigintilhão
$ zznumero		--texto	1.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ um quinquavigintilhão
$ zznumero		--texto	2.000  #→ dois mil
$ zznumero		--texto	2.000.000  #→ dois milhões
$ zznumero		--texto	2.000.000.000  #→ dois bilhões
$ zznumero		--texto	2.000.000.000.000  #→ dois trilhões
$ zznumero		--texto	2.000.000.000.000.000  #→ dois quadrilhões
$ zznumero		--texto	2.000.000.000.000.000.000  #→ dois quintilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000  #→ dois sextilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000  #→ dois septilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000  #→ dois octilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000  #→ dois nonilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000  #→ dois decilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois undecilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois duodecilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois tredecilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois quattuordecilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois quindecilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois sexdecilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois septendecilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois octodecilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois novendecilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois vigintilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois unvigintilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois douvigintilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois tresvigintilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois quatrivigintilhões
$ zznumero		--texto	2.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000.000  #→ dois quinquavigintilhões

# Ordens de grandeza
$ zznumero		--texto	1		#→ um
$ zznumero		--texto	12		#→ doze
$ zznumero		--texto	123		#→ cento e vinte e três
$ zznumero		--texto	1234		#→ mil duzentos e trinta e quatro
$ zznumero		--texto	12345		#→ doze mil trezentos e quarenta e cinco
$ zznumero		--texto	123456		#→ cento e vinte e três mil quatrocentos e cinquenta e seis
$ zznumero		--texto	1234567		#→ um milhão, duzentos e trinta e quatro mil quinhentos e sessenta e sete
$ zznumero		--texto	12345678	#→ doze milhões, trezentos e quarenta e cinco mil seiscentos e setenta e oito
$ zznumero		--texto	123456789	#→ cento e vinte e três milhões, quatrocentos e cinquenta e seis mil setecentos e oitenta e nove
$ zznumero		--texto	1234567890	#→ um bilhão, duzentos e trinta e quatro milhões, quinhentos e sessenta e sete mil oitocentos e noventa
$ zznumero		--texto	12345678901	#→ doze bilhões, trezentos e quarenta e cinco milhões, seiscentos e setenta e oito mil novecentos e um
$ zznumero		--texto	123456789012	#→ cento e vinte e três bilhões, quatrocentos e cinquenta e seis milhões, setecentos e oitenta e nove mil e doze
$ zznumero		--texto	1234567890123	#→ um trilhão, duzentos e trinta e quatro bilhões, quinhentos e sessenta e sete milhões, oitocentos e noventa mil cento e vinte e três
$ zznumero		--texto	12345678901234	#→ doze trilhões, trezentos e quarenta e cinco bilhões, seiscentos e setenta e oito milhões, novecentos e um mil duzentos e trinta e quatro

# Pontos de mudança de ordem
$ zznumero		--texto	-1		#→ um negativo
$ zznumero		--texto	0		#→ zero
$ zznumero		--texto	9		#→ nove
$ zznumero		--texto	10		#→ dez
$ zznumero		--texto	11		#→ onze
$ zznumero		--texto	99		#→ noventa e nove
$ zznumero		--texto	100		#→ cem
$ zznumero		--texto	101		#→ cento e um
$ zznumero		--texto	999		#→ novecentos e noventa e nove
$ zznumero		--texto	1000		#→ mil
$ zznumero		--texto	1001		#→ mil e um
$ zznumero		--texto	1099		#→ mil e noventa e nove
$ zznumero		--texto	1100		#→ mil e cem
$ zznumero		--texto	1101		#→ mil cento e um
$ zznumero		--texto	9999		#→ nove mil novecentos e noventa e nove
$ zznumero		--texto	10000		#→ dez mil
$ zznumero		--texto	10001		#→ dez mil e um
$ zznumero		--texto	99999		#→ noventa e nove mil novecentos e noventa e nove
$ zznumero		--texto	100000		#→ cem mil
$ zznumero		--texto	100001		#→ cem mil e um
$ zznumero		--texto	999999		#→ novecentos e noventa e nove mil novecentos e noventa e nove
$ zznumero		--texto	1000000		#→ um milhão
# Esse é um caso a ser pensado sobre a forma correta.
# $ zznumero		--texto	1100100		#→ um milhão e cem mil e cem
$ zznumero		--texto	1100100		#→ um milhão, cem mil e cem
$ zznumero		--texto	9999999		#→ nove milhões, novecentos e noventa e nove mil novecentos e noventa e nove

# Exemplos do guia do Estadão
$ zznumero		--texto	28		#→ vinte e oito
$ zznumero		--texto	54		#→ cinquenta e quatro
$ zznumero		--texto	348		#→ trezentos e quarenta e oito
$ zznumero		--texto	824		#→ oitocentos e vinte e quatro
#
$ zznumero		--texto	1.409		#→ mil quatrocentos e nove
$ zznumero		--texto	1.200		#→ mil e duzentos
$ zznumero		--texto	7.816		#→ sete mil oitocentos e dezesseis
$ zznumero		--texto	18.100		#→ dezoito mil e cem
$ zznumero		--texto	184.910		#→ cento e oitenta e quatro mil novecentos e dez
#
$ zznumero		--texto	142.387		#→ cento e quarenta e dois mil trezentos e oitenta e sete
$ zznumero		--texto	856.672.549	#→ oitocentos e cinquenta e seis milhões, seiscentos e setenta e dois mil quinhentos e quarenta e nove
$ zznumero		--texto	765.432.854.987	#→ setecentos e sessenta e cinco bilhões, quatrocentos e trinta e dois milhões, oitocentos e cinquenta e quatro mil novecentos e oitenta e sete

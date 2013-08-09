$ zztool uso zztool			#→ Uso: zztool [-e] ferramenta [argumentos]
$ zztool index_var tan testando		#→ 4
$ zztool arquivo_vago _dados.txt	#→ Arquivo _dados.txt já existe. Abortando.
$ zztool arquivo_legivel _fake_		#→ Não consegui ler o arquivo _fake_

# eco

$ ZZCOR=0
$ zztool eco testando		#→ testando
$ ZZCOR=1
$ zztool eco testando		#→ [36;1mtestando[m

# acha

$ zztool acha tan testando	#→ tes[36;1mtan[mdo
$ ZZCOR=0
$

# grep_var

$ zztool grep_var ana banana		; echo $?  #→ 0
$ zztool grep_var XXX banana		; echo $?  #→ 1

# testa_numero

$ zztool testa_numero 9			; echo $?  #→ 0
$ zztool testa_numero 9999		; echo $?  #→ 0
$ zztool testa_numero XXX		; echo $?  #→ 1
$ zztool testa_numero -9		; echo $?  #→ 1

# testa_numero_sinal

$ zztool testa_numero_sinal 9		; echo $?  #→ 0
$ zztool testa_numero_sinal 9999	; echo $?  #→ 0
$ zztool testa_numero_sinal +9999	; echo $?  #→ 0
$ zztool testa_numero_sinal -9999	; echo $?  #→ 0
$ zztool testa_numero_sinal XXX		; echo $?  #→ 1
$ zztool testa_numero_sinal 9.9		; echo $?  #→ 1
$ zztool testa_numero_sinal ++9		; echo $?  #→ 1

# testa_numero_fracionario

$ zztool testa_numero_fracionario 0,0		; echo $?  #→ 0
$ zztool testa_numero_fracionario 0,00		; echo $?  #→ 0
$ zztool testa_numero_fracionario 0,000		; echo $?  #→ 0
$ zztool testa_numero_fracionario 0,0000	; echo $?  #→ 0
$ zztool testa_numero_fracionario 0,00000	; echo $?  #→ 0
$ zztool testa_numero_fracionario 00,0		; echo $?  #→ 0
$ zztool testa_numero_fracionario 000,0		; echo $?  #→ 0
$ zztool testa_numero_fracionario 0000,0	; echo $?  #→ 0
$ zztool testa_numero_fracionario 00000,0	; echo $?  #→ 0
$ zztool testa_numero_fracionario 0.0		; echo $?  #→ 0
$ zztool testa_numero_fracionario 000.000	; echo $?  #→ 0
$ zztool testa_numero_fracionario XXX		; echo $?  #→ 1
$ zztool testa_numero_fracionario -9.9		; echo $?  #→ 1
$ zztool testa_numero_fracionario +9.9		; echo $?  #→ 1
$ zztool testa_numero_fracionario 9		; echo $?  #→ 1
$ zztool testa_numero_fracionario +9		; echo $?  #→ 1
$ zztool testa_numero_fracionario -9		; echo $?  #→ 1
$ zztool testa_numero_fracionario ,9		; echo $?  #→ 1
$ zztool testa_numero_fracionario .9		; echo $?  #→ 1

# testa_dinheiro

$ zztool testa_dinheiro 0,00			; echo $?  #→ 0
$ zztool testa_dinheiro 00,00			; echo $?  #→ 0
$ zztool testa_dinheiro 000,00			; echo $?  #→ 0
$ zztool testa_dinheiro 0.000,00		; echo $?  #→ 0
$ zztool testa_dinheiro 00.000,00		; echo $?  #→ 0
$ zztool testa_dinheiro 000.000,00		; echo $?  #→ 0
$ zztool testa_dinheiro 0.000.000,00		; echo $?  #→ 0
$ zztool testa_dinheiro 00.000.000,00		; echo $?  #→ 0
$ zztool testa_dinheiro 000.000.000,00		; echo $?  #→ 0
$ zztool testa_dinheiro 0.000.000.000,00	; echo $?  #→ 0
$ zztool testa_dinheiro 00.000.000.000,00	; echo $?  #→ 0
$ zztool testa_dinheiro 000.000.000.000,00	; echo $?  #→ 0
$ zztool testa_dinheiro 0000,00			; echo $?  #→ 0
$ zztool testa_dinheiro 000000,00		; echo $?  #→ 0
$ zztool testa_dinheiro 00000000,00		; echo $?  #→ 0

# testa_dinheiro: centavos errados

$ zztool testa_dinheiro 0,0		; echo $?  #→ 1
$ zztool testa_dinheiro 0,000		; echo $?  #→ 1

# testa_dinheiro: ponto colocado errado

$ zztool testa_dinheiro 0.0,00		; echo $?  #→ 1
$ zztool testa_dinheiro 0000.0,00	; echo $?  #→ 1
$ zztool testa_dinheiro 0.0.000,00	; echo $?  #→ 1
$ zztool testa_dinheiro 0.00.000,00	; echo $?  #→ 1
$ zztool testa_dinheiro 000.00.000,00	; echo $?  #→ 1
$ zztool testa_dinheiro 0.000.0000,00	; echo $?  #→ 1
$ zztool testa_dinheiro 0.,00		; echo $?  #→ 1
$ zztool testa_dinheiro 0.0,00		; echo $?  #→ 1
$ zztool testa_dinheiro 0.00,00		; echo $?  #→ 1
$ zztool testa_dinheiro 0.0000,00	; echo $?  #→ 1
$ zztool testa_dinheiro .000,00		; echo $?  #→ 1
$ zztool testa_dinheiro 0000.000,00	; echo $?  #→ 1
$ zztool testa_dinheiro 0.0000.000,00	; echo $?  #→ 1

# testa_dinheiro: outros

$ zztool testa_dinheiro XXX		; echo $?  #→ 1
$ zztool testa_dinheiro 9		; echo $?  #→ 1
$ zztool testa_dinheiro +9		; echo $?  #→ 1
$ zztool testa_dinheiro :9		; echo $?  #→ 1
$ zztool testa_dinheiro ,9		; echo $?  #→ 1
$ zztool testa_dinheiro .9		; echo $?  #→ 1

# testa_binario

$ zztool testa_binario 0		; echo $?  #→ 0
$ zztool testa_binario 1		; echo $?  #→ 0
$ zztool testa_binario 0000		; echo $?  #→ 0
$ zztool testa_binario 0110		; echo $?  #→ 0
$ zztool testa_binario 2		; echo $?  #→ 1
$ zztool testa_binario +010		; echo $?  #→ 1
$ zztool testa_binario -010		; echo $?  #→ 1

# testa_ip

$ zztool testa_ip 0.0.0.0		; echo $?  #→ 0
$ zztool testa_ip 99.99.99.99		; echo $?  #→ 0
$ zztool testa_ip 255.255.255.255	; echo $?  #→ 0
$ zztool testa_ip 1.11.111.0		; echo $?  #→ 0
$ zztool testa_ip 0.99.100.199		; echo $?  #→ 0
$ zztool testa_ip 200.249.250.255	; echo $?  #→ 0
$ zztool testa_ip 000.000.000.000	; echo $?  #→ 1
$ zztool testa_ip 256.256.256.256	; echo $?  #→ 1
$ zztool testa_ip 999.999.999.999	; echo $?  #→ 1
$ zztool testa_ip 0000.0000.0000.0000	; echo $?  #→ 1
$ zztool testa_ip 0.0.0			; echo $?  #→ 1
$ zztool testa_ip 0.0			; echo $?  #→ 1
$ zztool testa_ip 0			; echo $?  #→ 1

# testa_ano: 1-9999

$ zztool testa_ano -1000		; echo $?  #→ 1
$ zztool testa_ano -1			; echo $?  #→ 1
$ zztool testa_ano 0			; echo $?  #→ 1
$ zztool testa_ano 1			; echo $?  #→ 0
$ zztool testa_ano 10			; echo $?  #→ 0
$ zztool testa_ano 100			; echo $?  #→ 0
$ zztool testa_ano 1000			; echo $?  #→ 0
$ zztool testa_ano 2000			; echo $?  #→ 0
$ zztool testa_ano 9999			; echo $?  #→ 0
$ zztool testa_ano 99999		; echo $?  #→ 1

# testa_ano: padding

$ zztool testa_ano 0001			; echo $?  #→ 0
$ zztool testa_ano 001			; echo $?  #→ 0
$ zztool testa_ano 01			; echo $?  #→ 0

# testa_data: o ano é livre

$ zztool testa_data 01/01/0		; echo $?  #→ 0
$ zztool testa_data 01/01/1		; echo $?  #→ 0
$ zztool testa_data 01/01/10		; echo $?  #→ 0
$ zztool testa_data 01/01/100		; echo $?  #→ 0
$ zztool testa_data 01/01/1000		; echo $?  #→ 0
$ zztool testa_data 01/01/2000		; echo $?  #→ 0
$ zztool testa_data 01/01/9999		; echo $?  #→ 0

# testa_data: limites mensais

$ zztool testa_data 31/01/2000		; echo $?  #→ 0
$ zztool testa_data 29/02/2000		; echo $?  #→ 0
$ zztool testa_data 31/03/2000		; echo $?  #→ 0
$ zztool testa_data 30/04/2000		; echo $?  #→ 0
$ zztool testa_data 31/05/2000		; echo $?  #→ 0
$ zztool testa_data 30/06/2000		; echo $?  #→ 0
$ zztool testa_data 31/07/2000		; echo $?  #→ 0
$ zztool testa_data 31/08/2000		; echo $?  #→ 0
$ zztool testa_data 30/09/2000		; echo $?  #→ 0
$ zztool testa_data 31/10/2000		; echo $?  #→ 0
$ zztool testa_data 30/11/2000		; echo $?  #→ 0
$ zztool testa_data 31/12/2000		; echo $?  #→ 0

# testa_data: datas com um dígito no dia ou mês são proibidas

$ zztool testa_data 1/01/2000		; echo $?  #→ 1
$ zztool testa_data 5/05/2000		; echo $?  #→ 1
$ zztool testa_data 9/09/2000		; echo $?  #→ 1
$ zztool testa_data 01/1/2000		; echo $?  #→ 1
$ zztool testa_data 05/5/2000		; echo $?  #→ 1
$ zztool testa_data 09/9/2000		; echo $?  #→ 1
$ zztool testa_data 1/1/2000		; echo $?  #→ 1
$ zztool testa_data 5/5/2000		; echo $?  #→ 1
$ zztool testa_data 9/9/2000		; echo $?  #→ 1

# testa_data: data fora do limite

$ zztool testa_data 32/01/2000		; echo $?  #→ 1
$ zztool testa_data 30/02/2000		; echo $?  #→ 1
$ zztool testa_data 32/03/2000		; echo $?  #→ 1
$ zztool testa_data 31/04/2000		; echo $?  #→ 1
$ zztool testa_data 32/05/2000		; echo $?  #→ 1
$ zztool testa_data 31/06/2000		; echo $?  #→ 1
$ zztool testa_data 32/07/2000		; echo $?  #→ 1
$ zztool testa_data 32/08/2000		; echo $?  #→ 1
$ zztool testa_data 31/09/2000		; echo $?  #→ 1
$ zztool testa_data 32/10/2000		; echo $?  #→ 1
$ zztool testa_data 31/11/2000		; echo $?  #→ 1
$ zztool testa_data 32/12/2000		; echo $?  #→ 1
$ zztool testa_data 39/01/2000		; echo $?  #→ 1
$ zztool testa_data 01/13/2000		; echo $?  #→ 1
$ zztool testa_data 01/19/2000		; echo $?  #→ 1
$ zztool testa_data 00/01/2000		; echo $?  #→ 1
$ zztool testa_data 01/00/2000		; echo $?  #→ 1
$ zztool testa_data 99/99/2000		; echo $?  #→ 1

# testa_data: não pega datas parciais

$ zztool testa_data 31/12		; echo $?  #→ 1
$ zztool testa_data 931/12/2000		; echo $?  #→ 1
$ zztool testa_data +31/12/2000		; echo $?  #→ 1
$ zztool testa_data 31/12/2000+		; echo $?  #→ 1
$ zztool testa_data +31/12/2000+	; echo $?  #→ 1

# testa_hora

$ zztool testa_hora  0:00		; echo $?  #→ 0
$ zztool testa_hora  1:01		; echo $?  #→ 0
$ zztool testa_hora  2:02		; echo $?  #→ 0
$ zztool testa_hora  3:03		; echo $?  #→ 0
$ zztool testa_hora  4:04		; echo $?  #→ 0
$ zztool testa_hora  5:05		; echo $?  #→ 0
$ zztool testa_hora  6:06		; echo $?  #→ 0
$ zztool testa_hora  7:07		; echo $?  #→ 0
$ zztool testa_hora  8:08		; echo $?  #→ 0
$ zztool testa_hora  9:09		; echo $?  #→ 0
$ zztool testa_hora 00:00		; echo $?  #→ 0
$ zztool testa_hora 01:01		; echo $?  #→ 0
$ zztool testa_hora 02:02		; echo $?  #→ 0
$ zztool testa_hora 03:03		; echo $?  #→ 0
$ zztool testa_hora 04:04		; echo $?  #→ 0
$ zztool testa_hora 05:05		; echo $?  #→ 0
$ zztool testa_hora 06:06		; echo $?  #→ 0
$ zztool testa_hora 07:07		; echo $?  #→ 0
$ zztool testa_hora 08:08		; echo $?  #→ 0
$ zztool testa_hora 09:09		; echo $?  #→ 0
$ zztool testa_hora 10:10		; echo $?  #→ 0
$ zztool testa_hora 11:11		; echo $?  #→ 0
$ zztool testa_hora 12:12		; echo $?  #→ 0
$ zztool testa_hora 13:13		; echo $?  #→ 0
$ zztool testa_hora 14:14		; echo $?  #→ 0
$ zztool testa_hora 15:15		; echo $?  #→ 0
$ zztool testa_hora 16:16		; echo $?  #→ 0
$ zztool testa_hora 17:17		; echo $?  #→ 0
$ zztool testa_hora 18:18		; echo $?  #→ 0
$ zztool testa_hora 19:19		; echo $?  #→ 0
$ zztool testa_hora 20:20		; echo $?  #→ 0
$ zztool testa_hora 21:21		; echo $?  #→ 0
$ zztool testa_hora 22:22		; echo $?  #→ 0
$ zztool testa_hora 23:23		; echo $?  #→ 0
$ zztool testa_hora 23:59		; echo $?  #→ 0
$ zztool testa_hora 24:00		; echo $?  #→ 1
$ zztool testa_hora 24:59		; echo $?  #→ 1
$ zztool testa_hora  4:60		; echo $?  #→ 1
$ zztool testa_hora  4:99		; echo $?  #→ 1
$ zztool testa_hora 99:99		; echo $?  #→ 1

# testa_hora: não pega horas parciais

$ zztool testa_hora 911:11		; echo $?  #→ 1
$ zztool testa_hora 11:119		; echo $?  #→ 1
$ zztool testa_hora 911:119		; echo $?  #→ 1

# testa_hora: delimitador (com ou sem)

$ zztool testa_hora 2359		; echo $?  #→ 1
$ zztool testa_hora :			; echo $?  #→ 1

# trim

$ zztool trim '   testando   '	#→ testando

# endereco_sed

$ zztool endereco_sed $		#→ $
$ zztool endereco_sed 0		#→ 0
$ zztool endereco_sed 1		#→ 1
$ zztool endereco_sed 99	#→ 99
$ zztool endereco_sed 999	#→ 999
$ zztool endereco_sed -1	#→ /-1/
$ zztool endereco_sed a$	#→ /a$/
$ zztool endereco_sed a		#→ /a/
$ zztool endereco_sed ^a.*$	#→ /^a.*$/
$ zztool endereco_sed /		#→ /\//
$ zztool endereco_sed /a/	#→ /\/a\//
$ zztool endereco_sed /a/b/c	#→ /\/a\/b\/c/
$ zztool endereco_sed 'a b c'	#→ /a b c/

# multi_stdin

$ echo ok | zztool multi_stdin
ok
$ zztool multi_stdin ok
ok
$

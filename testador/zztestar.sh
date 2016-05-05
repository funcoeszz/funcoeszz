$ zztestar ano 2012; echo $?	#→ 0
$ zztestar ano 0000; echo $?	#→ 1
$ zztestar bissexto 2016; echo $?	#→ 0
$ zztestar bissexto 2014; echo $?	#→ 1
$ zztestar exp -4,726e-3; echo $?	#→ 0
$ zztestar exp 2.368E12; echo $?	#→ 0
$ zztestar exp 53,95e-7; echo $?	#→ 0
$ zztestar exp 9,1; echo $?	#→ 1
$ zztestar exp 8e7.83; echo $?	#→ 1
$ zztestar natural 77; echo $?	#→ 0
$ zztestar natural -2; echo $?	#→ 1
$ zztestar inteiro -2; echo $?	#→ 0
$ zztestar inteiro 6.3; echo $?	#→ 1
$ zztestar real 3.8501; echo $?	#→ 0
$ zztestar real -1,941; echo $?	#→ 0
$ zztestar real 789026; echo $?	#→ 0
$ zztestar dinheiro 6,55; echo $?	#→ 0
$ zztestar dinheiro 1.34; echo $?	#→ 1
$ zztestar dinheiro -12,06; echo $?	#→ 0
$ zztestar dinheiro 2,3756; echo $?	#→ 1
$ zztestar dinheiro 9,6; echo $?	#→ 1
$ zztestar bin 010011100; echo $?	#→ 0
$ zztestar bin 10012001; echo $?	#→ 1
$ zztestar octal 7502; echo $?	#→ 0
$ zztestar octal 29; echo $?	#→ 1
$ zztestar hexa 85a3; echo $?	#→ 0
$ zztestar hexa 0db8; echo $?	#→ 0
$ zztestar hexa fe32; echo $?	#→ 0
$ zztestar hexa 5dg8; echo $?	#→ 1
$ zztestar hexa 456i; echo $?	#→ 1
$ zztestar ip 192.168.0.32; echo $?	#→ 0
$ zztestar ip 127.0.0.1; echo $?	#→ 0
$ zztestar ip 208.80.152.130; echo $?	#→ 0
$ zztestar ip 172.31.255.255; echo $?	#→ 0
$ zztestar ip 192.168.0.434; echo $?	#→ 1
$ zztestar ip6 2001:bce4:5641:3412:341:45ae:fe32:65; echo $?	#→ 0
$ zztestar ip6 :5641:3412:341:45ae:fe32:65; echo $?	#→ 1
$ zztestar ip6 2001:bce4:0:0:0:0:0:1; echo $?	#→ 0
$ zztestar ip6 2001:bce4::1; echo $?	#→ 0
$ zztestar ip6 2001:bce4:::1; echo $?	#→ 1
$ zztestar ip6 2001:bce4::1:; echo $?	#→ 1
$ zztestar ip6 fee::2; echo $?	#→ 0
$ zztestar mac 00:19:B9:FB:E2:57; echo $?	#→ 0
$ zztestar mac 00-88-14-4D-4C-FB; echo $?	#→ 0
$ zztestar mac 00:1D:7D:B2:34:F9; echo $?	#→ 0
$ zztestar mac 00-0C-6E-3C-D1-6D; echo $?	#→ 0
$ zztestar data 31/12/2010; echo $?	#→ 0
$ zztestar data 29/02/2000; echo $?	#→ 0
$ zztestar data 21-12-2012; echo $?	#→ 1
$ zztestar hora 13:37; echo $?	#→ 0
$ zztestar hora 22:63; echo $?	#→ 1
$ zztestar hora 16:06; echo $?	#→ 0
$ zztestar complexo 83.7+12.2i; echo $?	#→ 0
$ zztestar complexo 3,5i; echo $?	#→ 0
$ zztestar complexo 144; echo $?	#→ 1

# testa_numero

$ zztestar numero 9			; echo $?  #→ 0
$ zztestar numero 9999		; echo $?  #→ 0
$ zztestar numero XXX		; echo $?  #→ 1
$ zztestar numero -9		; echo $?  #→ 1

# testa_numero_sinal

$ zztestar numero_sinal 9		; echo $?  #→ 0
$ zztestar numero_sinal 9999	; echo $?  #→ 0
$ zztestar numero_sinal +9999	; echo $?  #→ 0
$ zztestar numero_sinal -9999	; echo $?  #→ 0
$ zztestar numero_sinal XXX		; echo $?  #→ 1
$ zztestar numero_sinal 9.9		; echo $?  #→ 1
$ zztestar numero_sinal ++9		; echo $?  #→ 1

# testa_numero_fracionario

$ zztestar numero_fracionario 0,0		; echo $?  #→ 0
$ zztestar numero_fracionario 0,00		; echo $?  #→ 0
$ zztestar numero_fracionario 0,000		; echo $?  #→ 0
$ zztestar numero_fracionario 0,0000	; echo $?  #→ 0
$ zztestar numero_fracionario 0,00000	; echo $?  #→ 0
$ zztestar numero_fracionario 00,0		; echo $?  #→ 0
$ zztestar numero_fracionario 000,0		; echo $?  #→ 0
$ zztestar numero_fracionario 0000,0	; echo $?  #→ 0
$ zztestar numero_fracionario 00000,0	; echo $?  #→ 0
$ zztestar numero_fracionario 0.0		; echo $?  #→ 0
$ zztestar numero_fracionario 000.000	; echo $?  #→ 0
$ zztestar numero_fracionario XXX		; echo $?  #→ 1
$ zztestar numero_fracionario -9.9		; echo $?  #→ 0
$ zztestar numero_fracionario +9.9		; echo $?  #→ 0
$ zztestar numero_fracionario 9		; echo $?  #→ 0
$ zztestar numero_fracionario +9		; echo $?  #→ 0
$ zztestar numero_fracionario -9		; echo $?  #→ 0
$ zztestar numero_fracionario ,9		; echo $?  #→ 0
$ zztestar numero_fracionario .9		; echo $?  #→ 0

# testa_dinheiro

$ zztestar dinheiro 0,00			; echo $?  #→ 0
$ zztestar dinheiro 00,00			; echo $?  #→ 0
$ zztestar dinheiro 000,00			; echo $?  #→ 0
$ zztestar dinheiro 0.000,00		; echo $?  #→ 0
$ zztestar dinheiro 00.000,00		; echo $?  #→ 0
$ zztestar dinheiro 000.000,00		; echo $?  #→ 0
$ zztestar dinheiro 0.000.000,00		; echo $?  #→ 0
$ zztestar dinheiro 00.000.000,00		; echo $?  #→ 0
$ zztestar dinheiro 000.000.000,00		; echo $?  #→ 0
$ zztestar dinheiro 0.000.000.000,00	; echo $?  #→ 0
$ zztestar dinheiro 00.000.000.000,00	; echo $?  #→ 0
$ zztestar dinheiro 000.000.000.000,00	; echo $?  #→ 0
$ zztestar dinheiro 0000,00			; echo $?  #→ 0
$ zztestar dinheiro 000000,00		; echo $?  #→ 0
$ zztestar dinheiro 00000000,00		; echo $?  #→ 0

# testa_dinheiro: centavos errados

$ zztestar dinheiro 0,0		; echo $?  #→ 1
$ zztestar dinheiro 0,000		; echo $?  #→ 1

# testa_dinheiro: ponto colocado errado

$ zztestar dinheiro 0.0,00		; echo $?  #→ 1
$ zztestar dinheiro 0000.0,00	; echo $?  #→ 1
$ zztestar dinheiro 0.0.000,00	; echo $?  #→ 1
$ zztestar dinheiro 0.00.000,00	; echo $?  #→ 1
$ zztestar dinheiro 000.00.000,00	; echo $?  #→ 1
$ zztestar dinheiro 0.000.0000,00	; echo $?  #→ 1
$ zztestar dinheiro 0.,00		; echo $?  #→ 1
$ zztestar dinheiro 0.0,00		; echo $?  #→ 1
$ zztestar dinheiro 0.00,00		; echo $?  #→ 1
$ zztestar dinheiro 0.0000,00	; echo $?  #→ 1
$ zztestar dinheiro .000,00		; echo $?  #→ 1
$ zztestar dinheiro 0000.000,00	; echo $?  #→ 1
$ zztestar dinheiro 0.0000.000,00	; echo $?  #→ 1

# testa_dinheiro: outros

$ zztestar dinheiro XXX		; echo $?  #→ 1
$ zztestar dinheiro 9		; echo $?  #→ 1
$ zztestar dinheiro +9		; echo $?  #→ 1
$ zztestar dinheiro :9		; echo $?  #→ 1
$ zztestar dinheiro ,9		; echo $?  #→ 1
$ zztestar dinheiro .9		; echo $?  #→ 1

# testa_binario

$ zztestar binario 0		; echo $?  #→ 0
$ zztestar binario 1		; echo $?  #→ 0
$ zztestar binario 0000		; echo $?  #→ 0
$ zztestar binario 0110		; echo $?  #→ 0
$ zztestar binario 2		; echo $?  #→ 1
$ zztestar binario +010		; echo $?  #→ 1
$ zztestar binario -010		; echo $?  #→ 1

# testa_ip

$ zztestar ip 0.0.0.0		; echo $?  #→ 0
$ zztestar ip 99.99.99.99		; echo $?  #→ 0
$ zztestar ip 255.255.255.255	; echo $?  #→ 0
$ zztestar ip 1.11.111.0		; echo $?  #→ 0
$ zztestar ip 0.99.100.199		; echo $?  #→ 0
$ zztestar ip 200.249.250.255	; echo $?  #→ 0
$ zztestar ip 000.000.000.000	; echo $?  #→ 1
$ zztestar ip 256.256.256.256	; echo $?  #→ 1
$ zztestar ip 999.999.999.999	; echo $?  #→ 1
$ zztestar ip 0000.0000.0000.0000	; echo $?  #→ 1
$ zztestar ip 0.0.0			; echo $?  #→ 1
$ zztestar ip 0.0			; echo $?  #→ 1
$ zztestar ip 0			; echo $?  #→ 1

# testa_ano: 1-9999

$ zztestar ano -1000		; echo $?  #→ 1
$ zztestar ano -1			; echo $?  #→ 1
$ zztestar ano 0			; echo $?  #→ 1
$ zztestar ano 1			; echo $?  #→ 0
$ zztestar ano 10			; echo $?  #→ 0
$ zztestar ano 100			; echo $?  #→ 0
$ zztestar ano 1000			; echo $?  #→ 0
$ zztestar ano 2000			; echo $?  #→ 0
$ zztestar ano 9999			; echo $?  #→ 0
$ zztestar ano 99999		; echo $?  #→ 1

# testa_ano: padding

$ zztestar ano 0001			; echo $?  #→ 0
$ zztestar ano 001			; echo $?  #→ 0
$ zztestar ano 01			; echo $?  #→ 0

# testa_data: o ano é livre

$ zztestar data 01/01/0		; echo $?  #→ 0
$ zztestar data 01/01/1		; echo $?  #→ 0
$ zztestar data 01/01/10		; echo $?  #→ 0
$ zztestar data 01/01/100		; echo $?  #→ 0
$ zztestar data 01/01/1000		; echo $?  #→ 0
$ zztestar data 01/01/2000		; echo $?  #→ 0
$ zztestar data 01/01/9999		; echo $?  #→ 0

# testa_data: limites mensais

$ zztestar data 31/01/2000		; echo $?  #→ 0
$ zztestar data 29/02/2000		; echo $?  #→ 0
$ zztestar data 31/03/2000		; echo $?  #→ 0
$ zztestar data 30/04/2000		; echo $?  #→ 0
$ zztestar data 31/05/2000		; echo $?  #→ 0
$ zztestar data 30/06/2000		; echo $?  #→ 0
$ zztestar data 31/07/2000		; echo $?  #→ 0
$ zztestar data 31/08/2000		; echo $?  #→ 0
$ zztestar data 30/09/2000		; echo $?  #→ 0
$ zztestar data 31/10/2000		; echo $?  #→ 0
$ zztestar data 30/11/2000		; echo $?  #→ 0
$ zztestar data 31/12/2000		; echo $?  #→ 0

# testa_data: datas com um dígito no dia ou mês são proibidas

$ zztestar data 1/01/2000		; echo $?  #→ 1
$ zztestar data 5/05/2000		; echo $?  #→ 1
$ zztestar data 9/09/2000		; echo $?  #→ 1
$ zztestar data 01/1/2000		; echo $?  #→ 1
$ zztestar data 05/5/2000		; echo $?  #→ 1
$ zztestar data 09/9/2000		; echo $?  #→ 1
$ zztestar data 1/1/2000		; echo $?  #→ 1
$ zztestar data 5/5/2000		; echo $?  #→ 1
$ zztestar data 9/9/2000		; echo $?  #→ 1

# testa_data: data fora do limite

$ zztestar data 32/01/2000		; echo $?  #→ 1
$ zztestar data 30/02/2000		; echo $?  #→ 1
$ zztestar data 32/03/2000		; echo $?  #→ 1
$ zztestar data 31/04/2000		; echo $?  #→ 1
$ zztestar data 32/05/2000		; echo $?  #→ 1
$ zztestar data 31/06/2000		; echo $?  #→ 1
$ zztestar data 32/07/2000		; echo $?  #→ 1
$ zztestar data 32/08/2000		; echo $?  #→ 1
$ zztestar data 31/09/2000		; echo $?  #→ 1
$ zztestar data 32/10/2000		; echo $?  #→ 1
$ zztestar data 31/11/2000		; echo $?  #→ 1
$ zztestar data 32/12/2000		; echo $?  #→ 1
$ zztestar data 39/01/2000		; echo $?  #→ 1
$ zztestar data 01/13/2000		; echo $?  #→ 1
$ zztestar data 01/19/2000		; echo $?  #→ 1
$ zztestar data 00/01/2000		; echo $?  #→ 1
$ zztestar data 01/00/2000		; echo $?  #→ 1
$ zztestar data 99/99/2000		; echo $?  #→ 1

# testa_data: não pega datas parciais

$ zztestar data 31/12		; echo $?  #→ 1
$ zztestar data 931/12/2000		; echo $?  #→ 1
$ zztestar data +31/12/2000		; echo $?  #→ 1
$ zztestar data 31/12/2000+		; echo $?  #→ 1
$ zztestar data +31/12/2000+	; echo $?  #→ 1

# testa_hora

$ zztestar hora  0:00		; echo $?  #→ 0
$ zztestar hora  1:01		; echo $?  #→ 0
$ zztestar hora  2:02		; echo $?  #→ 0
$ zztestar hora  3:03		; echo $?  #→ 0
$ zztestar hora  4:04		; echo $?  #→ 0
$ zztestar hora  5:05		; echo $?  #→ 0
$ zztestar hora  6:06		; echo $?  #→ 0
$ zztestar hora  7:07		; echo $?  #→ 0
$ zztestar hora  8:08		; echo $?  #→ 0
$ zztestar hora  9:09		; echo $?  #→ 0
$ zztestar hora 00:00		; echo $?  #→ 0
$ zztestar hora 01:01		; echo $?  #→ 0
$ zztestar hora 02:02		; echo $?  #→ 0
$ zztestar hora 03:03		; echo $?  #→ 0
$ zztestar hora 04:04		; echo $?  #→ 0
$ zztestar hora 05:05		; echo $?  #→ 0
$ zztestar hora 06:06		; echo $?  #→ 0
$ zztestar hora 07:07		; echo $?  #→ 0
$ zztestar hora 08:08		; echo $?  #→ 0
$ zztestar hora 09:09		; echo $?  #→ 0
$ zztestar hora 10:10		; echo $?  #→ 0
$ zztestar hora 11:11		; echo $?  #→ 0
$ zztestar hora 12:12		; echo $?  #→ 0
$ zztestar hora 13:13		; echo $?  #→ 0
$ zztestar hora 14:14		; echo $?  #→ 0
$ zztestar hora 15:15		; echo $?  #→ 0
$ zztestar hora 16:16		; echo $?  #→ 0
$ zztestar hora 17:17		; echo $?  #→ 0
$ zztestar hora 18:18		; echo $?  #→ 0
$ zztestar hora 19:19		; echo $?  #→ 0
$ zztestar hora 20:20		; echo $?  #→ 0
$ zztestar hora 21:21		; echo $?  #→ 0
$ zztestar hora 22:22		; echo $?  #→ 0
$ zztestar hora 23:23		; echo $?  #→ 0
$ zztestar hora 23:59		; echo $?  #→ 0
$ zztestar hora 24:00		; echo $?  #→ 1
$ zztestar hora 24:59		; echo $?  #→ 1
$ zztestar hora  4:60		; echo $?  #→ 1
$ zztestar hora  4:99		; echo $?  #→ 1
$ zztestar hora 99:99		; echo $?  #→ 1

# testa_hora: não pega horas parciais

$ zztestar hora 911:11		; echo $?  #→ 1
$ zztestar hora 11:119		; echo $?  #→ 1
$ zztestar hora 911:119		; echo $?  #→ 1

# testa_hora: delimitador (com ou sem)

$ zztestar hora 2359		; echo $?  #→ 1
$ zztestar hora :			; echo $?  #→ 1

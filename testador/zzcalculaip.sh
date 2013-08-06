$ zzcalculaip					#→ --regex ^Uso:

$ zzcalculaip	a				#→ Número IP inválido 'a'
$ zzcalculaip	0.0.0				#→ Número IP inválido '0.0.0'
$ zzcalculaip	0.0				#→ Número IP inválido '0.0'
$ zzcalculaip	0				#→ Número IP inválido '0'
$ zzcalculaip	0.0.0.256			#→ Número IP inválido '0.0.0.256'

$ zzcalculaip	10.0.0.0	a		#→ Máscara inválida: a
$ zzcalculaip	10.0.0.0	-1		#→ Máscara inválida: -1
$ zzcalculaip	10.0.0.0	33		#→ Máscara inválida: 33
$ zzcalculaip	10.0.0.0	0.0.0		#→ Máscara inválida: 0.0.0
$ zzcalculaip	10.0.0.0	0.0		#→ Máscara inválida: 0.0
$ zzcalculaip	10.0.0.0	0.0.0.256	#→ Máscara inválida: 0.0.0.256
$ zzcalculaip	10.0.0.0/33			#→ Máscara inválida: 33
$ zzcalculaip	10.0.0.0/0.0.0.256		#→ Máscara inválida: 0.0.0.256

# Máscara padrão RFC 1918
$ zzcalculaip 10.0.0.0
End. IP  : 10.0.0.0
Mascara  : 255.0.0.0 = 8
Rede     : 10.0.0.0 / 8
Broadcast: 10.255.255.255
$
$ zzcalculaip 10.255.255.255
End. IP  : 10.255.255.255
Mascara  : 255.0.0.0 = 8
Rede     : 10.0.0.0 / 8
Broadcast: 10.255.255.255
$
$ zzcalculaip 172.16.0.0
End. IP  : 172.16.0.0
Mascara  : 255.240.0.0 = 12
Rede     : 172.16.0.0 / 12
Broadcast: 172.31.255.255
$
$ zzcalculaip 172.25.0.0
End. IP  : 172.25.0.0
Mascara  : 255.240.0.0 = 12
Rede     : 172.16.0.0 / 12
Broadcast: 172.31.255.255
$
$ zzcalculaip 172.31.255.255
End. IP  : 172.31.255.255
Mascara  : 255.240.0.0 = 12
Rede     : 172.16.0.0 / 12
Broadcast: 172.31.255.255
$
$ zzcalculaip 192.168.0.0
End. IP  : 192.168.0.0
Mascara  : 255.255.0.0 = 16
Rede     : 192.168.0.0 / 16
Broadcast: 192.168.255.255
$
$ zzcalculaip 192.168.255.255
End. IP  : 192.168.255.255
Mascara  : 255.255.0.0 = 16
Rede     : 192.168.0.0 / 16
Broadcast: 192.168.255.255
$

# Máscara padrão: 8
$ zzcalculaip 127.0.0.0
End. IP  : 127.0.0.0
Mascara  : 255.0.0.0 = 8
Rede     : 127.0.0.0 / 8
Broadcast: 127.255.255.255
$
$ zzcalculaip 127.255.255.255
End. IP  : 127.255.255.255
Mascara  : 255.0.0.0 = 8
Rede     : 127.0.0.0 / 8
Broadcast: 127.255.255.255
$

# Máscara padrão: 24
$ zzcalculaip 0.0.0.0
End. IP  : 0.0.0.0
Mascara  : 255.255.255.0 = 24
Rede     : 0.0.0.0 / 24
Broadcast: 0.0.0.255
$
$ zzcalculaip 9.0.0.0
End. IP  : 9.0.0.0
Mascara  : 255.255.255.0 = 24
Rede     : 9.0.0.0 / 24
Broadcast: 9.0.0.255
$
$ zzcalculaip 11.0.0.0
End. IP  : 11.0.0.0
Mascara  : 255.255.255.0 = 24
Rede     : 11.0.0.0 / 24
Broadcast: 11.0.0.255
$
$ zzcalculaip 172.15.255.255
End. IP  : 172.15.255.255
Mascara  : 255.255.255.0 = 24
Rede     : 172.15.255.0 / 24
Broadcast: 172.15.255.255
$
$ zzcalculaip 172.32.0.0
End. IP  : 172.32.0.0
Mascara  : 255.255.255.0 = 24
Rede     : 172.32.0.0 / 24
Broadcast: 172.32.0.255
$
$ zzcalculaip 192.167.255.255
End. IP  : 192.167.255.255
Mascara  : 255.255.255.0 = 24
Rede     : 192.167.255.0 / 24
Broadcast: 192.167.255.255
$
$ zzcalculaip 192.169.0.0
End. IP  : 192.169.0.0
Mascara  : 255.255.255.0 = 24
Rede     : 192.169.0.0 / 24
Broadcast: 192.169.0.255
$

# Máscara informada pelo usuário, como IP ou inteiro
$ zzcalculaip 10.0.0.1/24
End. IP  : 10.0.0.1
Mascara  : 255.255.255.0 = 24
Rede     : 10.0.0.0 / 24
Broadcast: 10.0.0.255
$
$ zzcalculaip 10.0.0.1 24
End. IP  : 10.0.0.1
Mascara  : 255.255.255.0 = 24
Rede     : 10.0.0.0 / 24
Broadcast: 10.0.0.255
$
$ zzcalculaip 10.0.0.1 255.255.255.0
End. IP  : 10.0.0.1
Mascara  : 255.255.255.0 = 24
Rede     : 10.0.0.0 / 24
Broadcast: 10.0.0.255
$
$ zzcalculaip 10.0.0.1/255.255.255.0   # não documentado
End. IP  : 10.0.0.1
Mascara  : 255.255.255.0 = 24
Rede     : 10.0.0.0 / 24
Broadcast: 10.0.0.255
$

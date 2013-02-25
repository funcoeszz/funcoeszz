#!/usr/bin/env bash
debug=0
values=2

saida="\
End. IP  : 10.0.0.1
Mascara  : 255.255.255.0 = 24
Rede     : 10.0.0.0 / 24
Broadcast: 10.0.0.255"

tests=(
''			''		r	^Uso:.*

a			''		r	"N.mero IP inv.lido 'a'"
0.0.0			''		r	"N.mero IP inv.lido '0.0.0'"
0.0			''		r	"N.mero IP inv.lido '0.0'"
0			''		r	"N.mero IP inv.lido '0'"
0.0.0.256		''		r	"N.mero IP inv.lido '0.0.0.256'"

10.0.0.0		a		r	"M.scara inv.lida: a"
10.0.0.0		-1		r	"M.scara inv.lida: .*"
10.0.0.0		33		r	"M.scara inv.lida: .*"
10.0.0.0		0.0.0		r	"M.scara inv.lida: .*"
10.0.0.0		0.0		r	"M.scara inv.lida: .*"
10.0.0.0		0.0.0.256	r	"M.scara inv.lida: .*"
10.0.0.0/33		''		r	"M.scara inv.lida: .*"
10.0.0.0/0.0.0.256	''		r	"M.scara inv.lida: .*"

# Máscara padrão RFC 1918
10.0.0.0		''		t	"\
End. IP  : 10.0.0.0
Mascara  : 255.0.0.0 = 8
Rede     : 10.0.0.0 / 8
Broadcast: 10.255.255.255
"
10.255.255.255		''		t	"\
End. IP  : 10.255.255.255
Mascara  : 255.0.0.0 = 8
Rede     : 10.0.0.0 / 8
Broadcast: 10.255.255.255
"
172.16.0.0		''		t	"\
End. IP  : 172.16.0.0
Mascara  : 255.240.0.0 = 12
Rede     : 172.16.0.0 / 12
Broadcast: 172.31.255.255
"
172.25.0.0		''		t	"\
End. IP  : 172.25.0.0
Mascara  : 255.240.0.0 = 12
Rede     : 172.16.0.0 / 12
Broadcast: 172.31.255.255
"
172.31.255.255		''		t	"\
End. IP  : 172.31.255.255
Mascara  : 255.240.0.0 = 12
Rede     : 172.16.0.0 / 12
Broadcast: 172.31.255.255
"
192.168.0.0		''		t	"\
End. IP  : 192.168.0.0
Mascara  : 255.255.0.0 = 16
Rede     : 192.168.0.0 / 16
Broadcast: 192.168.255.255
"
192.168.255.255		''		t	"\
End. IP  : 192.168.255.255
Mascara  : 255.255.0.0 = 16
Rede     : 192.168.0.0 / 16
Broadcast: 192.168.255.255
"

# Máscara padrão: 8
127.0.0.0		''		t	"\
End. IP  : 127.0.0.0
Mascara  : 255.0.0.0 = 8
Rede     : 127.0.0.0 / 8
Broadcast: 127.255.255.255
"
127.255.255.255		''		t	"\
End. IP  : 127.255.255.255
Mascara  : 255.0.0.0 = 8
Rede     : 127.0.0.0 / 8
Broadcast: 127.255.255.255
"

# Máscara padrão: 24
0.0.0.0			''		t	"\
End. IP  : 0.0.0.0
Mascara  : 255.255.255.0 = 24
Rede     : 0.0.0.0 / 24
Broadcast: 0.0.0.255
"
9.0.0.0			''		t	"\
End. IP  : 9.0.0.0
Mascara  : 255.255.255.0 = 24
Rede     : 9.0.0.0 / 24
Broadcast: 9.0.0.255
"
11.0.0.0		''		t	"\
End. IP  : 11.0.0.0
Mascara  : 255.255.255.0 = 24
Rede     : 11.0.0.0 / 24
Broadcast: 11.0.0.255
"
172.15.255.255		''		t	"\
End. IP  : 172.15.255.255
Mascara  : 255.255.255.0 = 24
Rede     : 172.15.255.0 / 24
Broadcast: 172.15.255.255
"
172.32.0.0		''		t	"\
End. IP  : 172.32.0.0
Mascara  : 255.255.255.0 = 24
Rede     : 172.32.0.0 / 24
Broadcast: 172.32.0.255
"
192.167.255.255		''		t	"\
End. IP  : 192.167.255.255
Mascara  : 255.255.255.0 = 24
Rede     : 192.167.255.0 / 24
Broadcast: 192.167.255.255
"
192.169.0.0		''		t	"\
End. IP  : 192.169.0.0
Mascara  : 255.255.255.0 = 24
Rede     : 192.169.0.0 / 24
Broadcast: 192.169.0.255
"

# Máscara informada pelo usuário, como IP ou inteiro
10.0.0.1/24		''		t	"$saida"
10.0.0.1		24		t	"$saida"
10.0.0.1		255.255.255.0	t	"$saida"
10.0.0.1/255.255.255.0	''		t	"$saida"  # não documentada
)
. _lib

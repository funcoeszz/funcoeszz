# Testa IPV4
$ zzipinternet    #=> --regex (^$|^[0-9.]+$)
$ zzipinternet -4 #=> --regex (^$|^[0-9.]+$)

# Testa IPV6. 
$ zzipinternet -6 #=> --regex (^$|^[0-9a-fA-F:]{4,}$)

# Testa muitos argumentos.
$ zzipinternet -4 -6; echo $?
Utilizar no máximo 1 argumento.
1
$

# Testa argumento inválido.
$ zzipinternet ERRO; echo $?
Opção inválida: ERRO
1
$

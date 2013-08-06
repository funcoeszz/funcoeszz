# Mapa completo (ida e volta)

$ zzrot13 ABCDEFGHIJKLMNOPQRSTUVWXYZ	#→ NOPQRSTUVWXYZABCDEFGHIJKLM
$ zzrot13 abcdefghijklmnopqrstuvwxyz	#→ nopqrstuvwxyzabcdefghijklm
$ zzrot13 NOPQRSTUVWXYZABCDEFGHIJKLM	#→ ABCDEFGHIJKLMNOPQRSTUVWXYZ
$ zzrot13 nopqrstuvwxyzabcdefghijklm	#→ abcdefghijklmnopqrstuvwxyz

# Letras acentuadas não são alteradas

$ zzrot13 AÁaá				#→ NÁná

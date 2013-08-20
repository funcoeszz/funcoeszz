# Erros de sintaxe

$ zzgravatar							#→ --regex ^Uso:
$ zzgravatar	-t						#→ --regex ^Uso:
$ zzgravatar	-d						#→ --regex ^Uso:
$ zzgravatar	-t	x					#→ --regex ^Uso:
$ zzgravatar	-d	x					#→ --regex ^Uso:
$ zzgravatar	-t			fulano@example.com	#→ --regex ^Uso:
$ zzgravatar	-d			fulano@example.com	#→ --regex ^Uso:
$ zzgravatar	-t	500	-d	fulano@example.com	#→ --regex ^Uso:
$ zzgravatar	-d	mm	-t	fulano@example.com	#→ --regex ^Uso:

# Erros de argumentos

$ zzgravatar	-t	x	fulano@example.com	#→ Número inválido para a opção -t: x
$ zzgravatar	-t	-1	fulano@example.com	#→ Número inválido para a opção -t: -1
$ zzgravatar	-t	0	fulano@example.com	#→ Número inválido para a opção -t: 0
$ zzgravatar	-t	999	fulano@example.com	#→ O tamanho máximo para a imagem é 512
$ zzgravatar	-d	1	fulano@example.com	#→ Valor inválido para a opção -d: '1'

# Ignore case

$ zzgravatar fulano@example.com  #→ http://www.gravatar.com/avatar/98812691b923b99459c5231bc9725003
$ zzgravatar FULANO@EXAMPLE.COM  #→ http://www.gravatar.com/avatar/98812691b923b99459c5231bc9725003

# Uso normal

$ url='http://www.gravatar.com/avatar/98812691b923b99459c5231bc9725003'
$ zzgravatar	-t	1			fulano@example.com	#→ --eval echo "$url?size=1"
$ zzgravatar	-t	500			fulano@example.com	#→ --eval echo "$url?size=500"
$ zzgravatar			-d	mm	fulano@example.com	#→ --eval echo "$url?default=mm"
$ zzgravatar			-d	retro	fulano@example.com	#→ --eval echo "$url?default=retro"
$ zzgravatar	-t	500	-d	mm	fulano@example.com	#→ --eval echo "$url?size=500&default=mm"
$ zzgravatar	-t	500	-d	retro	fulano@example.com	#→ --eval echo "$url?size=500&default=retro"

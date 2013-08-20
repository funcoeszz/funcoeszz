$ zzlorem	#→ --regex ^Lorem ipsum .* orci luctus et.$

$ zzlorem 1	#→ Lorem
$ zzlorem 2	#→ Lorem ipsum
$ zzlorem 5	#→ Lorem ipsum dolor sit amet,

$ zzlorem foo	#→ Uso: zzlorem [número-de-palavras]
$ zzlorem -1	#→ Uso: zzlorem [número-de-palavras]
$ zzlorem 1.0	#→ Uso: zzlorem [número-de-palavras]

$ zzexcuse -h

zzexcuse
Da uma desculpa comum de desenvolvedor ( em ingles ).
Com a opção -t ou --traduzir mostra as desculpas traduzidas.

Uso: zzexcuse [-t|--traduzir]
Ex.: zzexcuse

$
$ zzexcuse | sed '/^ *$/d' | wc -l	#→ 1
$ zzexcuse -t | sed '/^ *$/d' | wc -l	#→ 1

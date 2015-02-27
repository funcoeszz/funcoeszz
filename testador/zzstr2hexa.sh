$ n="$(printf '.\n.')"
$ t="$(printf '.\t.')"
$ zzstr2hexa	binario		#→ --eval printf "62 69 6e 61 72 69 6f"
$ zzstr2hexa	com	espaco	#→ --eval printf "63 6f 6d 20 65 73 70 61 63 6f"
$ zzstr2hexa	'. .'		#→ --eval printf "2e 20 2e"
$ zzstr2hexa	'\t'		#→ --eval printf "5c 74"
$ zzstr2hexa	'\n'		#→ --eval printf "5c 6e"
$ zzstr2hexa	"$t"		#→ --eval printf "2e 09 2e"
$ zzstr2hexa	"$n"		#→ --eval printf "2e 0a 2e"
$ n=
$ t=

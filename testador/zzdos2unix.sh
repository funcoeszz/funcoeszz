$ printf "linha1\r\nlinha2\r\n\r\n" | zzdos2unix | cat -v
linha1
linha2

$ printf "linha1\r\n\r\nlinha2\r\n" | zzdos2unix | cat -v
linha1

linha2
$ printf "\nlinha1\nlinha2\n" | zzdos2unix | cat -v

linha1
linha2
$

$ printf "\nlinha1\nlinha2\n" | zzunix2dos | cat -v
^M
linha1^M
linha2^M
$ printf "linha1\nlinha2\r\n" | zzunix2dos | cat -v
linha1^M
linha2^M
$ printf "linha1\n\n\nlinha2\n" | zzunix2dos | cat -v
linha1^M
^M
^M
linha2^M
$

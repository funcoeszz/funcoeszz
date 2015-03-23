# ISO-8859-1 → UTF-8

$ zzutf8 _iso-8859-1.txt
aaáaa
eéeée
iíííi
óóoóó
úúúúú
$ cat _iso-8859-1.txt | zzutf8
aaáaa
eéeée
iíííi
óóoóó
úúúúú
$ printf '\341\n' | zzutf8
á
$ printf '\341\341' | zzutf8 ; echo
áá
$

# UTF-8 → UTF-8 (nada muda)

$ zzutf8 zzascii.sh               #→ --file zzascii.sh
$ cat zzascii.sh | zzutf8         #→ --file zzascii.sh
$ printf 'bênção\n' | zzutf8
bênção
$ printf 'bênção'   | zzutf8 ; echo
bênção
$

# US-ASCII → UTF-8 (nada muda)

$ zzutf8 _numeros.txt             #→ --file _numeros.txt
$ cat _numeros.txt | zzutf8       #→ --file _numeros.txt
$ printf 'foo\n' | zzutf8
foo
$ printf 'foo'   | zzutf8 ; echo
foo
$

# vazio (nada muda)

$ zzutf8 _vazio.txt               #→ --file _vazio.txt
$ cat _vazio.txt | zzutf8         #→ --file _vazio.txt
$ echo | zzutf8

$ printf '' | zzutf8
$

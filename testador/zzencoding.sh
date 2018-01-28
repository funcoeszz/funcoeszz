# UTF-8

$ zzencoding zzascii.sh
utf-8
$ cat zzascii.sh | zzencoding
utf-8
$ echo bênção | zzencoding
utf-8
$

# ISO-8859-1

$ zzencoding _iso-8859-1.txt
iso-8859-1
$ cat _iso-8859-1.txt | zzencoding
iso-8859-1
$

# US-ASCII

$ zzencoding _numeros.txt
us-ascii
$ cat _numeros.txt | zzencoding
us-ascii
$ echo foo | zzencoding
us-ascii
$

# sem \n

$ printf bênção | zzencoding
utf-8
$ printf '\341 ' | zzencoding
iso-8859-1
$ printf foo | zzencoding
us-ascii
$

# vazio

$ zzencoding _vazio.txt		#→ --regex ^(binary)?$
$ echo | zzencoding			#→ --regex ^(binary)?$
$ printf '' | zzencoding	#→ --regex ^(binary)?$
$

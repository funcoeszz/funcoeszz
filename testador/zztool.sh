$ zztool uso zztool			#=> Uso: zztool [-e] ferramenta [argumentos]
$ zztool index_var tan testando		#=> 4
$ zztool -e arquivo_vago _dados.txt	#=> Arquivo _dados.txt já existe. Abortando.
$ zztool -e arquivo_legivel _fake_		#=> Não consegui ler o arquivo _fake_

# eco

$ ZZCOR=0
$ zztool eco testando		#=> testando
$ ZZCOR=1
$ zztool eco testando		#=> [36;1mtestando[m

# acha

$ zztool acha tan testando	#=> tes[36;1mtan[mdo
$ ZZCOR=0
$

# grep_var

$ zztool grep_var ana banana		; echo $?  #=> 0
$ zztool grep_var XXX banana		; echo $?  #=> 1

# testa_numero

$ zztool testa_numero 9			; echo $?  #=> 0
$ zztool testa_numero 9999		; echo $?  #=> 0
$ zztool testa_numero XXX		; echo $?  #=> 1
$ zztool testa_numero -9		; echo $?  #=> 1

# testa_ano: 1-9999

$ zztool testa_ano -1000		; echo $?  #=> 1
$ zztool testa_ano -1			; echo $?  #=> 1
$ zztool testa_ano 0			; echo $?  #=> 1
$ zztool testa_ano 1			; echo $?  #=> 0
$ zztool testa_ano 10			; echo $?  #=> 0
$ zztool testa_ano 100			; echo $?  #=> 0
$ zztool testa_ano 1000			; echo $?  #=> 0
$ zztool testa_ano 2000			; echo $?  #=> 0
$ zztool testa_ano 9999			; echo $?  #=> 0
$ zztool testa_ano 99999		; echo $?  #=> 1

# testa_ano: padding

$ zztool testa_ano 0001			; echo $?  #=> 0
$ zztool testa_ano 001			; echo $?  #=> 0
$ zztool testa_ano 01			; echo $?  #=> 0

# testa_data: o ano é livre

$ zztool testa_data 01/01/0		; echo $?  #=> 0
$ zztool testa_data 01/01/1		; echo $?  #=> 0
$ zztool testa_data 01/01/10		; echo $?  #=> 0
$ zztool testa_data 01/01/100		; echo $?  #=> 0
$ zztool testa_data 01/01/1000		; echo $?  #=> 0
$ zztool testa_data 01/01/2000		; echo $?  #=> 0
$ zztool testa_data 01/01/9999		; echo $?  #=> 0

# testa_data: limites mensais

$ zztool testa_data 31/01/2000		; echo $?  #=> 0
$ zztool testa_data 29/02/2000		; echo $?  #=> 0
$ zztool testa_data 31/03/2000		; echo $?  #=> 0
$ zztool testa_data 30/04/2000		; echo $?  #=> 0
$ zztool testa_data 31/05/2000		; echo $?  #=> 0
$ zztool testa_data 30/06/2000		; echo $?  #=> 0
$ zztool testa_data 31/07/2000		; echo $?  #=> 0
$ zztool testa_data 31/08/2000		; echo $?  #=> 0
$ zztool testa_data 30/09/2000		; echo $?  #=> 0
$ zztool testa_data 31/10/2000		; echo $?  #=> 0
$ zztool testa_data 30/11/2000		; echo $?  #=> 0
$ zztool testa_data 31/12/2000		; echo $?  #=> 0

# testa_data: datas com um dígito no dia ou mês são proibidas

$ zztool testa_data 1/01/2000		; echo $?  #=> 1
$ zztool testa_data 5/05/2000		; echo $?  #=> 1
$ zztool testa_data 9/09/2000		; echo $?  #=> 1
$ zztool testa_data 01/1/2000		; echo $?  #=> 1
$ zztool testa_data 05/5/2000		; echo $?  #=> 1
$ zztool testa_data 09/9/2000		; echo $?  #=> 1
$ zztool testa_data 1/1/2000		; echo $?  #=> 1
$ zztool testa_data 5/5/2000		; echo $?  #=> 1
$ zztool testa_data 9/9/2000		; echo $?  #=> 1

# testa_data: data fora do limite

$ zztool testa_data 32/01/2000		; echo $?  #=> 1
$ zztool testa_data 30/02/2000		; echo $?  #=> 1
$ zztool testa_data 32/03/2000		; echo $?  #=> 1
$ zztool testa_data 31/04/2000		; echo $?  #=> 1
$ zztool testa_data 32/05/2000		; echo $?  #=> 1
$ zztool testa_data 31/06/2000		; echo $?  #=> 1
$ zztool testa_data 32/07/2000		; echo $?  #=> 1
$ zztool testa_data 32/08/2000		; echo $?  #=> 1
$ zztool testa_data 31/09/2000		; echo $?  #=> 1
$ zztool testa_data 32/10/2000		; echo $?  #=> 1
$ zztool testa_data 31/11/2000		; echo $?  #=> 1
$ zztool testa_data 32/12/2000		; echo $?  #=> 1
$ zztool testa_data 39/01/2000		; echo $?  #=> 1
$ zztool testa_data 01/13/2000		; echo $?  #=> 1
$ zztool testa_data 01/19/2000		; echo $?  #=> 1
$ zztool testa_data 00/01/2000		; echo $?  #=> 1
$ zztool testa_data 01/00/2000		; echo $?  #=> 1
$ zztool testa_data 99/99/2000		; echo $?  #=> 1

# testa_data: não pega datas parciais

$ zztool testa_data 31/12		; echo $?  #=> 1
$ zztool testa_data 931/12/2000		; echo $?  #=> 1
$ zztool testa_data +31/12/2000		; echo $?  #=> 1
$ zztool testa_data 31/12/2000+		; echo $?  #=> 1
$ zztool testa_data +31/12/2000+	; echo $?  #=> 1

# endereco_sed

$ zztool endereco_sed $		#=> $
$ zztool endereco_sed 0		#=> 0
$ zztool endereco_sed 1		#=> 1
$ zztool endereco_sed 99	#=> 99
$ zztool endereco_sed 999	#=> 999
$ zztool endereco_sed -1	#=> /-1/
$ zztool endereco_sed a$	#=> /a$/
$ zztool endereco_sed a		#=> /a/
$ zztool endereco_sed ^a.*$	#=> /^a.*$/
$ zztool endereco_sed /		#=> /\//
$ zztool endereco_sed /a/	#=> /\/a\//
$ zztool endereco_sed /a/b/c	#=> /\/a\/b\/c/
$ zztool endereco_sed 'a b c'	#=> /a b c/

# num_linhas
$ true     | zztool num_linhas	#=> 0
$ echo     | zztool num_linhas	#=> 1
$ printf x | zztool num_linhas	#=> 1
$ zzseq 9  | zztool num_linhas	#=> 9

# multi_stdin

$ echo ok | zztool multi_stdin
ok
$ zztool multi_stdin ok
ok
$

# list2lines

$ echo ' a  b  c ' | zztool list2lines
a
b
c
$ echo ' a,  b,  c ' | zztool list2lines
a
b
c
$ echo ' a;  b;  c ' | zztool list2lines
a
b
c
$ zztool list2lines ' a   b   c '
a
b
c
$ zztool list2lines ' a,  b,  c '
a
b
c
$ zztool list2lines ' a;  b;  c ' 
a
b
c
$ zztool list2lines  a   b   c
a
b
c
$ zztool list2lines  a,  b,  c 
a
b
c
$

# lines2json

$ printf '1\n2\n3\n4\n' | zztool lines2json
["1",
"2",
"3",
"4"]
$ echo foo | zztool lines2json
["foo"]
$ echo | zztool lines2json
[""]
$ echo 'escapes: " " \ \' | zztool lines2json
["escapes: \" \" \\ \\"]
$

# nl_eof

$ printf 'abc' | zztool nl_eof
abc
$ printf 'abc\n123' | zztool nl_eof
abc
123
$

# mktemp

$ file=$(zztool mktemp foooo)
$ echo "$file" | sed "s|$ZZTMP|prefix|; s/......$/XXXXXX/"
prefix.foooo.XXXXXX
$ test -r "$file" && echo ok
ok
$ rm "$file"
$

# mktemp - segurança, funciona mesmo sem $ZZTMP

$ ZZTMP_ORIG="$ZZTMP"
$ unset ZZTMP
$ file=$(zztool mktemp foooo)
$ echo "$file" | sed 's/......$/XXXXXX/'
/tmp/zz.foooo.XXXXXX
$ rm "$file"
$ ZZTMP="$ZZTMP_ORIG"
$

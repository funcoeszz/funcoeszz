# Erros de linha de comando

$ zzurlencode -X; echo $?
Opção inválida: -X
1
$ zzurlencode -n; echo $?
Faltou informar o valor da opção -n
1
$

# Teste do -- para indicar o fim das opções

$ zzurlencode -- -n
-n
$

# Estes não devem ser convertidos

$ zzurlencode ABCDEFGHIJKLMNOPQRSTUVWXYZ    #→ ABCDEFGHIJKLMNOPQRSTUVWXYZ
$ zzurlencode abcdefghijklmnopqrstuvwxyz    #→ abcdefghijklmnopqrstuvwxyz
$ zzurlencode 0123456789                    #→ 0123456789
$ zzurlencode _.~-                          #→ _.~-

# Mas serão convertidos se usar -a

$ zzurlencode -a ABCDEFGHIJKLMNOPQRSTUVWXYZ
%41%42%43%44%45%46%47%48%49%4A%4B%4C%4D%4E%4F%50%51%52%53%54%55%56%57%58%59%5A
$ zzurlencode -a abcdefghijklmnopqrstuvwxyz
%61%62%63%64%65%66%67%68%69%6A%6B%6C%6D%6E%6F%70%71%72%73%74%75%76%77%78%79%7A
$ zzurlencode -a 0123456789
%30%31%32%33%34%35%36%37%38%39
$ zzurlencode -a _.~-
%5F%2E%7E%2D
$

# ASCII imprimíveis, exceto A-Za-z0-9_.~-

$ zzurlencode ' '    #→ %20
$ zzurlencode '!'    #→ %21
$ zzurlencode '"'    #→ %22
$ zzurlencode '#'    #→ %23
$ zzurlencode '$'    #→ %24
$ zzurlencode '%'    #→ %25
$ zzurlencode '&'    #→ %26
$ zzurlencode \'     #→ %27
$ zzurlencode '('    #→ %28
$ zzurlencode ')'    #→ %29
$ zzurlencode '*'    #→ %2A
$ zzurlencode '+'    #→ %2B
$ zzurlencode ','    #→ %2C
$ zzurlencode '/'    #→ %2F
$ zzurlencode ':'    #→ %3A
$ zzurlencode ';'    #→ %3B
$ zzurlencode '<'    #→ %3C
$ zzurlencode '='    #→ %3D
$ zzurlencode '>'    #→ %3E
$ zzurlencode '?'    #→ %3F
$ zzurlencode '@'    #→ %40
$ zzurlencode '['    #→ %5B
$ zzurlencode \\     #→ %5C
$ zzurlencode ']'    #→ %5D
$ zzurlencode '^'    #→ %5E
$ zzurlencode '`'    #→ %60
$ zzurlencode '{'    #→ %7B
$ zzurlencode '|'    #→ %7C
$ zzurlencode '}'    #→ %7D

# Tabela ASCII Extendida (ISO-8859-1, Latin-1) - Imprimíveis

$ zzurlencode '¡'    #→ %C2%A1
$ zzurlencode '¢'    #→ %C2%A2
$ zzurlencode '£'    #→ %C2%A3
$ zzurlencode '¤'    #→ %C2%A4
$ zzurlencode '¥'    #→ %C2%A5
$ zzurlencode '¦'    #→ %C2%A6
$ zzurlencode '§'    #→ %C2%A7
$ zzurlencode '¨'    #→ %C2%A8
$ zzurlencode '©'    #→ %C2%A9
$ zzurlencode 'ª'    #→ %C2%AA
$ zzurlencode '«'    #→ %C2%AB
$ zzurlencode '¬'    #→ %C2%AC
$ zzurlencode '­'    #→ %C2%AD
$ zzurlencode '®'    #→ %C2%AE
$ zzurlencode '¯'    #→ %C2%AF
$ zzurlencode '°'    #→ %C2%B0
$ zzurlencode '±'    #→ %C2%B1
$ zzurlencode '²'    #→ %C2%B2
$ zzurlencode '³'    #→ %C2%B3
$ zzurlencode '´'    #→ %C2%B4
$ zzurlencode 'µ'    #→ %C2%B5
$ zzurlencode '¶'    #→ %C2%B6
$ zzurlencode '·'    #→ %C2%B7
$ zzurlencode '¸'    #→ %C2%B8
$ zzurlencode '¹'    #→ %C2%B9
$ zzurlencode 'º'    #→ %C2%BA
$ zzurlencode '»'    #→ %C2%BB
$ zzurlencode '¼'    #→ %C2%BC
$ zzurlencode '½'    #→ %C2%BD
$ zzurlencode '¾'    #→ %C2%BE
$ zzurlencode '¿'    #→ %C2%BF
$ zzurlencode 'À'    #→ %C3%80
$ zzurlencode 'Á'    #→ %C3%81
$ zzurlencode 'Â'    #→ %C3%82
$ zzurlencode 'Ã'    #→ %C3%83
$ zzurlencode 'Ä'    #→ %C3%84
$ zzurlencode 'Å'    #→ %C3%85
$ zzurlencode 'Æ'    #→ %C3%86
$ zzurlencode 'Ç'    #→ %C3%87
$ zzurlencode 'È'    #→ %C3%88
$ zzurlencode 'É'    #→ %C3%89
$ zzurlencode 'Ê'    #→ %C3%8A
$ zzurlencode 'Ë'    #→ %C3%8B
$ zzurlencode 'Ì'    #→ %C3%8C
$ zzurlencode 'Í'    #→ %C3%8D
$ zzurlencode 'Î'    #→ %C3%8E
$ zzurlencode 'Ï'    #→ %C3%8F
$ zzurlencode 'Ð'    #→ %C3%90
$ zzurlencode 'Ñ'    #→ %C3%91
$ zzurlencode 'Ò'    #→ %C3%92
$ zzurlencode 'Ó'    #→ %C3%93
$ zzurlencode 'Ô'    #→ %C3%94
$ zzurlencode 'Õ'    #→ %C3%95
$ zzurlencode 'Ö'    #→ %C3%96
$ zzurlencode '×'    #→ %C3%97
$ zzurlencode 'Ø'    #→ %C3%98
$ zzurlencode 'Ù'    #→ %C3%99
$ zzurlencode 'Ú'    #→ %C3%9A
$ zzurlencode 'Û'    #→ %C3%9B
$ zzurlencode 'Ü'    #→ %C3%9C
$ zzurlencode 'Ý'    #→ %C3%9D
$ zzurlencode 'Þ'    #→ %C3%9E
$ zzurlencode 'ß'    #→ %C3%9F
$ zzurlencode 'à'    #→ %C3%A0
$ zzurlencode 'á'    #→ %C3%A1
$ zzurlencode 'â'    #→ %C3%A2
$ zzurlencode 'ã'    #→ %C3%A3
$ zzurlencode 'ä'    #→ %C3%A4
$ zzurlencode 'å'    #→ %C3%A5
$ zzurlencode 'æ'    #→ %C3%A6
$ zzurlencode 'ç'    #→ %C3%A7
$ zzurlencode 'è'    #→ %C3%A8
$ zzurlencode 'é'    #→ %C3%A9
$ zzurlencode 'ê'    #→ %C3%AA
$ zzurlencode 'ë'    #→ %C3%AB
$ zzurlencode 'ì'    #→ %C3%AC
$ zzurlencode 'í'    #→ %C3%AD
$ zzurlencode 'î'    #→ %C3%AE
$ zzurlencode 'ï'    #→ %C3%AF
$ zzurlencode 'ð'    #→ %C3%B0
$ zzurlencode 'ñ'    #→ %C3%B1
$ zzurlencode 'ò'    #→ %C3%B2
$ zzurlencode 'ó'    #→ %C3%B3
$ zzurlencode 'ô'    #→ %C3%B4
$ zzurlencode 'õ'    #→ %C3%B5
$ zzurlencode 'ö'    #→ %C3%B6
$ zzurlencode '÷'    #→ %C3%B7
$ zzurlencode 'ø'    #→ %C3%B8
$ zzurlencode 'ù'    #→ %C3%B9
$ zzurlencode 'ú'    #→ %C3%BA
$ zzurlencode 'û'    #→ %C3%BB
$ zzurlencode 'ü'    #→ %C3%BC
$ zzurlencode 'ý'    #→ %C3%BD
$ zzurlencode 'þ'    #→ %C3%BE
$ zzurlencode 'ÿ'    #→ %C3%BF

# Caracteres UTF-8 de três bytes

$ zzurlencode '★'    #→ %E2%98%85
$ zzurlencode '♥'    #→ %E2%99%A5
$ zzurlencode '→'    #→ %E2%86%92

# Opção -n
# Preserva os unreserved e os informados no -n

$ zzurlencode -n x       abc_123_/_á_♥     #→ abc_123_%2F_%C3%A1_%E2%99%A5
$ zzurlencode -n abc     abc_123_/_á_♥     #→ abc_123_%2F_%C3%A1_%E2%99%A5
$ zzurlencode -n /       abc_123_/_á_♥     #→ abc_123_/_%C3%A1_%E2%99%A5
$ zzurlencode -n /á      abc_123_/_á_♥     #→ abc_123_/_á_%E2%99%A5
$ zzurlencode -n /á♥     abc_123_/_á_♥     #→ abc_123_/_á_♥

# Opção -n após o -a
# Somente os caracteres do -n serão preservados, os demais serão escapados

$ zzurlencode -a -n /á♥  abc_123_/_á_♥     #→ %61%62%63%5F%31%32%33%5F/%5Fá%5F♥
$ zzurlencode -a -n /á♥_ abc_123_/_á_♥     #→ %61%62%63_%31%32%33_/_á_♥

# Opção -n com caracteres especiais (tenta quebrar o algoritmo)

$ tab=$(printf '\t')
$ zzurlencode    -n "'"       "'a'"        #→ 'a'
$ zzurlencode -a -n "'a"      "'a'"        #→ 'a'
$ zzurlencode    -n '"'       '"a"'        #→ "a"
$ zzurlencode -a -n '"a'      '"a"'        #→ "a"
$ zzurlencode    -n '['       '[a['        #→ [a[
$ zzurlencode -a -n '[a'      '[a['        #→ [a[
$ zzurlencode    -n ']'       ']a]'        #→ ]a]
$ zzurlencode -a -n ']a'      ']a]'        #→ ]a]
$ zzurlencode    -n '!'       '!a!'        #→ !a!
$ zzurlencode -a -n '!a'      '!a!'        #→ !a!
$ zzurlencode    -n '%'       '%a%'        #→ %a%
$ zzurlencode -a -n '%a'      '%a%'        #→ %a%
$ zzurlencode    -n '^'       '^a^'        #→ ^a^
$ zzurlencode -a -n '^a'      '^a^'        #→ ^a^
$ zzurlencode    -n '\'       '\a\'        #→ \a\
$ zzurlencode -a -n '\a'      '\a\'        #→ \a\
$ zzurlencode    -n '\\'      '\\a\'       #→ \\a\
$ zzurlencode -a -n '\\a'     '\\a\'       #→ \\a\
$ zzurlencode    -n '\\\'     '\\\a\\a\'   #→ \\\a\\a\
$ zzurlencode -a -n '\\\a'    '\\\a\\a\'   #→ \\\a\\a\
$ zzurlencode    -n " "       " a"         #→  a
$ zzurlencode -a -n " a"      " a"         #→  a
$ zzurlencode    -n "${tab}a" "${tab}a"    #→ 	a
$ zzurlencode -a -n "${tab}a" "${tab}a"    #→ 	a
$ zzurlencode    -n '\t'      "${tab}a"    #→ %09a
$ zzurlencode -a -n '\ta'     "${tab}a"    #→ %09a
$ unset tab
$

# STDIN

$ printf 'a' | zzurlencode                 #→ a
$ printf 'á' | zzurlencode                 #→ %C3%A1
$ printf '♥' | zzurlencode                 #→ %E2%99%A5

# Caracteres especiais: \t \n

$ printf '.\t.' | zzurlencode              #→ .%09.
$ printf '.\n.' | zzurlencode              #→ .%0A.

# Teste com string longa de caracteres repetidos (od -v)

$ zzurlencode áááááááááááááááá
%C3%A1%C3%A1%C3%A1%C3%A1%C3%A1%C3%A1%C3%A1%C3%A1%C3%A1%C3%A1%C3%A1%C3%A1%C3%A1%C3%A1%C3%A1%C3%A1
$

# Caracteres especiais: espaço \t \n

$ zzurldecode '%20' | tr ' ' =
=
$ zzurldecode '%09' | tr '\t' =
=
$ zzurldecode '1%0A2%0A3'
1
2
3
$

# STDIN e URL

$ echo 'http://pt.wikipedia.org/wiki/C%C3%B3lera_%28banda%29' | zzurldecode
http://pt.wikipedia.org/wiki/Cólera_(banda)
$

# Vários consecutivos

$ zzurldecode '%E2%80%9C%43%6F%6E%73%74%72%75%C3%AD%20%6F%20%6D%65%75%20%63%61%73%74%65%6C%6F%20%63%6F%6D%20%61%73%20%70%65%64%72%61%73%20%71%75%65%20%76%6F%63%C3%AA%20%6A%6F%67%6F%75%2E%E2%80%9D'
“Construí o meu castelo com as pedras que você jogou.”
$

# Somente decodifica os hexadecimais, ignora o + (veja issue #202)

$ zzurldecode '%61+%62'
a+b
$

# Tabela ASCII - Imprimíveis (decimal, hexa, octal, caractere)

$ zzurldecode '%21'      #→ !
$ zzurldecode '%22'      #→ "
$ zzurldecode '%23'      #→ #
$ zzurldecode '%24'      #→ $
$ zzurldecode '%25'      #→ %
$ zzurldecode '%26'      #→ &
$ zzurldecode '%27'      #→ '
$ zzurldecode '%28'      #→ (
$ zzurldecode '%29'      #→ )
$ zzurldecode '%2A'      #→ *
$ zzurldecode '%2B'      #→ +
$ zzurldecode '%2C'      #→ ,
$ zzurldecode '%2D'      #→ -
$ zzurldecode '%2E'      #→ .
$ zzurldecode '%2F'      #→ /
$ zzurldecode '%30'      #→ 0
$ zzurldecode '%31'      #→ 1
$ zzurldecode '%32'      #→ 2
$ zzurldecode '%33'      #→ 3
$ zzurldecode '%34'      #→ 4
$ zzurldecode '%35'      #→ 5
$ zzurldecode '%36'      #→ 6
$ zzurldecode '%37'      #→ 7
$ zzurldecode '%38'      #→ 8
$ zzurldecode '%39'      #→ 9
$ zzurldecode '%3A'      #→ :
$ zzurldecode '%3B'      #→ ;
$ zzurldecode '%3C'      #→ <
$ zzurldecode '%3D'      #→ =
$ zzurldecode '%3E'      #→ >
$ zzurldecode '%3F'      #→ ?
$ zzurldecode '%40'      #→ @
$ zzurldecode '%41'      #→ A
$ zzurldecode '%42'      #→ B
$ zzurldecode '%43'      #→ C
$ zzurldecode '%44'      #→ D
$ zzurldecode '%45'      #→ E
$ zzurldecode '%46'      #→ F
$ zzurldecode '%47'      #→ G
$ zzurldecode '%48'      #→ H
$ zzurldecode '%49'      #→ I
$ zzurldecode '%4A'      #→ J
$ zzurldecode '%4B'      #→ K
$ zzurldecode '%4C'      #→ L
$ zzurldecode '%4D'      #→ M
$ zzurldecode '%4E'      #→ N
$ zzurldecode '%4F'      #→ O
$ zzurldecode '%50'      #→ P
$ zzurldecode '%51'      #→ Q
$ zzurldecode '%52'      #→ R
$ zzurldecode '%53'      #→ S
$ zzurldecode '%54'      #→ T
$ zzurldecode '%55'      #→ U
$ zzurldecode '%56'      #→ V
$ zzurldecode '%57'      #→ W
$ zzurldecode '%58'      #→ X
$ zzurldecode '%59'      #→ Y
$ zzurldecode '%5A'      #→ Z
$ zzurldecode '%5B'      #→ [
$ zzurldecode '%5C'      #→ \
$ zzurldecode '%5D'      #→ ]
$ zzurldecode '%5E'      #→ ^
$ zzurldecode '%5F'      #→ _
$ zzurldecode '%60'      #→ `
$ zzurldecode '%61'      #→ a
$ zzurldecode '%62'      #→ b
$ zzurldecode '%63'      #→ c
$ zzurldecode '%64'      #→ d
$ zzurldecode '%65'      #→ e
$ zzurldecode '%66'      #→ f
$ zzurldecode '%67'      #→ g
$ zzurldecode '%68'      #→ h
$ zzurldecode '%69'      #→ i
$ zzurldecode '%6A'      #→ j
$ zzurldecode '%6B'      #→ k
$ zzurldecode '%6C'      #→ l
$ zzurldecode '%6D'      #→ m
$ zzurldecode '%6E'      #→ n
$ zzurldecode '%6F'      #→ o
$ zzurldecode '%70'      #→ p
$ zzurldecode '%71'      #→ q
$ zzurldecode '%72'      #→ r
$ zzurldecode '%73'      #→ s
$ zzurldecode '%74'      #→ t
$ zzurldecode '%75'      #→ u
$ zzurldecode '%76'      #→ v
$ zzurldecode '%77'      #→ w
$ zzurldecode '%78'      #→ x
$ zzurldecode '%79'      #→ y
$ zzurldecode '%7A'      #→ z
$ zzurldecode '%7B'      #→ {
$ zzurldecode '%7C'      #→ |
$ zzurldecode '%7D'      #→ }
$ zzurldecode '%7E'      #→ ~

#→ Tabela ASCII Extendida (ISO-8859-1, Latin-1) - Imprimíveis

$ zzurldecode '%C2%A1'  #→ ¡
$ zzurldecode '%C2%A2'  #→ ¢
$ zzurldecode '%C2%A3'  #→ £
$ zzurldecode '%C2%A4'  #→ ¤
$ zzurldecode '%C2%A5'  #→ ¥
$ zzurldecode '%C2%A6'  #→ ¦
$ zzurldecode '%C2%A7'  #→ §
$ zzurldecode '%C2%A8'  #→ ¨
$ zzurldecode '%C2%A9'  #→ ©
$ zzurldecode '%C2%AA'  #→ ª
$ zzurldecode '%C2%AB'  #→ «
$ zzurldecode '%C2%AC'  #→ ¬
$ zzurldecode '%C2%AD'  #→ ­
$ zzurldecode '%C2%AE'  #→ ®
$ zzurldecode '%C2%AF'  #→ ¯
$ zzurldecode '%C2%B0'  #→ °
$ zzurldecode '%C2%B1'  #→ ±
$ zzurldecode '%C2%B2'  #→ ²
$ zzurldecode '%C2%B3'  #→ ³
$ zzurldecode '%C2%B4'  #→ ´
$ zzurldecode '%C2%B5'  #→ µ
$ zzurldecode '%C2%B6'  #→ ¶
$ zzurldecode '%C2%B7'  #→ ·
$ zzurldecode '%C2%B8'  #→ ¸
$ zzurldecode '%C2%B9'  #→ ¹
$ zzurldecode '%C2%BA'  #→ º
$ zzurldecode '%C2%BB'  #→ »
$ zzurldecode '%C2%BC'  #→ ¼
$ zzurldecode '%C2%BD'  #→ ½
$ zzurldecode '%C2%BE'  #→ ¾
$ zzurldecode '%C2%BF'  #→ ¿
$ zzurldecode '%C3%80'  #→ À
$ zzurldecode '%C3%81'  #→ Á
$ zzurldecode '%C3%82'  #→ Â
$ zzurldecode '%C3%83'  #→ Ã
$ zzurldecode '%C3%84'  #→ Ä
$ zzurldecode '%C3%85'  #→ Å
$ zzurldecode '%C3%86'  #→ Æ
$ zzurldecode '%C3%87'  #→ Ç
$ zzurldecode '%C3%88'  #→ È
$ zzurldecode '%C3%89'  #→ É
$ zzurldecode '%C3%8A'  #→ Ê
$ zzurldecode '%C3%8B'  #→ Ë
$ zzurldecode '%C3%8C'  #→ Ì
$ zzurldecode '%C3%8D'  #→ Í
$ zzurldecode '%C3%8E'  #→ Î
$ zzurldecode '%C3%8F'  #→ Ï
$ zzurldecode '%C3%90'  #→ Ð
$ zzurldecode '%C3%91'  #→ Ñ
$ zzurldecode '%C3%92'  #→ Ò
$ zzurldecode '%C3%93'  #→ Ó
$ zzurldecode '%C3%94'  #→ Ô
$ zzurldecode '%C3%95'  #→ Õ
$ zzurldecode '%C3%96'  #→ Ö
$ zzurldecode '%C3%97'  #→ ×
$ zzurldecode '%C3%98'  #→ Ø
$ zzurldecode '%C3%99'  #→ Ù
$ zzurldecode '%C3%9A'  #→ Ú
$ zzurldecode '%C3%9B'  #→ Û
$ zzurldecode '%C3%9C'  #→ Ü
$ zzurldecode '%C3%9D'  #→ Ý
$ zzurldecode '%C3%9E'  #→ Þ
$ zzurldecode '%C3%9F'  #→ ß
$ zzurldecode '%C3%A0'  #→ à
$ zzurldecode '%C3%A1'  #→ á
$ zzurldecode '%C3%A2'  #→ â
$ zzurldecode '%C3%A3'  #→ ã
$ zzurldecode '%C3%A4'  #→ ä
$ zzurldecode '%C3%A5'  #→ å
$ zzurldecode '%C3%A6'  #→ æ
$ zzurldecode '%C3%A7'  #→ ç
$ zzurldecode '%C3%A8'  #→ è
$ zzurldecode '%C3%A9'  #→ é
$ zzurldecode '%C3%AA'  #→ ê
$ zzurldecode '%C3%AB'  #→ ë
$ zzurldecode '%C3%AC'  #→ ì
$ zzurldecode '%C3%AD'  #→ í
$ zzurldecode '%C3%AE'  #→ î
$ zzurldecode '%C3%AF'  #→ ï
$ zzurldecode '%C3%B0'  #→ ð
$ zzurldecode '%C3%B1'  #→ ñ
$ zzurldecode '%C3%B2'  #→ ò
$ zzurldecode '%C3%B3'  #→ ó
$ zzurldecode '%C3%B4'  #→ ô
$ zzurldecode '%C3%B5'  #→ õ
$ zzurldecode '%C3%B6'  #→ ö
$ zzurldecode '%C3%B7'  #→ ÷
$ zzurldecode '%C3%B8'  #→ ø
$ zzurldecode '%C3%B9'  #→ ù
$ zzurldecode '%C3%BA'  #→ ú
$ zzurldecode '%C3%BB'  #→ û
$ zzurldecode '%C3%BC'  #→ ü
$ zzurldecode '%C3%BD'  #→ ý
$ zzurldecode '%C3%BE'  #→ þ
$ zzurldecode '%C3%BF'  #→ ÿ

# Caracteres UTF-8 de três bytes

$ zzurldecode '%E2%98%85'  #→ ★
$ zzurldecode '%E2%99%A5'  #→ ♥
$ zzurldecode '%E2%86%92'  #→ →

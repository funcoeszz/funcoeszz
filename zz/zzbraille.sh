# ----------------------------------------------------------------------------
# Grafia Braille.
# A estrutura básica do alfabeto braille é composta por 2 coluna e 3 linhas.
# Essa estrutura é chamada de célula Braille
# E a sequência numérica padronizada é como segue:
# 1 4
# 2 5
# 3 6
# Assim fica como um guia, para quem desejar implantar essa acessibilidade.
# Abaixo de cada célula Braille, aparece o caracter correspondente.
# Incluindo indicadores especiais de maiúscula, numérico e espaço.
# +++++: Maiúsculo
# +-   : Capitalize
# __   : Espaço
# ##   : Número
#
# Uso: zzbraille <texto> [texto]
# Ex.: zzbraille Olá mundo!
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-05-26
# Versão: 2
# Licença: GPL
# Requisitos: zzminusculas zzmaiusculas zzcapitalize
# ----------------------------------------------------------------------------
zzbraille ()
{
	zzzz -h braille "$1" && return

	[ "$1" ] || { zztool uso braille; return 1; }

	# Lista de caracteres (quase todos)
	local caracter="\
a|1|0|0|0|0|0
b|1|1|0|0|0|0
c|1|0|0|1|0|0
d|1|0|0|1|1|0
e|1|0|0|0|1|0
f|1|1|0|1|0|0
g|1|1|0|1|1|0
h|1|1|0|0|1|0
i|0|1|0|1|0|0
j|0|1|0|1|1|0
k|1|0|1|0|0|0
l|1|1|1|0|0|0
m|1|0|1|1|0|0
n|1|0|1|1|1|0
o|1|0|1|0|1|0
p|1|1|1|1|0|0
q|1|1|1|1|1|0
r|1|1|1|0|1|0
s|0|1|1|1|0|0
t|0|1|1|1|1|0
u|1|0|1|0|0|1
v|1|1|1|0|0|1
w|0|1|0|1|1|1
x|1|0|1|1|0|1
y|1|0|1|1|1|1
z|1|0|1|0|1|1
1|1|0|0|0|0|0
2|1|1|0|0|0|0
3|1|0|0|1|0|0
4|1|0|0|1|1|0
5|1|0|0|0|1|0
6|1|1|0|1|0|0
7|1|1|0|1|1|0
8|1|1|0|0|1|0
9|0|1|0|1|0|0
0|0|1|0|1|1|0
.|0|1|0|0|1|1
,|0|1|0|0|0|0
?|0|1|0|0|0|1
;|0|1|1|0|0|0
!|0|1|1|0|1|0
-|0|0|1|0|0|1
'|0|0|1|0|0|0
*|0|0|1|0|1|0
$|0|0|0|0|1|1
:|0|1|0|0|1|0
=|0|1|1|0|1|1
â|1|0|0|0|0|1
ê|1|1|0|0|0|1
ì|1|0|0|1|0|1
ô|1|0|0|1|1|1
ù|1|0|0|0|1|1
à|1|1|0|1|0|1
ï|1|1|0|1|1|1
ü|1|1|0|0|1|1
õ|0|1|0|1|0|1
ò|0|1|0|1|1|1
ç|1|1|1|1|0|1
é|1|1|1|1|1|1
á|1|1|1|0|1|1
è|0|1|1|1|0|1
ú|0|1|1|1|1|1
í|0|0|1|1|0|0
ã|0|0|1|1|1|0
ó|0|0|1|1|0|1
(|1|1|0|0|0|1
)|0|0|1|1|1|0
[|1|1|1|0|1|1
]|0|1|1|1|1|1
{|1|1|1|0|1|1
}|0|1|1|1|1|1
>|1|0|1|0|1|0
<|0|1|0|1|0|1
°|0|0|1|0|1|1
+|0|1|1|0|1|0
×|0|1|1|0|0|1
÷|0|1|0|0|1|1
#|0|0|0|0|0|0"

	# Caracteres especias que usam mais de uma célula Braille
	local caracter_esp='―|0|0|1|0|0|1|0|0|1|0|0|1
/|0|0|0|0|0|1|0|1|0|0|0|0
_|0|0|0|1|0|1|0|0|1|0|0|1
€|0|0|0|1|0|0|1|0|0|1|1|0
(|1|1|0|0|0|1|0|0|1|0|0|0
)|0|0|0|0|0|1|0|0|1|1|1|0
"|0|1|1|0|0|1|0|0|0|0|0|0
'

	local largura=$(echo $(($(tput cols)-2)))
	local linha1 linha2 linha3 tamanho i letra codigo linha0
	while [ "$1" ]
	do
		# Demarcando início do texto (iniciativa do autor para noção dos limites da célula Braille)
		# E sinalizando espaço entre as palavras
		linha0=${linha0}' __'
		linha1=${linha1}' 00'
		linha2=${linha2}' 00'
		linha3=${linha3}' 00'

		if zztool testa_numero "$1" || zztool testa_numero_fracionario "$1"
		then
			linha0=${linha0}' ##' # Para indicar que começa um número, nas apontamento abaixo da célula
			linha1=${linha1}' 01'
			linha2=${linha2}' 01'
			linha3=${linha3}' 11'
		elif [ "$1" = $(zzcapitalize $1) ]
		then
			linha0=${linha0}' +-' # Para indicar que o texto a seguir está com a primeira letra em maiúscula (capitalize)
			linha1=${linha1}' 01'
			linha2=${linha2}' 00'
			linha3=${linha3}' 01'
		elif [ "$1" = $(zzmaiusculas $1) ]
		then
			linha0=${linha0}' +++++' # Para indicar que o texto a seguir está todo maiúsculo
			linha1=${linha1}' 01 01'
			linha2=${linha2}' 00 00'
			linha3=${linha3}' 01 01'
		fi

		tamanho=$(echo "${#linha1} + ${#1} * 3" | bc)
		if [ $tamanho -le $largura ]
		then
			for i in $(zzseq ${#1})
			do
				letra=$(echo "$1"| tr ' ' '#' | zzminusculas | awk '{print substr($0,'$i',1)}')
				letra_original=$(echo "$1"| tr ' ' '#' | awk '{print substr($0,'$i',1)}')
				if [ $letra ]
				then
					[ $letra = '/' ] && letra='\/'
					codigo=$(echo "$caracter" | sed -n "/^[$letra]/p")
					if [ $codigo ]
					then
						letra_original=$(echo $letra_original | tr '#' ' ')
						linha0=${linha0}'('${letra_original}')'
						linha1=${linha1}' '$(echo $codigo | awk -F'|' '{print $2 $5}')
						linha2=${linha2}' '$(echo $codigo | awk -F'|' '{print $3 $6}')
						linha3=${linha3}' '$(echo $codigo | awk -F'|' '{print $4 $7}')
					else
						codigo=$(echo "$caracter_esp" | sed -n "/^[$letra]/p")
						linha0=${linha0}'( '${letra_original}' )'
						linha1=${linha1}' '$(echo $codigo | awk -F'|' '{print $2 $5 $8 $11}')
						linha2=${linha2}' '$(echo $codigo | awk -F'|' '{print $3 $6 $9 $12}')
						linha3=${linha3}' '$(echo $codigo | awk -F'|' '{print $4 $7 $10 $13}')
					fi
				fi
			done
			shift
		else
			echo $linha1 | sed 's/1/●/g;s/0/○/g'
			echo $linha2 | sed 's/1/●/g;s/0/○/g'
			echo $linha3 | sed 's/1/●/g;s/0/○/g'
			echo $linha0
			echo
			unset linha1
			unset linha2
			unset linha3
			unset linha0
		fi
	done
	echo $linha1 | sed 's/1/●/g;s/0/○/g'
	echo $linha2 | sed 's/1/●/g;s/0/○/g'
	echo $linha3 | sed 's/1/●/g;s/0/○/g'
	echo $linha0
	echo
}

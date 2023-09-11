# ----------------------------------------------------------------------------
# Conversor de código morse.
#
# Uso: zzmorse [string]
# Ex.: zzmorse alfredo
#      zzmorse ... --- ...
#
# Autor: Alfredo Casanova <atcasanova (a) gmail com>
# Desde: 2018-04-26
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzmorse ()
{
	zzzz -h morse "$1" && return

	# No pattern usando listas não há necessidade de escapar usando egrep
	local match_pattern='^[ .-]+$'
	local i j input dados

	test -n "$1" || { zztool -e uso morse; return 1; }

	# Setando a variável input apenas se for comprovado que é um código morse
	echo "$*" | egrep "${match_pattern}" > /dev/null 2>&1 && input='morse'

	# Dados com as combinações entre letras e números e seus respectivos códigos.
	local dados="\
A	.-
B	-...
C	-.-.
D	-..
E	.
F	..-.
G	--.
H	....
I	..
J	.---
K	-.-
L	.-..
M	--
N	-.
O	---
P	.--.
Q	--.-
R	.-.
S	...
T	-
U	..-
V	...-
W	.--
X	-..-
Y	-.--
Z	--..
0	-----
1	.----
2	..---
3	...--
4	....-
5	.....
6	-....
7	--...
8	---..
9	----."

	if test 'morse' == "$input"
	then
		# Se a entrada for Código Morse
		for i in $*
		do
			echo "$dados" |
				awk -v t_m="$i" '$2 == t_m { print $1 }'
		done
	else
		# Se a entrada não for Código Morse
		for j in $*
		do
			# Um loop caso ocorra mais de uma string na entrada
			for i in $(echo "$j" | tr '[a-z]' '[A-Z]' | sed 's/./& /g')
			do
				echo "$dados" |
					awk -v t_m="$i" '$1 == t_m { print $2 }'
			done
			echo "_"
		done
	fi |
	zztool lines2list |
	if test 'morse' == "$input"
	then
		# No caso de Código Morse na entrada, junta o texto de saída
		sed 's/ //g'
	else
		# No caso de Código Morse na saída, troca o caractere '_' por espaço
		# que separa múltiplas entradas.
		tr '_' ' '
	fi |
	sed 's/ *$//'|
	zztool nl_eof
}


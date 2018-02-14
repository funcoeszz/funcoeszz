# ----------------------------------------------------------------------------
# Reduz vários espaços consecutivos vertical ou horizontalmente em apenas um.
#
# Opções:
#  -l ou --linha: Apenas linhas vazias consecutivas, se reduzem a uma.
#  -c ou --coluna: Espaços consecutivos em cada linha, são unidos em um.
#
# Obs.: Linhas inteiras com espaços ou tabulações,
#        tornam-se linhas de comprimento zero (sem nenhum caractere).
#
# Uso: zzsqueeze [-l|--linha] [-c|--coluna] arquivo
# Ex.: zzsqueeze arquivo.txt
#      zzsqueeze -l arq.txt   # Apenas retira linhas consecutivas em branco.
#      zzsqueeze -c arq.txt   # Transforma em 1 espaço, vários espaços juntos.
#      cat arquivo | zzsqueeze
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2015-09-24
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzsqueeze ()
{
	zzzz -h squeeze "$1" && return

	local linha=1
	local coluna=1

	# Opções de linha de comando
	while test "${1#-}" != "$1"
	do
		case "$1" in
			-l | --linha  ) shift; coluna=0;;
			-c | --coluna ) shift; linha=0;;
			--) shift; break;;
			-*) zztool -e uso squeeze; return 1;;
			*) break;;
		esac
	done

	zztool file_stdin "$@" |
	if test $coluna -eq 1
	then
		tr -s '[:blank:]' ' '
	else
		cat -
	fi |
	if test $linha -eq 1
	then
		awk '
			/^[ 	]*$/{ branco++ }

			! /^[ 	]*$/ {
				if (branco>0) { print ""; branco=0 }
				print
			}

			END { if (branco>0) print "" }
		'
	else
		sed 's/^[ 	]*$//'
	fi
}

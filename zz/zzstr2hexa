# ----------------------------------------------------------------------------
# Converte string em bytes em hexadecimal equivalente.
# Uso: zzstr2hexa [string]
# Ex.: zzstr2hexa @MenteBrilhante
#      zzstr2hexa bin
#      echo bin | zzstr2hexa
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2012-03-30
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
zzstr2hexa ()
{
	zzzz -h str2hexa "$1" && return

	local string

	# string -> hexa
	for string in  $(
		# Dados via STDIN ou argumentos
		zztool multi_stdin "$@" |

		# Um caracter por linha e tira o \n do final da linha
		sed 's#\(.\)#\1 #g' )
	do
		printf "%x " \'$string
	done |
		# Remove o espaço que sobra no final
		sed 's/ $//'

	# Quebra de linha final
	echo
}

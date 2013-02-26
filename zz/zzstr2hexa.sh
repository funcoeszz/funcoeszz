# ----------------------------------------------------------------------------
# Converte string em bytes em hexadecimal equivalente.
# Uso: zzstr2hexa [string]
# Ex.: zzstr2hexa @MenteBrilhante    # 40 4d 65 6e 74 65 42 72 69 6c 68 61 6e…
#      zzstr2hexa bin                # 62 69 6e
#      echo bin | zzstr2hexa         # 62 69 6e
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2012-03-30
# Versão: 7
# Licença: GPL
# ----------------------------------------------------------------------------
zzstr2hexa ()
{
	zzzz -h str2hexa "$1" && return

	local string caractere
	local nl=$(printf '\n')

	# String vem como argumento ou STDIN?
	# Nota: não use zztool multi_stdin, adiciona \n no final do argumento
	if test $# -ne 0
	then
		string="$*"
	else
		string=$(cat /dev/stdin)
	fi

	# Loop a cada caractere, e o printf o converte para hexa
	printf %s "$string" | while IFS= read -r -n 1 caractere
	do
		if test "$caractere" = "$nl"
		then
			# Exceção para contornar um bug:
			#   printf %x 'c retorna 0 quando c=\n
			printf '0a '
		else
			printf '%02x ' "'$caractere"
		fi
	done |
		# Remove o espaço que sobra no final e quebra a linha
		sed 's/ $//'
}

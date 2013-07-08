# ----------------------------------------------------------------------------
# Imprime a tabuada de um número de 1 a 10.
# Se não for informado nenhum argumento será impressa a tabuada de 1 a 9.
# O argumento pode ser entre 0 a 99.
#
# Uso: zztabuada [número]
# Ex.: zztabuada
#      zztabuada 2
#
# Autor: Kl0nEz <kl0nez (a) wifi org br>
# Desde: 2011-08-23
# Versão: 4
# Licença: GPLv2
# ----------------------------------------------------------------------------
zztabuada ()
{
	zzzz -h tabuada "$1" && return

	local i j calcula
	local linha="+--------------+--------------+--------------+"

	case "$1" in
		[0-9] | [0-9][0-9])
			for i in 0 1 2 3 4 5 6 7 8 9 10
			do
				printf '%d x %-2d = %d\n' "$1" "$i" $(($1*$i))
			done
		;;
		*)
			for i in 1 4 7
			do
				echo "$linha"
				echo "| Tabuada do $i | Tabuada do $((i+1)) | Tabuada do $((i+2)) |"
				echo "$linha"
				for j in 0 1 2 3 4 5 6 7 8 9 10
				do
					printf '| %d x %-2d = %-3d ' "$i"     "$j" $((i*j))
					printf '| %d x %-2d = %-3d ' $((i+1)) "$j" $(((i+1)*j))
					printf '| %d x %-2d = %-3d ' $((i+2)) "$j" $(((i+2)*j))
					printf '|\n'
				done
				echo "$linha"
				echo
			done
		;;
	esac
}

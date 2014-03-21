# ----------------------------------------------------------------------------
# Imprime a tabuada de qualquer número inteiro positivo ou negativo de 1 a 10.
# Se não for informado nenhum argumento será impressa a tabuada de 1 a 9.
#
# Uso: zztabuada [número]
# Ex.: zztabuada
#      zztabuada 2
#      zztabuada -176
#
# Autor: Kl0nEz <kl0nez (a) wifi org br>
# Desde: 2011-08-23
# Versão: 5
# Licença: GPLv2
# ----------------------------------------------------------------------------
zztabuada ()
{
	zzzz -h tabuada "$1" && return

	local i j
	local linha="+--------------+--------------+--------------+"

	case "$#" in
		1)
			if zztool testa_numero_sinal "$1"
			then
				for i in 0 1 2 3 4 5 6 7 8 9 10
				do
					if test $i -eq 0 && ! zztool testa_numero "$1"
					then
						printf '%d x %-2d = %d\n' "$1" "$i" $(($1*$i)) | sed 's/= 0/=  0/'
					else
						printf '%d x %-2d = %d\n' "$1" "$i" $(($1*$i))
					fi
				done
			else
				zztool uso tabuada
			fi
		;;
		0)
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
			done | sed '$d'
		;;
	esac
}

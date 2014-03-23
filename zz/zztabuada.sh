# ----------------------------------------------------------------------------
# Exibe a tabela de tabuada de um número.
# Com 1 argumento:
#  Tabuada de qualquer número inteiro de 1 a 10.
#
# Com 2 argumentos:
#  Tabuada de qualquer número inteiro de 1 ao segundo argumento.
#  O segundo argumento só pode ser um número positivo de 1 até 99, inclusive.
#
# Se não for informado nenhum argumento será impressa a tabuada de 1 a 9.
#
# Uso: zztabuada [número [número]]
# Ex.: zztabuada
#      zztabuada 2
#      zztabuada -176
#      zztabuada 5 15  # Tabuada do 5, mas multiplicado de 1 até o 15.
#
# Autor: Kl0nEz <kl0nez (a) wifi org br>
# Desde: 2011-08-23
# Versão: 6
# Licença: GPLv2
# Requisitos: zzseq
# ----------------------------------------------------------------------------
zztabuada ()
{
	zzzz -h tabuada "$1" && return

	local i j
	local numeros='0 1 2 3 4 5 6 7 8 9 10'
	local linha="+--------------+--------------+--------------+"

	case "$#" in
		1 | 2)
			if zztool testa_numero_sinal "$1"
			then
				if zztool testa_numero "$2" && test $2 -le 99
				then
					numeros=$(zzseq -f '%d ' 0 $2)
				fi

				for i in $numeros
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
		*)
			zztool uso tabuada
			return 1
		;;
	esac
}

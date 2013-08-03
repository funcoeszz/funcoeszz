# ----------------------------------------------------------------------------
# Imprime tabuada de 1 a 10 para número informado entre 0 e 100.
# Se multiplicador não é especificado, imprime as nove primeiras tabuadas.
# Uso: zztabuada [número]
# Ex.: zztabuada
#      zztabuada 2
#
# Autor: Kl0nEz <kl0nez (a) wifi org br>
# Desde: 2011-08-23
# Versão: 5
# Licença: GPLv2
# Requisitos: zzecho
# ----------------------------------------------------------------------------
zztabuada ()
{
	zzzz -h tabuada "$1" && return

	local i j calcula
	local linha="+--------------+--------------+--------------+"


	if [ $# -eq 0 ]; then
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
		return
	fi

	case "$1" in
		[1-9] | [1-9][0-9])
			for i in 0 1 2 3 4 5 6 7 8 9 10
			do
				printf '%d x %-2d = %d\n' "$1" "$i" $(($1*$i))
			done
		;;
		-[1-9]| -[1-9][0-9] | +[1-9] | +[1-9][0-9])
			zzecho -l vermelho 'Erro: você colocou um sinal no número.'
			zzzz -h tabuada -h
		;;
		*)
			zzecho -l vermelho 'Erro: parâmetro não é número ou está fora da faixa.'
			zzzz -h tabuada -h
		;;
	esac
}

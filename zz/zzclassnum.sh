# ----------------------------------------------------------------------------
# Classifica um número inteiro e positivo.
#
# Uso: zzclassnum <número>
# Ex.: zzclassnum 1999
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2018-05-12
# Versão: 1
# Licença: GPL
# Requisitos: zzdivisores zzmat zztestar zzvira
# Tags: número
# ----------------------------------------------------------------------------
zzclassnum ()
{
	zzzz -h classnum "$1" && return

	local num exp

	# Verificação dos parâmetros
	test -n "$1" && zztestar numero "$1" || { zztool -e uso classnum; return 1; }

	# Par/Impar
	test $(echo "$1 % 2" | bc) -eq 0 && echo 'Par' || echo 'Ímpar'

	# Jacobsthal
	# Impar
	num=$(echo "$1 * 3 - 1" | bc)
	exp=$(zzmat -p15 log $num 2)
	zztestar numero "$exp" && test $(echo "$exp % 2" | bc) -eq 1 && echo 'Jacobsthal'

	# Jacobsthal
	# Par
	if test $? -ne 0
	then
		num=$(echo "$1 * 3 + 1" | bc)
		exp=$(zzmat -p15 log $num 2)
		zztestar numero "$exp" && test $(echo "$exp % 2" | bc) -eq 0 && echo 'Jacobsthal'
	fi

	if test "$1" -gt 0
	then
		# Trabalhando com os divisores
		num=$(zzdivisores "$1" 2>/dev/null)
		if test -n "$num"
		then
			# Primos
			echo "$num" | awk 'NF==2 {print "Primo";exit};{exit 1}'

			# Wagstaff
			if test $? -eq 0
			then
				num=$(echo "$1 * 3 - 1" | bc)
				exp=$(zzmat -p15 log $num 2)
				if zztestar numero "$exp" && test "$exp" -ge 2
				then
					zzdivisores "$exp" | awk 'NF==2 {exit};{exit 1}' && echo 'Wagstaff'
				fi
			else
				# Perfeito/Defectivo/Excessivo
				zzmat compara_num $(echo "$num" | sed "s/ ${1}$//;s/ /+/g" | bc) "$1" |
				sed 's/igual/Perfeito/;s/menor/Defectivo/;s/maior/Excessivo/'
			fi
		fi

		# Fermat
		num=$(zzmat -p15 log $(($1 - 1)) 2)
		if zztestar numero "$num"
		then
			zztestar numero $(zzmat -p15 log $num 2) && echo 'Fermat'
		fi

		# Mersenne
		num=$(zzmat -p15 log $(($1 + 1)) 2)
		zztestar numero $num && echo 'Mersenne'

		# Oblongo
		num=$(zzmat eq2g 1 1 -$1 | awk '/X/ && $2 !~ /-/ {print $2; exit}')
		zztestar numero "$num" && echo 'Oblongo'

		# Triangular
		num=$(zzmat int $(echo "sqrt(2*$1)" | bc -l))
		test $(echo "$num * ($num + 1)/2" | bc) -eq "$1" && echo 'Triangular'

		# Quadrado
		zztestar numero $(zzmat raiz 2 $1) && echo 'Quadrado'

		# Pentagonal
		num=$(zzmat eq2g 3 -1 -$(($1 * 2)) | awk '/X/ && $2 !~ /-/ {print $2; exit}')
		zztestar numero "$num" && echo 'Pentagonal'

		# Hexagonal
		num=$(zzmat sem_zeros $(echo "(sqrt($1 * 8 + 1) + 1)/4" | bc -l))
		zztestar numero "$num" && echo 'Hexagonal'

		# Hexagonal Centrado
		num=$(zzmat eq2g 3 -3 -$(($1 - 1)) | awk '/X/ && $2 !~ /-/ {print $2; exit}')
		zztestar numero "$num" && echo 'Hexagonal Centrado'

		# Estrela
		num=$(zzmat eq2g 6 -6 -$(($1 - 1)) | awk '/X/ && $2 !~ /-/ {print $2; exit}')
		zztestar numero "$num" && echo 'Estrela'

		# Heptagonal
		num=$(zzmat eq2g 5 -3 -$(($1 * 2)) | awk '/X/ && $2 !~ /-/ {print $2; exit}')
		zztestar numero "$num" && echo 'Heptagonal'

		# Dodecagonal
		num=$(zzmat eq2g 5 -4 -$1 | awk '/X/ && $2 !~ /-/ {print $2; exit}')
		zztestar numero "$num" && echo 'Dodecagonal'

		# Palíndromo
		test "$1" == $(zzvira "$1") && echo 'Palíndromo'

	fi
}

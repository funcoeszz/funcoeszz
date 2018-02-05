# ----------------------------------------------------------------------------
# Conversor de números romanos para hindu-arábicos e vice-versa.
# Converte corretamente para romanos números até 3999999.
# Converte corretamente para hindu-arábicos números até 4000.
#
# Uso: zzromanos número
# Ex.: zzromanos 1987                # Retorna: MCMLXXXVII
#      zzromanos XLIII               # Retorna: 43
#
# Autor: Guilherme Magalhães Gall <gmgall (a) gmail com>
# Desde: 2011-07-19
# Versão: 4
# Licença: GPL
# Requisitos: zzmaiusculas zztac
# ----------------------------------------------------------------------------
zzromanos ()
{
	zzzz -h romanos "$1" && return

	local arabicos_romanos="\
	1000000:M̄
	900000:C̄M̄
	500000:D̄
	400000:C̄D̄
	100000:C̄
	90000:X̄C̄
	50000:Ḹ
	40000:X̄Ḹ
	10000:X̄
	9000:ĪX̄
	8000:V̄ĪĪĪ
	7000:V̄ĪĪ
	6000:V̄Ī
	5000:V̄
	4000:ĪV̄
	1000:M
	900:CM
	500:D
	400:CD
	100:C
	90:XC
	50:L
	40:XL
	10:X
	9:IX
	5:V
	4:IV
	1:I"

	# Deixa o usuário usar letras maiúsculas ou minúsculas
	local entrada=$(echo "$1" | zzmaiusculas)
	local saida=""
	local indice=1
	local comprimento
	# Regex que valida um número romano de acordo com
	# http://diveintopython.org/unit_testing/stage_5.html
	local regex_validacao='^(M{0,4})(C[MD]|D?C{0,3})(X[CL]|L?X{0,3})(I[XV]|V?I{0,3})$'

	# Se nenhum argumento for passado, mostra lista de algarismos romanos
	# e seus correspondentes hindu-arábicos
	if test $# -eq 0
	then
		echo "$arabicos_romanos" |
		egrep '[15]|4000:' | tr -d '\t' | tr : '\t' |
		zztac

	# Se é um número inteiro positivo, transforma para número romano
	elif zztool testa_numero "$entrada" && test "$entrada" -lt 4000000
	then
		echo "$arabicos_romanos" | { while IFS=: read arabico romano
		do
			while test "$entrada" -ge "$arabico"
			do
				saida="$saida$romano"
				entrada=$((entrada-arabico))
			done
		done
		test "$1" -ge 4000 && printf "\n$saida\n\n" || echo "$saida"
		}

	# Se é uma string que representa um número romano válido,
	# converte para hindu-arábico
	elif echo "$entrada" | egrep "$regex_validacao" > /dev/null
	then
		saida=0
		# Baseado em http://diveintopython.org/unit_testing/stage_4.html
		echo "$arabicos_romanos" | { while IFS=: read arabico romano
		do
			comprimento="${#romano}"
			while test "$(echo "$entrada" | cut -c$indice-$((indice+comprimento-1)))" = "$romano"
			do
				indice=$((indice+comprimento))
				saida=$((saida+arabico))
			done
		done
		echo "$saida"
		}

	# Se não é inteiro posivo ou string que representa número romano válido,
	# imprime mensagem de uso.
	else
		zztool -e uso romanos
		return 1
	fi
}

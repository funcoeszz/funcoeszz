# ----------------------------------------------------------------------------
# Conversor de números romanos para indo-arábicos e vice-versa.
# Uso: zzromanos número
# Ex.: zzromanos 1987                # Retorna: MCMLXXXVII
#      zzromanos XLIII               # Retorna: 43
#
# Autor: Guilherme Magalhães Gall <gmgall (a) gmail com> twitter: @gmgall
# Desde: 2011-07-19
# Versão: 3
# Licença: GPL
# Requisitos: zzmaiusculas zztac
# ----------------------------------------------------------------------------
zzromanos ()
{
	zzzz -h romanos "$1" && return

	local arabicos_romanos="\
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
	local regex_validacao='^M?M?M?(CM|CD|D?C?C?C?)(XC|XL|L?X?X?X?)(IX|IV|V?I?I?I?)$'

	# Se nenhum argumento for passado, mostra lista de algarismos romanos
	# e seus correspondentes indo-arábicos
	if [ $# -eq 0 ]
	then
		echo "$arabicos_romanos" |
		grep -v :.. | tr -d '\t' | tr : '\t' |
		zztac

	# Se é um número inteiro positivo, transforma para número romano
	elif zztool testa_numero "$entrada"
	then
		echo "$arabicos_romanos" | { while IFS=: read arabico romano
		do
			while [ "$entrada" -ge "$arabico" ]
			do
				saida="$saida$romano"
				entrada=$((entrada-arabico))
			done
		done
		echo "$saida"
		}

	# Se é uma string que representa um número romano válido,
	# converte para indo-arábico
	elif echo "$entrada" | egrep "$regex_validacao" > /dev/null
	then
		saida=0
		# Baseado em http://diveintopython.org/unit_testing/stage_4.html
		echo "$arabicos_romanos" | { while IFS=: read arabico romano
		do
			comprimento="${#romano}"
			while [ "$(echo "$entrada" | cut -c$indice-$((indice+comprimento-1)))" = "$romano" ]
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
		zztool uso romanos
	fi
}

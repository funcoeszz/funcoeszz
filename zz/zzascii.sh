# ----------------------------------------------------------------------------
# Mostra a tabela ASCII com todos os caracteres imprimíveis (32-126,161-255).
# O formato utilizando é: <decimal> <hexa> <octal> <caractere>.
# O número de colunas e a largura da tabela são configuráveis.
# Mostra também o caractere se informar seu código decimal, hexa ou octal.
# Use as opções -d, -x ou -o para decimal, hexa ou octal respectivamente.
# Uso: zzascii [-d|-x|-o [número]] | [colunas] [largura]
# Ex.: zzascii
#      zzascii 4
#      zzascii 7 100
#      zzascii -d 57     # Exibe o caractere 9
#      zzascii -x f8     # Exibe o caractere ø
#      zzascii -o 320    # Exibe o caractere Ð
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2002-12-06
# Versão: 7
# Licença: GPL
# Requisitos: zzseq zzcolunar zzmaiusculas
# ----------------------------------------------------------------------------
zzascii ()
{
	zzzz -h ascii "$1" && return

	local decimal octal cod_in cod
	case "$1" in
		-d) cod_in='d'; cod="$2"; shift; shift ;;
		-x) cod_in='h'; cod=$(zzmaiusculas "$2"); shift; shift ;;
		-o) cod_in='o'; cod="$2"; shift; shift ;;
	esac

	if test -n "$cod_in"
	then

		case "$cod_in" in
			"o") decimal=$(echo "ibase=8;$cod" | bc 2>/dev/null) ;;
			"h") decimal=$(echo "ibase=16;$cod" | bc 2>/dev/null) ;;
			"d") decimal="$cod" ;;
		esac

		zztool testa_numero "$decimal" || return 1

		octal=$(printf '%03o' $decimal)

		if test "$decimal" -ge 32 -a "$decimal" -le 126
		then
			printf "\\$octal"
		elif test "$decimal" -ge 161 -a "$decimal" -le 191
		then
			printf "\302\\$octal"
		elif test "$decimal" -ge 192 -a "$decimal" -le 255
		then
			octal=$(printf '%03o' $((decimal - 64)))
			printf "\303\\$octal"
		else
			return 1
		fi |
		zztool nl_eof

	else

		local largura_coluna hexa caractere octal_conversao
		local num_colunas="${1:-5}"
		local largura="${2:-78}"
		local max_colunas=20
		local max_largura=500

		# Verificações básicas
		if (
			! zztool testa_numero "$num_colunas" ||
			! zztool testa_numero "$largura" ||
			test "$num_colunas" -eq 0 ||
			test "$largura" -eq 0)
		then
			zztool -e uso ascii
			return 1
		fi

		if test $num_colunas -gt $max_colunas
		then
			zztool erro "O número máximo de colunas é $max_colunas"
			return 1
		fi
		if test $largura -gt $max_largura
		then
			zztool erro "A largura máxima é de $max_largura"
			return 1
		fi

		# Largura total de cada coluna, usado no printf
		largura_coluna=$((largura / num_colunas))

		echo 'Tabela ASCII - Imprimíveis (decimal, hexa, octal, caractere)'
		echo

		for decimal in $(zzseq 32 126)
		do
			hexa=$( printf '%X'   $decimal)
			octal=$(printf '%03o' $decimal) # NNN
			caractere=$(printf "\\$octal")
			printf "%${largura_coluna}s\n" "$decimal $hexa $octal $caractere"
		done |
			zzcolunar -r -w $largura_coluna $num_colunas |
			sed 's/\(  \)\(32 20 040\)/\2\1/'
			# Sed acima é devido ao alinhamento no zzcolunar que elimina um espaço válido

		echo
		echo 'Tabela ASCII Extendida (ISO-8859-1, Latin-1) - Imprimíveis'
		echo

		# Cada caractere UTF-8 da faixa seguinte é composto por dois bytes,
		# por isso precisamos levar isso em conta no printf final
		largura_coluna=$((largura_coluna + 1))

		for decimal in $(zzseq 161 255)
		do
			hexa=$( printf '%X'   $decimal)
			octal=$(printf '%03o' $decimal) # NNN

			# http://www.lingua-systems.com/unicode-converter/unicode-mappings/encode-iso-8859-1-to-utf-8-unicode.html
			if test $decimal -le 191  # 161-191: ¡-¿
			then
				caractere=$(printf "\302\\$octal")
			else                      # 192-255: À-ÿ
				octal_conversao=$(printf '%03o' $((decimal - 64)))
				caractere=$(printf "\303\\$octal_conversao")
			fi

			# Mostra a célula atual da tabela
			printf "%${largura_coluna}s\n" "$decimal $hexa $octal $caractere"
		done |
			zzcolunar -r -w $((largura_coluna - 1)) $num_colunas

fi
}

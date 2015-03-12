# ----------------------------------------------------------------------------
# Mostra a tabela ASCII com todos os caracteres imprimíveis (32-126,161-255).
# O formato utilizando é: <decimal> <hexa> <octal> <caractere>.
# O número de colunas e a largura da tabela são configuráveis.
# Uso: zzascii [colunas] [largura]
# Ex.: zzascii
#      zzascii 4
#      zzascii 7 100
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2002-12-06
# Versão: 4
# Licença: GPL
# Requisitos: zzseq zzcolunar zztrim
# ----------------------------------------------------------------------------
zzascii ()
{
	zzzz -h ascii "$1" && return

	local largura_coluna decimal hexa octal caractere hexa_conversao
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
		caractere=$(printf "\x$hexa")
		printf "%${largura_coluna}s\n" "$decimal $hexa $octal $caractere"
	done | zzcolunar -r $num_colunas | zztrim -r

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
			caractere=$(printf "\xC2\x$hexa")
		else                      # 192-255: À-ÿ
			hexa_conversao=$(printf '%X' $((decimal - 64)))
			caractere=$(printf "\xC3\x$hexa_conversao")
		fi

		# Mostra a célula atual da tabela
		printf "%${largura_coluna}s\n" "$decimal $hexa $octal $caractere"
	done | zzcolunar -r $num_colunas | zztrim -r
}

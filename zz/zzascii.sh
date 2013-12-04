# ----------------------------------------------------------------------------
# Mostra a tabela ASCII com todos os caracteres imprimíveis (32-126,161-255).
# O formato utilizando é: <decimal> <hexa> <octal> <ascii>.
# O número de colunas e a largura da tabela são configuráveis.
# Uso: zzascii [colunas] [largura]
# Ex.: zzascii
#      zzascii 4
#      zzascii 7 100
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2002-12-06
# Versão: 2
# Licença: GPL
# Requisitos: zzseq
# ----------------------------------------------------------------------------
zzascii ()
{
	zzzz -h ascii "$1" && return

	local referencias decimais decimal hexa octal caractere largura_col
	local num_colunas="${1:-5}"
	local largura="${2:-78}"
	local max_colunas=20
	local max_largura=500
	local linha=0

	# Verificações básicas
	if (
		! zztool testa_numero "$num_colunas" ||
		! zztool testa_numero "$largura" ||
		test "$num_colunas" -eq 0 ||
		test "$largura" -eq 0)
	then
		zztool uso ascii
		return 1
	fi
	if test $num_colunas -gt $max_colunas
	then
		echo "O número máximo de colunas é $max_colunas"
		return 1
	fi
	if test $largura -gt $max_largura
	then
		echo "A largura máxima é de $max_largura"
		return 1
	fi

	decimais=$(zzseq 32 126 ; zzseq 161 255)

	# Cálculos das dimensões da tabela
	local colunas=$(zzseq 0 $((num_colunas - 1)))
	local largura_coluna=$((largura / num_colunas))
	local num_caracteres=$(echo "$decimais" | sed -n '$=')
	local num_linhas=$((num_caracteres / num_colunas + 1))

	# Mostra as dimensões
	echo $num_caracteres caracteres, $num_colunas colunas, $num_linhas linhas, $largura de largura

	# Linha a linha...
	while [ $linha -lt $num_linhas ]
	do
		linha=$((linha+1))

		# Extrai as referências (número da linha dentro do $decimais)
		# para cada caractere que será mostrado nesta linha da tabela.
		# É montado um comando Sed com eles: 5p; 10p; 13p;
		referencias=''
		for col in $colunas
		do
			referencias="$referencias $((num_linhas * col + linha))p;"
		done

		# Usando as referências coletadas, percorre cada decimal
		# que será usado nesta linha da tabela
		for decimal in $(echo "$decimais" | sed -n "$referencias")
		do
			hexa=$( printf '%X'   $decimal)
			octal=$(printf '%03o' $decimal) # NNN
			caractere=$(awk 'BEGIN { printf "%c", '$decimal' }')

			# Na parte extendida da tabela ascii o tamanho do caractere precisa um espaço adicional.
			[ $decimal -ge 161 ] && largura_col=$((largura_coluna+1)) || largura_col=$largura_coluna

			# Mostra a célula atual da tabela
			printf "%${largura_col}s" "$decimal $hexa $octal $caractere"
		done
		echo
	done
}

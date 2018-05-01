# ----------------------------------------------------------------------------
# Divide um texto por uma quantidade máxima de palavras por linha.
# Sem argumento a quantidade padrão é 15
#
# Uso: zzdividirtexto [número]
# Ex.: zzdividirtexto 10
#      zzdividirtexto 3 Um texto para servir de exemplo no teste.
#      cat arquivo.txt | zzdividirtexto
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2016-04-12
# Versão: 1
# Licença: GPL
# Tags: texto, manipulação
# ----------------------------------------------------------------------------
zzdividirtexto ()
{
	zzzz -h dividirtexto "$1" && return

	local palavras=15

	# Definindo a quantidade de palavras por linha
	if zztool testa_numero "$1"
	then
		# Tamanho zero não vale!
		test "$1" -eq 0 && { zztool uso dividirtexto; return 1; }

		palavras=$1
		shift
	fi

	zztool multi_stdin "$@" |
		# O sed separa as palavras cujo delimitador seja espaço ou tabulação.
		# Obs.: ponto, dois-pontos, traço e vírgula não são considerados delimitadores.
		# Então palavra seguida desses caracteres sem espaço na palavra seguinte
		# são considerados uma única palavra.
		sed "s|\(\([^[:blank:]]\{1,\}[[:blank:]]\{1,\}\)\{${palavras}\}\)|\1\\
|g" |
		# O sed deixa o último separador de cada linha no final.
		# Usar a função trim eliminaria esse espaço que pode ser significativo.
		# Então o awk, move o espaço final de uma linha, para o começo da próxima.
		awk '{
			if ( length(incluir) > 0 )  { sub(/^/, incluir); incluir = "" }
			if ( match($0, /[ 	]+$/) ) {
				incluir = substr($0, RSTART, RLENGTH)
				sub(/[ 	]+$/, "")
			}
			print
		}'
}

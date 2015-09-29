# ----------------------------------------------------------------------------
# zzsheldon
# http://the-big-bang-theory.com/quotes/character/Sheldon/
# Exibe aleatoriamente uma frase do Sheldon, do seriado The Big Bang Theory.
# Uso: zzsheldon
# Ex.: zzsheldon
#
# Autor: Jonas Gentina, <jgentina (a) gmail com>
# Desde: 2015-09-25
# Versão: 1
# Licença: GPL
# Requisitos: zzaleatorio
# ----------------------------------------------------------------------------
zzsheldon ()
{
	zzzz -h sheldon "$1" && return

	# Declaracoes locais:
	local url1="http://the-big-bang-theory.com/quotes/character/Sheldon/"
	local url2="http://the-big-bang-theory.com/quotes/character/Sheldon/2/"
	local url3="http://the-big-bang-theory.com/quotes/character/Sheldon/3/"
	local quotes_filename="quotes.txt"
	local begin="Quote\ from\ the\ episode"
	local end="Correct\ this\ quote"

	# Busca as 3 primeiras paginas com os quotes mais populares do Sheldon e salva em arquivo
	# 15 quotes cada pagina, total = 45 quotes:
	$ZZWWWDUMP "$url1" | sed -n "/$begin/,/$end/p" >  "$quotes_filename"
	$ZZWWWDUMP "$url2" | sed -n "/$begin/,/$end/p" >> "$quotes_filename"
	$ZZWWWDUMP "$url3" | sed -n "/$begin/,/$end/p" >> "$quotes_filename"

	# Cria arquivos temporario:
	local temp_file="temp.txt"
	local quotes_temp_file="temp_$quotes_filename"

	# Inicializa o indice:
	echo "0" > "$temp_file"

	# Gera os numeros dos indices:
	sed -n "/$begin/,/$end/p" "$quotes_filename" | sed "/$begin/d" | grep -n "$end" | awk -F: '{print $1}' >> "$temp_file"

	# Extrai os quotes do arquivo para outro arquivo temporario:
	sed -n "/$begin/,/$end/p" "$quotes_filename" | sed "/$begin/d" > "$quotes_temp_file"

	# Numero de quotes para processar:
	local loop=$(wc -l < "$temp_file")

	# Inicializa os contadores:
	local counter=1
	local counter2=1

	# Varre os quotes um a um:
	for ((counter=1;counter<="$loop"-1;counter++))
	do

		# Inicializa o contador 1:
		local counter1=$((counter+1))

		# Obtem as linhas do arquivo temporario:
		local first=$(sed -n "$counter"p "$temp_file")
		local sec=$(sed -n "$counter1"p "$temp_file")

		# Ajustes para extrair somente a parte desejada:
		first=$((first+1))
		sec=$((sec-1))

		# Coloca o conteudo em um array:
		local array_var[counter2]=$(sed -n "$first","$sec"p "$quotes_temp_file")

		# Incrementa o counter2:
		counter2=$((counter2+1))
	done

	# Sorteia um numero aleatorio entre 1 e $loop-1
	local max=$((loop-1))
	local sorteio=$(zzaleatorio 1 "$max")

	# Exibe o quote sorteado:
	echo "${array_var[sorteio]}" | sed '/^[[:space:]]*$/d' | sed 's/^[[:space:]]*//'

	# Remove os arquivos temporarios:
	rm "$quotes_filename" "$temp_file" "$quotes_temp_file"
}

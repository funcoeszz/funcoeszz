#!/bin/bash
# 2013-02-28
# Aurelio Jargas
#
# Gera a versão tudo-em-um para o público

cd "$(dirname "$0")" || exit 1

core="../funcoeszz"
zzdir="../zz"
version=$(grep '^ZZVERSAO=' "$core" | cut -d = -f 2)
output_file="funcoeszz-$version.sh"

echo "Generating funcoeszz version '$version'"
echo

# Generate
{
	# Primeira metade do core, até #@
	sed '/^#@$/q' "$core"
	echo

	# Mostra cada função, inserindo seu nome na linha 2 do cabeçalho
	for zz_arquivo in "${zzdir}"/zz*
	do
		zz_nome=$(basename "$zz_arquivo" .sh)

		sed 1q "$zz_arquivo"
		echo "# $zz_nome"
		sed 1d "$zz_arquivo"

		# Linha em branco separadora
		# Também garante quebra se faltar \n na última linha da função
		echo
	done

	# Desliga suporte ao diretório de funções, forçando que esta seja a
	# versão tudo-em-um
	echo
	echo 'ZZDIR='

	# Segunda metade do core, depois de #@
	sed '1,/^#@$/d' "$core"

} > "$output_file"

chmod +x "$output_file"

ls -l "$output_file"

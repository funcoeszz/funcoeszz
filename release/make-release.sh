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
zzajuda_extra_file='zzajuda.tmp.sh'

echo "Generating funcoeszz version '$version'"
echo

# Reset
> "$zzajuda_extra_file"

# Having this correctly set now is required by the next `source` command
# and later by the zzajuda calls
ZZDIR="$zzdir"

# Load all ZZ functions because we need zzajuda in save_help_text() and
# using `$core zzajuda` there is too slow and expensive
source "$core"

save_help_text() {
	local zz_nome="$1"

	{
		echo
		echo "$zz_nome) cat <<'EOT'"
		zzajuda "$zz_nome"
		echo EOT
		echo ';;'

	} >> "$zzajuda_extra_file"
}

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

		save_help_text "$zz_nome"
	done

	# Desliga suporte ao diretório de funções, forçando que esta seja a
	# versão tudo-em-um
	echo
	echo 'ZZDIR='

	# Segunda metade do core, depois de #@
	sed '1,/^#@$/d' "$core"

} > "$output_file"

# Inject hardcoded help text handling in zzajuda
cp "$output_file" "$output_file.2"
sed "/^#@ajuda$/r $zzajuda_extra_file" "$output_file.2" > "$output_file"
rm "$output_file.2"

# rm "$zzajuda_extra_file"

chmod +x "$output_file"
ls -l "$output_file"

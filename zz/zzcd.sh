# ----------------------------------------------------------------------------
# Mudança de diretório com histórico de mudanças acessível por menu.
# Funcionamento idêntico à função embutida cd, com a diferença que,
# quando chamada sem parâmetros, exibe um menu selecionável
# a partir do histórico de mudanças.
#
# Uso: zzcd [diretório]
#
# Autor: Nilo César Teixeira (nilo.teixeira@gmail.com)
# Desde: 2021-07-07
# Versão: 1
# Requisitos: dirs, pushd
# Tags: cd, mudança de diretórios, histórico, menu de diretórios
# ----------------------------------------------------------------------------

zzcd() {

	# Função auxiliar que muda para um diretório exibido em $(dirs -v),
	# a partir de um parâmetro de pesquisa
	zzcd_auxiliar() {
		local numdir="$1"
		local dirs="$2"
		# Display de $(dirs -v) tem um espaço inicial
		# e dois espaços antes do diretório
		local numdir="$(grep -E "^ $numdir  " <<<"$dirs" | cut -d ' ' -f 2)"
		# Omitindo erro de pilha vazia
		pushd "+$numdir" 2>&1 >/dev/null
	}

	local dirs="$(dirs -v)"

	# Exibição de menu de navegação quando não há parâmetros
	if test $# -eq 0
	then
		local numlinhas=$(wc -l <<< "$dirs")

		# Histórico com apenas uma linha é vazio (representa diretório atual)
		test $numlinhas -eq 1 && return 0

		echo "$dirs"
		echo -n "Ir para número: "
		read numdir

		# Se desistiu (i.e. teclou enter) retorna sem erro
		test "$numdir" = "" && return 0

		# Validando número de linha inteiro
		# https://stackoverflow.com/a/61835747/152016
		if ! (( 10#$numdir >= 0 )) 2>/dev/null; then
			echo "Número de linha inválido: $numdir" >&2
			return 1
		fi
		# Validando número de linha no intervalo correto.
		if [ $numdir -lt 0 -o $numdir -ge $numlinhas ]; then
			echo "Número de linha inválido: $numdir" >&2
			return 1
		fi

		zzcd_auxiliar "$numdir" "$dirs"
	else
		# Resolvendo diretório com realpath (não expandir links simbólicos)
		local diretorio="$(realpath -s "$1")"

		# Teste de existência de histórico (toda a linha)
		local dir_existente="$(grep -E "^ \d+  $diretorio$" <<< "$dirs")"
		if [ "$dir_existente" ]; then
			local numdir_existente=$(grep -oE "^ \d+" <<< "$dir_existente")
			zzcd_auxiliar $numdir_existente "$dirs"
		else
			# Senão pushd do diretório para armazenar histórico, omitindo output
			pushd "$diretorio" >/dev/null
		fi
	fi

	unset zzcd_auxiliar
}

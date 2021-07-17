# ----------------------------------------------------------------------------
# Mudança de diretório com histórico de mudanças acessível por menu.
# Funcionamento idêntico à função embutida cd, com as seguintes diferenças:
#
# 1. Quando chamada sem opção ou parâmetros, exibe o histórico de diretórios,
# com números correspondentes que podem ser usados na navegação
# 2. Quando chamada com a opção -i sem parâmetros, exibe um prompt interativo
# a partir do histórico de diretórios
# 3. Quando chamada com um parâmetro numérico, muda o diretório atual,
# com histórico, para o índice correspondente listado no item 1. acima
#
# Uso: zzcd [ -i | [diretório ou índice do diretório no histórico] ]
# Ex.: zzcd /usr/local/bin, ou zzcd [ índice ], ou zzcd -i
#
# Autor: Nilo César Teixeira (nilo.teixeira@gmail.com)
# Desde: 2021-07-07
# Versão: 1
# Requisitos: dirs pushd
# Tags: cd, mudança de diretórios, histórico, menu de diretórios
# ----------------------------------------------------------------------------
zzcd ()
{

	# Função auxiliar que muda para um diretório exibido em $(dirs -v),
	# a partir de um parâmetro de pesquisa
	zzcd_auxiliar ()
	{
		local dirs numdir

		numdir="$1"
		dirs="$2"
		# Display de $(dirs -v) tem um espaço inicial
		# e dois espaços antes do diretório
		numdir="$(echo "$dirs" | grep -E "^ $numdir  " | cut -d ' ' -f 2)"
		# Omitindo erro de pilha vazia
		pushd "+$numdir" 2>&1 >/dev/null
	}

	# Função auxiliar que valida número de diretório no intervalo de índices
	# do histórico de mudanças.
	zzcd_valida_numlinha ()
	{
		local numdir numlinhas
		numdir="$1"
		numlinhas="$2"

		# Validando número de linha no intervalo correto.
		if test $numdir -lt 0 -o $numdir -ge $numlinhas
		then
			printf %b "Número de linha inválido: $numdir\n" >&2
			return 1
		fi

		return 0
	}

	zzzz -h cd "$1" && return

	local dirs numlinhas
	local diretorio dir_existente numdir indice
	local modo_interativo=0

	# Opções de linha de comando
	if test '-i' = "$1"
	then
		modo_interativo=1
		shift
	elif test "${1#-}" != "$1" -a "$1" != "-"
	then
		printf %b "Opção inválida: $1\n"
		return 1
	fi

	dirs="$(dirs -v)"
	numlinhas=$(echo "$dirs" | wc -l)

	# Exibição de menu de navegação quando não há parâmetros
	if test $# -eq 0
	then
		# Histórico com apenas uma linha é vazio (representa diretório atual)
		test $numlinhas -eq 1 && return 0

		printf %b "$dirs\n"

		if test $modo_interativo -eq 1
		then
			printf %s "Ir para número: "
			read numdir

			# Se desistiu (i.e. teclou enter) retorna sem erro
			test "$numdir" = "" && return 0

			# Validando número de linha inteiro
			if ! zztool testa_numero "$numdir"
			then
				printf %b "Número de linha inválido: $numdir\n" >&2
				return 1
			fi

			# Validando número de linha no intervalo do menu, saindo se errado
			zzcd_valida_numlinha "$numdir" "$numlinhas" || return 1
			zzcd_auxiliar "$numdir" "$dirs"
		fi
	else
		# Parâmetro numérico é considerado índice do menu de histórico
		if zztool testa_numero "$1"
		then
			indice="$1"
			# Validando índice da linha no intervalo do menu, saindo se errado
			zzcd_valida_numlinha $indice $numlinhas || return 1
			zzcd_auxiliar $indice "$dirs"

		# Parâmetro é um diretório
		else
			diretorio="$1"
			# Teste de existência de diretório
			if ! test -e "$diretorio"
			then
				printf %b "Diretório inválido: $diretorio\n"
				return 1
			fi

			# Resolvendo diretório
			diretorio="$(cd "$diretorio" && echo $PWD)"
			dir_existente="${diretorio/$HOME/\~}"

			# Teste de existência de histórico (toda a linha)
			dir_existente="$(grep -E "^ \d+  $dir_existente$" <<< "$dirs")"
			if test "$dir_existente"
			then
				indice=$(grep -oE "^ \d+" <<< "$dir_existente")
				zzcd_auxiliar $indice "$dirs"
			else
				pushd "$diretorio" >/dev/null
			fi
		fi
	fi

	unset zzcd_auxiliar
	unset zzcd_valida_numlinha
}

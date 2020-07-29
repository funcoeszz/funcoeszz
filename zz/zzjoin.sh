# ----------------------------------------------------------------------------
# Junta as linhas de 2 ou mais arquivos, mantendo a sequência.
# Opções:
#  -o <arquivo> - Define o arquivo de saída.
#  -m - Toma como base o arquivo com menos linhas.
#  -M - Toma como base o arquivo com mais linhas.
#  -<numero> - Toma como base o arquivo na posição especificada.
#  -d - Define o separador entre as linhas dos arquivos juntados (padrão TAB).
#
# Sem opção, toma como base o primeiro arquivo declarado.
#
# Uso: zzjoin [-m | -M | -<numero>] [-o <arq>] [-d <sep>] arq1 arq2 [arqN] ...
# Ex.: zzjoin -m arq1 arq2 arq3      # Base no arquivo com menos linhas
#      zzjoin -2 arq1 arq2 arq3      # Base no segundo arquivo
#      zzjoin -o out.txt arq1 arq2   # Juntando para o arquivo out.txt
#      zzjoin -d ":" arq1 arq2       # Juntando linhas separadas por ":"
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-12-05
# Versão: 1
# Licença: GPL
# Tags: arquivo, manipulação
# ----------------------------------------------------------------------------
zzjoin ()
{
	zzzz -h join "$1" && return

	local lin_arq arquivo arq_saida sep
	local linhas=0
	local tipo=1

	# Opção -m ou -M, -numero ou -o
	while test "${1#-}" != "$1"
	do
		if test '-o' = "$1"
		then
			arq_saida="$2"
			shift
		elif test '-d' = "$1"
		then
			sep="$2"
			shift
		else
			tipo="${1#-}"
		fi
		shift
	done

	test -n "$2" || { zztool -e uso join; return 1; }

	for arquivo
	do
		# Especificar se vai se orientar pelo arquivo com mais ou menos linhas
		if test 'm' = "$tipo" || test 'M' = "$tipo"
		then
			lin_arq=$(zztool num_linhas "$arquivo")
			if test 'M' = "$tipo" && test $lin_arq -gt $linhas
			then
				linhas=$lin_arq
			fi
			if test 'm' = "$tipo" && (test $lin_arq -lt $linhas || test $linhas -eq 0)
			then
				linhas=$lin_arq
			fi
		fi

		# Verifica se arquivos são legíveis
		zztool arquivo_legivel "$arquivo" || { zztool erro "Um ou mais arquivos inexistentes ou ilegíveis."; return 1; }
	done

	# Se opção é um numero, o arquivo base para as linhas é o mesmo da posição equivalente
	if zztool testa_numero $tipo && test $tipo -le $#
	then
		arquivo=$(awk -v arg=$tipo 'BEGIN { print ARGV[arg] }' $* 2>/dev/null)
		linhas=$(zztool num_linhas "$arquivo")
	fi

	# Sem quantidade de linhas mínima não há junção.
	test "$linhas" -eq 0 && { zztool erro "Não há linhas para serem \"juntadas\"."; return 1; }

	# Onde a "junção" ocorre efetivamente.
	awk -v linhas_awk=$linhas -v saida_awk="$arq_saida" -v sep_awk="$sep" '
	BEGIN {
		sep_awk = (length(sep_awk)>0 ? sep_awk : "	")

		for (i = 1; i <= linhas_awk; i++) {
			for(j = 1; j < ARGC; j++) {
				if ((getline linha < ARGV[j]) > 0) {
					if (j > 1)
						saida = saida sep_awk linha
					else
						saida = linha
				}
			}
			if (length(saida_awk)>0)
				print saida >> saida_awk
			else
				print saida

			saida = ""
		}
	}' $* 2>/dev/null
}

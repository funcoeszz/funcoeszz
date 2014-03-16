# ----------------------------------------------------------------------------
# Mistura linha a linha 2 ou mais arquivos, mantendo a sequência.
# Opções:
#  -o <arquivo> - Define o arquivo de saida.
#  -m - Toma como base o arquivo com menos linhas.
#  -M - Toma como base o arquivo com mais linhas.
#  -<numero> - Toma como base o arquivo na posição especificada.
#  -p <relação de linhas> - numero de linhas de cada arquivo de origem.
#    Obs1.: A relação são números de linhas de cada arquivo correspondente na
#           sequência, justapostos separados por vírgula (,).
#    Obs2.: Se a quantidade de linhas na relação for menor que a quantidade de
#           arquivos, os arquivos excedentes adotam a último valor na relação.
#
# Sem opção, toma como base o primeiro arquivo declarado.
#
# Uso: zzmix [-m | -M | -<numero>] [-o <arq>] [-p <relação>] arquivo1 arquivo2 [arquivoN] ...
# Ex.: zzmix -m arquivo1 arquivo2 arquivo3  # Base no arquivo com menos linhas
#      zzmix -2 arquivo1 arquivo2 arquivo3  # Base no segundo arquivo
#      zzmix -o out.txt arquivo1 arquivo2   # Mixando para o arquivo out.txt
#      zzmix -p 2,5,6 arq1 arq2 arq3
#       2 linhas do arq1, 5 linhas do arq2 e 3 linhas do arq3,
#       e repete a seqUência até o final.
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-11-01
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
zzmix ()
{
	zzzz -h mix "$1" && return

	local lin_arq arquivo arq_saida arq_ref
	local passos=1
	local linhas=0
	local tipo=1

	# Opção -m ou -M, -numero ou -o
	while [ "${1#-}" != "$1" ]
	do
		if test "$1" = "-o"
		then
			arq_saida="$2"
			shift
		elif test "$1" = "-p"
		then
			passos="$2"
			shift
		else
			tipo="${1#-}"
		fi
		shift
	done

	[ "$2" ] || { zztool uso mix; return 1; }

	for arquivo
	do
		# Especificar se vai se orientar pelo arquivo com mais ou menos linhas
		if test "$tipo" = "m" || test "$tipo" = "M"
		then
			lin_arq=$(zztool num_linhas "$arquivo")
			if test "$tipo" = "M" && test $lin_arq -gt $linhas
			then
				linhas=$lin_arq
				arq_ref=$arquivo
			fi
			if test "$tipo" = "m" && (test $lin_arq -lt $linhas || test $linhas -eq 0)
			then
				linhas=$lin_arq
				arq_ref=$arquivo
			fi
		fi

		# Verifica se arquivos são legíveis
		zztool arquivo_legivel "$arquivo" || { zztool eco "Um ou mais arquivos inexistentes ou ilegíveis."; return 1; }
	done

	# Se opção é um numero, o arquivo base para as linhas é o mesmo da posição equivalente
	if zztool testa_numero $tipo && test $tipo -le $#
	then
		arquivo=$(awk -v arg=$tipo 'BEGIN { print ARGV[arg] }' $* 2>/dev/null)
		linhas=$(zztool num_linhas "$arquivo")
	fi

	# Sem quantidade de linhas mínima não há mistura.
	[ "$linhas" -eq 0 ] && { zztool eco "Não há linhas para serem \"mixadas\"."; return 1; }

	# Onde a "mixagem" ocorre efetivamente.
	awk -v linhas_awk=$linhas -v passos_awk="$passos" -v arq_ref_awk="$arq_ref" -v saida_awk="$arq_saida" '
	BEGIN {
		qtde_passos = split(passos_awk, passo, ",")

		if (qtde_passos < ARGC)
		{
			ultimo_valor = passo[qtde_passos]
			for (i = qtde_passos+1; i <= ARGC; i++) {
				passo[i] = ultimo_valor
			}
		}

		div_linhas = 1
		for (i = 1; i <= ARGC-1; i++) {
			if (arq_ref_awk == ARGV[i]) {
				div_linhas = passo[i]
			}
		}

		bloco_linhas=int(linhas_awk/div_linhas) + (linhas_awk/div_linhas==int(linhas_awk/div_linhas)?0:1)

		for (i = 1; i <= bloco_linhas; i++) {
			for(j = 1; j < ARGC; j++) {
				for (k = 1; k <= passo[j]; k++)
				{
					if ((getline linha < ARGV[j]) > 0) {
						if (length(saida_awk)>0)
							print linha >> saida_awk
						else
							print linha
					}
				}
			}
		}
	}' $* 2>/dev/null
}

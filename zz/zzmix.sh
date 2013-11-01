# ----------------------------------------------------------------------------
# Mistura linha a linha 2 ou mais arquivos, mantendo a sequência.
# Opções:
#  -m - Toma como base o arquivo com menos linhas.
#  -M - Toma como base o arquivo com mais linhas.
#  -<numero> - Toma como base o arquivo na posição especificada.
#
# Sem opção, toma como base o primeiro arquivo declarado.
#
# Uso: zzmix [-m | -M | -<numero>] arquivo1 arquivo2 [arquivoN] ...
# Ex.: zzmix -m arquivo1 arquivo2 arquivo3 # Base no arquivo com menos linhas
#      zzmix -2 arquivo1 arquivo2 arquivo3 # Base no segundo arquivo
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-11-01
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzmix ()
{
	zzzz -h mix "$1" && return

	local lin_arq arquivo
	local linhas=0
	local tipo=1

	# Opção -m ou -M, ou -numero
	while [ "${1#-}" != "$1" ]
	do
		tipo="${1#-}"
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
			fi
			if test "$tipo" = "m" && (test $lin_arq -lt $linhas || test $linhas -eq 0)
			then
				linhas=$lin_arq
			fi
		fi

		# Verifica se arquivos são legíveis
		zztool arquivo_legivel "$arquivo" || return 1
	done

	# Se opção é um numero, o arquivo base para as linhas é o mesmo da posição equivalente
	if zztool testa_numero $tipo
	then
		arquivo=$(awk -v arg=$tipo 'BEGIN { print ARGV[arg] }' $* 2>/dev/null)
		linhas=$(zztool num_linhas "$arquivo")
	fi

	# Sem quantidade de linhas mínima não há mistura.
	[ "$linhas" -eq 0 ] && return 1

	awk -v linhas_awk=$linhas '
	BEGIN {
		for (i=1; i<=linhas_awk; i++) {
			for(j=1;j<ARGC;j++) {
				if ((getline linha < ARGV[j]) > 0) print linha
			}
		}
	}' $* 2>/dev/null
}

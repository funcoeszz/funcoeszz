# ----------------------------------------------------------------------------
# Trocar linhas e colunas de um arquivo, fazendo uma simples transposição.
# Opções:
#	-d, --fs separador   define o separador de campos na entrada.
#	--ofs separador      define o separador de campos na saída.
#
# O separador na entrada pode ser 1 ou mais caracteres ou uma ER.
# Se não for declarado assume-se espaços em branco como separador.
# Conforme padrão do awk, o default seria FS = "[ \t]+".
#
# Se o separador de saída não for declarado, assume o mesmo da entrada.
# Caso a entrada também não seja declarada assume-se como um espaço.
# Conforme padrão do awk, o default é OFS = " ".
#
# Se o separador da entrada é uma ER, é bom declarar o separador de saída.
#
# Uso: zztranspor [-d | --fs <separador>] [--ofs <separador>] <arquivo>
# Ex.: zztranspor -d ":" --ofs "-" num.txt
#      sed -n '2,5p' num.txt | zztranspor --fs '[\t:]' --ofs '\t'
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-09-03
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zztranspor ()
{
	zzzz -h transpor "$1" && return

	local sep ofs

	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-d | --fs)
			# Separador de campos no arquivo de entrada
				sep="$2"
				shift
				shift
			;;
			--ofs)
			# Separador de campos na saída
				ofs="$2"
				shift
				shift
			;;
			*) break;;
		esac
	done

	zztool file_stdin "$@" |
	awk -v sep_awk="$sep" -v ofs_awk="$ofs" '
	BEGIN {
		# Definindo o separador de campo na entrada do awk
		if (length(sep_awk)>0)
			FS = sep_awk

		# Definindo o separador de campo na saída do awk
		ofs_awk = (length(ofs_awk)>0?ofs_awk:FS)
	}

	{
		# Descobrindo a maior quantidade de campos
		if (max_nf < NF)
			max_nf = NF

		# Criando um array indexado por número do campo e número da linha, nessa ordem
		for (i = 1; i <= NF; i++)
			vetor[i, NR] = $i
	}

	END {
		# Transformando o campo em linha
		for (i = 1; i <= max_nf; i++) {
			# Transformando a linha em campo
			for (j = 1; j <= NR; j++)
				linha = sprintf("%s%s%s", linha, vetor[i, j], ofs_awk)

			# Tirando o separador ao final da linha
			print substr(linha, 1, length(linha) - length(ofs_awk))

			# Limpando a variável para a próxima iteração
			linha=""
		}
	}' | sed 's/ *$//g'
}

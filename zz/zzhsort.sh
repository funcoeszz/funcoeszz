# ----------------------------------------------------------------------------
# Ordenar palavras ou números horizontalmente.
# Opções:
#   -r                   define o sentido da ordenação reversa.
#   -d, --fs separador   define o separador de campos na entrada.
#   --ofs separador      define o separador de campos na saída.
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
# Uso: zzhsort [-d | --fs <separador>] [--ofs <separador>] <Texto>
# Ex.: zzhsort "isso está desordenado"            # desordenado está isso
#      zzhsort -r -d ":" --ofs "-" "1:a:z:x:5:o"  # z-x-o-a-5-1
#      cat num.txt | zzhsort --fs '[\t:]' --ofs '\t'
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2015-10-07
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzhsort ()
{
	zzzz -h hsort "$1" && return

	local sep ofs
	local direcao="n"

	while test "${1#-}" != "$1"
	do
		case "$1" in
			-d | --fs)
			# Separador de campos na entrada
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
			-r)
			# Ordenar decrescente
				direcao="r"
				shift
			;;
			-*) zztool -e uso hsort; return 1;;
			*) break;;
		esac
	done

	zztool multi_stdin "$@" |
	awk -v sep_awk="$sep" -v ofs_awk="$ofs" -v dir_awk="$direcao" '
	BEGIN {
		# Definindo o separador de campo na entrada do awk.
		if (length(sep_awk)>0)
			FS = sep_awk

		# Definindo o separador de campo na saída do awk.
		OFS = (length(ofs_awk)>0?ofs_awk:FS)

		# IGNORECASE não é suportado por todas as versões de awk.
		# mas declarar essa variável não afetará as versões que não a suportam.
		# Sem essa opção, maiúsculas antecedem as minúsculas.
		IGNORECASE = 1
	}

	{
		split("",a)
		for ( k=1; k<=NF; k++ ) { a[$k] = $k }
		asort(a)
		for ( k=1; k<=NF; k++ ) { $k=a[(dir_awk=="r"?NF-k+1:k)] }
		print
	}'
}

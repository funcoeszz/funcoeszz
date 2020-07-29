# ----------------------------------------------------------------------------
# Ordenar palavras ou números horizontalmente.
# Opções:
#   -r                              define o sentido da ordenação reversa.
#   -d <sep>                        define o separador de campos na entrada.
#   -D, --output-delimiter <sep>  define o separador de campos na saída.
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
# Uso: zzhsort [-d <sep>] [-D | --output-delimiter <sep>] <Texto>
# Ex.: zzhsort "isso está desordenado"            # desordenado está isso
#      zzhsort -r -d ":" -D "-" "1:a:z:x:5:o"  # z-x-o-a-5-1
#      cat num.txt | zzhsort -d '[\t:]' --output-delimiter '\t'
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2015-10-07
# Versão: 2
# Licença: GPL
# Requisitos: zztranspor
# Tags: texto, manipulação
# ----------------------------------------------------------------------------
zzhsort ()
{
	zzzz -h hsort "$1" && return

	local sep ofs direcao

	while test "${1#-}" != "$1"
	do
		case "$1" in
			-d)
			# Separador de campos na entrada
				sep="-d $2"
				shift
				shift
			;;
			-D | --output-delimiter)
			# Separador de campos na saída
				ofs="-D $2"
				shift
				shift
			;;
			-r)
			# Ordenar decrescente
				direcao="-r"
				shift
			;;
			--) shift; break;;
			-*) zztool -e uso hsort; return 1;;
			*) break;;
		esac
	done

	zztool multi_stdin "$@" |
	while read linha
	do
		if test -z "$linha"
		then
			echo
		else
			echo "$linha" |
			zztranspor $sep |
			sort -n $direcao |
			zztranspor $sep $ofs
		fi
	done
}

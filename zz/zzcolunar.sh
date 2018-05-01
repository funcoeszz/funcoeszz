# ----------------------------------------------------------------------------
# Transforma uma lista simples, em uma lista de múltiplas colunas.
# É necessário informar a quantidade de colunas como argumento.
#
# Mas opcionalmente pode informar o formato da distribuição das colunas:
# -z:
#   1  2  3
#   4  5  6
#   7  8  9
#   10
#
# -n: (padrão)
#   1  5  9
#   2  6  10
#   3  7
#   4  8
#
# As opções -l, --left, -e, --esquerda alinham as colunas a esquerda (padrão).
# As opções -r, --right, -d, --direita alinham as colunas a direita.
# As opções -c, --center, --centro centralizam as colunas.
# A opção -j justifica as colunas.
#
# As opções -H ou --header usa a primeira linha como cabeçalho,
# repetindo-a no início de cada coluna.
#
# As opções -w, --width, --largura seguido de um número,
# determinam a largura que as colunas terão.
#
# A opção -s seguida de um TEXTO determina o separador de colunas,
# se não for declarado assume por padrão um espaço simples.
#
# Uso: zzcolunar [-n|-z] [-H] [-l|-r|-c|-j] [-w <largura>] <colunas> arquivo
# Ex.: zzcolunar 3 arquivo.txt
#      zzcolunar -c -w 20 5 arquivo.txt
#      cat arquivo.txt | zzcolunar -z 4
#      zzcolunar --header 3 arquivo.txt
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2014-04-24
# Versão: 5
# Licença: GPL
# Requisitos: zzalinhar zztrim
# Tags: texto, manipulação
# ----------------------------------------------------------------------------
zzcolunar ()
{
	zzzz -h colunar "$1" && return

	test -n "$1" || { zztool -e uso colunar; return 1; }

	local formato='n'
	local alinhamento='-l'
	local largura=0
	local header=0
	local sep=' '
	local colunas

	while test "${1#-}" != "$1"
	do
		case "$1" in
		-[nN])                         formato='n';      shift ;;
		-[zZ])                         formato='z';      shift ;;
		-H | --header)                 header=1;         shift ;;
		-l | --left | -e | --esqueda)  alinhamento='-l'; shift ;;
		-r | --right | -d | --direita) alinhamento='-r'; shift ;;
		-c | --center | --centro)      alinhamento='-c'; shift ;;
		-j)                            alinhamento='-j'; shift ;;
		-s)                            sep="$2";  shift; shift ;;
		-w | --width | --largura)
			zztool testa_numero "$2" && largura="$2" || { zztool erro "Largura inválida: $2"; return 1; }
			shift
			shift
		;;
		--) shift; break;;
		-*) zztool erro "Opção inválida: $1"; return 1 ;;
		*) break;;
		esac
	done

	if zztool testa_numero "$1"
	then
		colunas="$1"
		shift
	else
		zztool erro "Quantidade de colunas inválidas";
		zztool -e uso colunar
		return 1
	fi

	zztool file_stdin "$@" |
	zzalinhar -w $largura ${alinhamento} |
	awk -v cols=$colunas -v formato=$formato -v cab=$header -v delim="$sep" '

		NR==1 { if (cab) header = $0 }

		{ linha[NR - cab] = $0 }

		END {
			lin = ( int((NR-cab)/cols)==((NR-cab)/cols) ? (NR-cab)/cols : int((NR-cab)/cols)+1 )

			if (cab) {
				for ( j = 1; j <= cols; j++ ) { printf header (j<cols ? delim : "") }
				print ""
			}

			# Formato N ( na verdade é И )
			if (formato == "n") {
				for ( i=1; i <= lin; i++ ) {
					linha_saida = ""

					for ( j = 0; j < cols; j++ ) {
							if ( i + (j * lin ) <= NR )
								linha_saida = linha_saida (j==0 ? "" : delim) linha[ i + ( j * lin ) ]
					}

					print linha_saida
				}
			}

			# Formato Z
			if (formato == "z") {
				i = 1
				while ( i <= NR )
				{
					for ( j = 1; j <= cols; j++ ) {
						if ( i <= NR )
							linha_saida = linha_saida (j==1 ? "" : delim) linha[i]

						if (j == cols || i == NR) {
							print linha_saida
							linha_saida = ""
						}

						i++
					}
				}
			}
		}
	' | zztrim -V |
	if test "$sep" != ' '
	then
		sed "s/${sep}$//"
	else
		cat -
	fi |
	zztrim -r
}

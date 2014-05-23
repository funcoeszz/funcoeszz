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
# As opções -l, --left, -e, --esqueda alinham as colunas a esquerda (padrão).
# As opções -r, --right, -d, --direita alinham as colunas a direita.
# As opções -c, --center, --centro centralizam as colunas.
#
# As opções -w, --width, --largura seguido de um número,
# determinam a largura que as colunas terão.
#
# Uso: zzcolunar [-n|-z] [-l|-r|-c] [-w <largura>] <colunas> arquivo
# Ex.: zzcolunar 3 arquivo.txt
#      zzcolunar -c -w 20 5 arquivo.txt
#      cat arquivo.txt | zzcolunar -z 4
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2014-04-24
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzcolunar ()
{
	zzzz -h colunar "$1" && return

	[ "$1" ] || { zztool uso colunar; return 1; }

	local formato='n'
	local alinhamento='l'
	local largura=0
	local colunas

	while test "${1#-}" != "$1"
	do
		case "$1" in
		-[nN]) formato='n' ;;
		-[zZ]) formato='z';;
		-l | --left | -e | --esqueda)  alinhamento='l' ;;
		-r | --right | -d | --direita) alinhamento='r' ;;
		-c | --center | --centro)      alinhamento='c' ;;
		-w | --width | --largura)
			zztool testa_numero "$2" && largura="$2" || { zztool eco "Largura inválida: $2"; return 1; }
			shift
		;;
		-*) zztool eco "Opção inválida: $1"; return 1 ;;
		*) break;;
		esac
		shift
	done

	if zztool testa_numero "$1"
	then
		colunas="$1"
		shift
	else
		zztool uso colunar
		return 1
	fi

	zztool file_stdin "$@" |
	awk -v cols=$colunas -v formato=$formato -v larg=$largura -v align=$alinhamento '

		function celula(informacao, tam1, align1,  espacos, i) {
			if (length(informacao) <= tam)
			{
				espacos = ""
				if (align1 == "c" && length(informacao) < tam) {
					for (i=1;i<=(tam1 - length(informacao))/2;i++) {
						espacos = " " espacos
					}
				}
				return espacos informacao
			}
			else
				return substr(informacao, 1, tam1)
		}

		BEGIN { tam = larg }

		{
			linha[NR] = $0
			tam = ( length($0) > tam && larg == 0 ? length($0) : tam )
		}

		END {
			lin = ( int(NR/cols)==(NR/cols) ? NR/cols : int(NR/cols)+1 )
			sinal = (align=="r" ? "+" : "-")

			# Formato N ( na verdade é И )
			if (formato == "n") {
			for ( i=1; i <= lin; i++ ) {
						for ( j = 0; j < cols; j++ ) {
								eol = ( j == ( cols - 1 ) ? "\n" : " " )
								eol = ( i + (j * lin ) >= NR ? "\n" : eol )
								if ( i + (j * lin ) > NR )
									print ""
								else
									printf "%" sinal tam "s" eol, celula(linha[ i + ( j * lin ) ], tam, align)
						}
				}
			}

			# Formato Z
			if (formato == "z") {
				i = 1
				while ( i <= NR )
				{
					for ( j = 1; j <= cols; j++ ) {
						eol = ( j == cols || i == NR ? "\n" : " " )
						if ( i <= NR ) {
							printf "%" sinal tam "s" eol, celula(linha[i], tam, align)
						}
						i++
					}
				}
			}
		}
	'
}

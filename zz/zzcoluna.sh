# ----------------------------------------------------------------------------
# Transforma uma lista simples, em uma lista de múltiplas colunas.
# É necessário informar a quantidade de colunas como primeiro argumento.
#
# Como segundo argumento pode-se definir a ordem da listagem por:
# Z:
#   1  2  3
#   4  5  6
#   7  8  9
#   10
#
# N: (padrão)
#   1  5  9
#   2  6  10
#   3  7
#   4  8
#
# Uso: zzcoluna <colunas> [ n | z ] arquivo
# Ex.: zzcoluna 3 arquivo.txt
#      cat arquivo.txt | zzcoluna 4 z
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2014-04-24
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzcoluna ()
{
	zzzz -h coluna "$1" && return

	[ "$1" ] || { zztool uso coluna; return 1; }

	local colunas formato

	if zztool testa_numero "$1"
	then
		colunas="$1"
		shift
	else
		zztool uso coluna
		return 1
	fi

	formato=$(echo ${1:-N} | tr 'A-Z' 'a-z')

	test "$formato" = "n" -o "$formato" = "z" && shift || formato="n"

	zztool file_stdin "$@" |
	awk -v cols=$colunas -v formato=$formato '
		BEGIN { tam = 0 }

		{
			linha[NR] = $0
			tam = ( length($0) > tam ? length($0) : tam )
		}

		END {
			lin = ( int(NR/cols)==(NR/cols) ? NR/cols : int(NR/cols)+1 )

			# Formato N ( na verdade é И )
			if (formato == "n") {
			for ( i=1; i <= lin; i++ ) {
						for ( j = 0; j < cols; j++ ) {
								eol = ( j == ( cols - 1 ) ? "\n" : " " )
								eol = ( i + (j * lin ) >= NR ? "\n" : eol )
								if ( i + (j * lin ) > NR )
									print ""
								else
									printf "%-"tam"s"eol, linha[ i + ( j * lin ) ]
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
							printf "%-"tam"s"eol, linha[i]
						}
						i++
					}
				}
			}
		}
	'
}

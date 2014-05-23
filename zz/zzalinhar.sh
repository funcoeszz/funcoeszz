# ----------------------------------------------------------------------------
# Alinha um texto a esquerda, direita, centro ou justificado.
#
# As opções -l, --left, -e, --esqueda alinham as colunas a esquerda (padrão).
# As opções -r, --right, -d, --direita alinham as colunas a direita.
# As opções -c, --center, --centro centralizam as colunas.
# A opção -j, --justify, --justificar faz o texto ocupar toda a linha.
#
# As opções -w, --width, --largura seguido de um número,
# determinam o tamanho da largura como base ao alinhamento.
# Obs.: Se a largura original for maior é truncada no limite fornecido.
#
# Uso: zzalinhar [-l|-r|-c|-j] [-w <largura>] arquivo
# Ex.: zzalinhar arquivo.txt
#      zzalinhar -c -w 20 arquivo.txt
#      zzalinhar -j arquivo.txt
#      cat arquivo.txt | zzalinhar -r
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2014-05-23
# Versão: 1
# Licença: GPL
# Requisitos: zzcolunar
# ----------------------------------------------------------------------------
zzalinhar ()
{
	zzzz -h alinhar "$1" && return

	test -n "$1" || { zztool uso alinhar; return 1; }

	local alinhamento='l'
	local largura=0

	while test "${1#-}" != "$1"
	do
		case "$1" in
		-l | --left | -e | --esqueda)  alinhamento='l' ;;
		-r | --right | -d | --direita) alinhamento='r' ;;
		-c | --center | --centro)      alinhamento='c' ;;
		-j | --justify | --justificar) alinhamento='j' ;;
		-w | --width | --largura)
			zztool testa_numero "$2" && largura="$2" || { zztool eco "Largura inválida: $2"; return 1; }
			shift
		;;
		-*) zztool eco "Opção inválida: $1"; return 1 ;;
		*) break;;
		esac
		shift
	done

	zztool file_stdin "$@" | zztool trim |
	if test $alinhamento != 'j'
	then
		zzcolunar -$alinhamento -w $largura 1
	else
		zzcolunar -l -w $largura 1 | zztool trim |
		awk -v larg=$largura '
		function juntar(  str_saida, j) {
			str_saida=""
			for ( j=1; j<=length(campos); j++ ) {
				str_saida = str_saida campos[j] espacos[j]
			}
			sub(/ *$/, "", str_saida)
			return str_saida
		}
		function aumentar() {
			espacos[pos_atual] = espacos[pos_atual] " "
			pos_atual--
			pos_atual = pos_atual == 0 ? qtde : pos_atual
		}

		{ linha[NR] = $0; larg = ( length > larg ? length : larg ) }

		END {
			for (i=1; i<=NR; i++) {
				if (length(linha[i]) == larg) { print linha[i] }
				else {
					split("", campos)
					split("", espacos)
					qtde = split(linha[i], campos, " ", espacos)
					if ( qtde <= 1 ) { print linha[i] }
					else {
						pos_atual = qtde - 1
						saida = juntar()
						while ( length(saida) < larg ) {
							aumentar()
							saida = juntar()
						}
						print saida
					}
				}
			}
		}
		'
	fi
}

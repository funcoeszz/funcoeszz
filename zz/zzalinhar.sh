# ----------------------------------------------------------------------------
# Alinha um texto a esquerda, direita, centro ou justificado.
#
# As opções -l, --left, -e, --esquerda alinham as colunas a esquerda (padrão).
# As opções -r, --right, -d, --direita alinham as colunas a direita.
# As opções -c, --center, --centro centralizam as colunas.
# A opção -j, --justify, --justificar faz o texto ocupar toda a linha.
#
# As opções -w, --width, --largura seguido de um número,
# determinam o tamanho da largura como base ao alinhamento.
# Obs.: Onde a largura é maior do que a informada não é aplicado alinhamento.
#
# Uso: zzalinhar [-l|-e|-r|-d|-c|-j] [-w <largura>] arquivo
# Ex.: zzalinhar arquivo.txt
#      zzalinhar -c -w 20 arquivo.txt
#      zzalinhar -j arquivo.txt
#      cat arquivo.txt | zzalinhar -r
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2014-05-23
# Versão: 4
# Licença: GPL
# Requisitos: zzpad zztrim zzwc
# Tags: texto, manipulação
# ----------------------------------------------------------------------------
zzalinhar ()
{
	zzzz -h alinhar "$1" && return

	local alinhamento='r'
	local largura=0
	local larg_efet linha cache

	while test "${1#-}" != "$1"
	do
		case "$1" in
		-l | --left | -e | --esqueda)  alinhamento='r'; shift ;;
		-r | --right | -d | --direita) alinhamento='l'; shift ;;
		-c | --center | --centro)      alinhamento='c'; shift ;;
		-j | --justify | --justificar) alinhamento='j'; shift ;;
		-w | --width | --largura)
			zztool testa_numero "$2" && largura="$2" || { zztool erro "Largura inválida: $2"; return 1; }
			shift; shift
		;;
		--) shift; break ;;
		-*) zztool erro "Opção inválida: $1"; return 1 ;;
		*) break;;
		esac
	done

	cache=$(zztool mktemp alinhar)

	zztool file_stdin -- "$@" > "$cache"

	test $(zztrim "$cache" | zzwc -l) -gt 0 || return 1

	larg_efet=$(zzwc -L "$cache")

	test "$largura" -eq 0 -a "${larg_efet:-0}" -gt "$largura" && largura=$larg_efet

	case $alinhamento in
	'j')
		cat "$cache" |
		zztrim -H |
		sed 's/"/\\"/g' | sed "s/'/\\'/g" |
		awk -v larg=$largura '
			# Função para unir os campos e os separadores de campos(" ")
			function juntar(qtde_campos,  str_saida, j) {
				str_saida=""
				for ( j=1; j<=qtde_campos; j++ ) {
					str_saida = str_saida campos[j] espacos[j]
				}
				sub(/ *$/, "", str_saida)
				return str_saida
			}

			# Função que aumenta a quantidade de espaços intermadiários
			function aumentar_int() {
				espacos[pos_atual] = espacos[pos_atual] " "
				pos_atual--
				pos_atual = (pos_atual == 0 ? qtde : pos_atual)
			}

			# Função para determinar tamanho da string sem erros com codificação
			function tam_linha(entrada,  saida, comando)
			{
				comando = ("echo \"" entrada "\" | wc -m")
				comando | getline saida
				close(comando)
				return saida-1
			}

			{
				# Guardando as linhas em um array
				linha[NR] = $0
			}

			END {
				for (i=1; i<=NR; i++) {
					if (tam_linha(linha[i]) == larg) { print linha[i] }
					else {
						split("", campos)
						split("", espacos)
						qtde = split(linha[i], campos)
						for (x in campos) {
							espacos[x] = " "
						}
						if ( qtde <= 1 ) { print linha[i] }
						else {
							pos_atual = qtde - 1
							saida = juntar(qtde)
							while ( tam_linha(saida) < larg ) {
								aumentar_int()
								saida = juntar(qtde)
							}
							print saida
						}
					}
				}
			}
		' | sed 's/\\"/"/g'
	;;
	*)
		test "$alinhamento" = "c" && alinhamento="a"

		cat "$cache" |
		zztrim -H |
		zzpad -${alinhamento} "$largura" 2>/dev/null
	;;
	esac

	rm -f "$cache"
}

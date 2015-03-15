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
# Versão: 3
# Licença: GPL
# Requisitos: zzpad zztrim
# ----------------------------------------------------------------------------
zzalinhar ()
{
	zzzz -h alinhar "$1" && return

	local cache=$(zztool cache alinhar)
	local alinhamento='r'
	local largura=0
	local larg_efet linha

	while test "${1#-}" != "$1"
	do
		case "$1" in
		-l | --left | -e | --esqueda)  alinhamento='r' ;;
		-r | --right | -d | --direita) alinhamento='l' ;;
		-c | --center | --centro)      alinhamento='c' ;;
		-j | --justify | --justificar) alinhamento='j' ;;
		-w | --width | --largura)
			zztool testa_numero "$2" && largura="$2" || { zztool erro "Largura inválida: $2"; return 1; }
			shift
		;;
		-*) zztool erro "Opção inválida: $1"; return 1 ;;
		*) break;;
		esac
		shift
	done

	zztool file_stdin "$@" > $cache

	larg_efet=$(
		cat "$cache" |
		while read linha
		do
			echo ${#linha}
		done |
		sort -nr |
		head -1
	)

	test $largura -eq 0 -a $larg_efet -gt $largura && largura=$larg_efet

	case $alinhamento in
	'j')
		cat "$cache" |
		zztrim -H |
		sed 's/"/\\"/g' | sed "s/'/\\'/g" |
		awk -v larg=$largura '
			# Função para unir os campos e os separadores de campos(" ")
			function juntar(  str_saida, j) {
				str_saida=""
				for ( j=1; j<=length(campos); j++ ) {
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
						qtde = split(linha[i], campos, " ", espacos)
						if ( qtde <= 1 ) { print linha[i] }
						else {
							pos_atual = qtde - 1
							saida = juntar()
							while ( tam_linha(saida) < larg ) {
								aumentar_int()
								saida = juntar()
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
		zzpad -${alinhamento} $largura
	;;
	esac

	zztool cache rm alinhar
}

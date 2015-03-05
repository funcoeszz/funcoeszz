# ----------------------------------------------------------------------------
# Apaga brancos (" " \t \n) ao redor do texto: direita, esquerda, cima, baixo.
# Obs.: Linhas que só possuem espaços e tabs são consideradas em branco.
#
# Opções:
#   -t, --top       Apaga as linhas em branco do início do texto
#   -b, --bottom    Apaga as linhas em branco do final do texto
#   -l, --left      Apaga os brancos do início de todas as linhas
#   -r, --right     Apaga os brancos do final de todas as lihas
#   --vertical      Apaga as linhas em branco do início e final (-t -b)
#   --horizontal    Apaga os brancos do início e final das linhas (-l -r)
#
# Uso: zztrim [texto]
# Ex.: zztrim "   foo bar   "           # "foo bar"
#      zztrim -l "   foo bar   "        # "foo bar   "
#      zztrim -r "   foo bar   "        # "   foo bar"
#      echo "   foo bar   " | zztrim    # "foo bar"
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2015-03-05
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zztrim ()
{
	zzzz -h trim "$1" && return

	local filter top bottom left right

	# Comandos sed para apagar os brancos
	local delete_top='/[^[:blank:]]/,$!d;'
	local delete_left='s/^[[:blank:]]*//;'
	local delete_right='s/[[:blank:]]*$//;'
	local delete_bottom='
		:loop
		/^[[:space:]]*$/ {
			$ d
			N
			b loop
		}
	'

	# Opções de linha de comando
	while test "${1#-}" != "$1"
	do
		case "$1" in
			-l | --left  ) shift; left=1;;
			-r | --right ) shift; right=1;;
			-t | --top   ) shift; top=1;;
			-b | --bottom) shift; bottom=1;;
			--horizontal ) shift; left=1; right=1;;
			--vertical   ) shift; top=1; bottom=1;;
			--*          ) echo "Opção inválida $1"; return 1;;
			*            ) break;;
		esac
	done

	# Comportamento padrão, quando nenhuma opção foi informada
	if test -z "$top$bottom$left$right"
	then
		top=1
		bottom=1
		left=1
		right=1
	fi

	# Compõe o filtro sed de acordo com as opções ativas
	# Nota: a ordem importa, não altere.
	test -n "$left"   && filter="$filter$delete_left"
	test -n "$right"  && filter="$filter$delete_right"
	test -n "$top"    && filter="$filter$delete_top"
	test -n "$bottom" && filter="$filter$delete_bottom"

	# Aplica o filtro, com dados via STDIN ou argumentos
	zztool multi_stdin "$@" | sed "$filter"
}

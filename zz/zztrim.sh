# ----------------------------------------------------------------------------
# Apaga brancos (" " \t \n) ao redor do texto: direita, esquerda, cima, baixo.
# Obs.: Linhas que só possuem espaços e tabs são consideradas em branco.
#
# Opções:
#   -t, --top         Apaga as linhas em branco do início do texto
#   -b, --bottom      Apaga as linhas em branco do final do texto
#   -l, --left        Apaga os brancos do início de todas as linhas
#   -r, --right       Apaga os brancos do final de todas as linhas
#   -V, --vertical    Apaga as linhas em branco do início e final (-t -b)
#   -H, --horizontal  Apaga os brancos do início e final das linhas (-l -r)
#
# Uso: zztrim [opções] [texto]
# Ex.: zztrim "   foo bar   "           # "foo bar"
#      zztrim -l "   foo bar   "        # "foo bar   "
#      zztrim -r "   foo bar   "        # "   foo bar"
#      echo "   foo bar   " | zztrim    # "foo bar"
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2015-03-05
# Versão: 3
# Licença: GPL
# Tags: trim, emulação
# ----------------------------------------------------------------------------
zztrim ()
{
	zzzz -h trim "$1" && return

	local top left right bottom
	local delete_top delete_left delete_right delete_bottom

	# Opções de linha de comando
	while test "${1#-}" != "$1"
	do
		case "$1" in
			-l | --left      ) shift; left=1;;
			-r | --right     ) shift; right=1;;
			-t | --top       ) shift; top=1;;
			-b | --bottom    ) shift; bottom=1;;
			-H | --horizontal) shift; left=1; right=1;;
			-V | --vertical  ) shift; top=1; bottom=1;;
			--*) zztool erro "Opção inválida $1"; return 1;;
			*) break;;
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

	# Compõe os comandos sed para apagar os brancos,
	# levando em conta quais são as opções ativas
	test -n "$top"    && delete_top='/[^[:blank:]]/,$!d;'
	test -n "$left"   && delete_left='s/^[[:blank:]]*//;'
	test -n "$right"  && delete_right='s/[[:blank:]]*$//;'
	test -n "$bottom" && delete_bottom='
		:loop
		/^[[:space:]]*$/ {
			$ d
			N
			b loop
		}
	'

	# Dados via STDIN ou argumentos
	zztool multi_stdin "$@" |
		# Aplica os filtros
		sed "$delete_top $delete_left $delete_right" |
		# Este deve vir sozinho, senão afeta os outros (comando N)
		sed "$delete_bottom"

		# Nota: Não há problema se as variáveis estiverem vazias,
		#       sed "" é um comando nulo e não fará alterações.
}

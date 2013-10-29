# ----------------------------------------------------------------------------
# Retira linhas em branco e comentários.
# Para ver rapidamente quais opções estão ativas num arquivo de configuração.
# Além do tradicional #, reconhece comentários de vários tipos de arquivos.
#  vim, asp, asm, ada, sql, e, bat, tex, c, css, html, cc, d, js, php. scala.
# E inclui os comentários multilinhas (/* ... */), usando opção --multi.
# Obs.: Aceita dados vindos da entrada padrão (STDIN).
# Uso: zzlimpalixo [--multi] [arquivos]
# Ex.: zzlimpalixo ~/.vimrc
#      cat /etc/inittab | zzlimpalixo
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-04-24
# Versão: 3
# Licença: GPL
# Requisitos: zzjuntalinhas
# ----------------------------------------------------------------------------
zzlimpalixo ()
{
	zzzz -h limpalixo "$1" && return

	local comentario='#'
	local multi=0
	local comentario_ini='\/\*'
	local comentario_fim='\*\/'

	# Para comentários multilinhas: /* ... */
	if test "$1" = "--multi"
	then
		multi=1
		shift
	fi

	# Reconhecimento de comentários
	# Incluida opção de escolher o tipo, pois o arquivo pode vir via pipe, e não seria possível reconhecer a extensão do arquivo
	case "$1" in
		*.vim | *.vimrc*)			comentario='"';;
		--vim)					comentario='"';shift;;
		*.asp)					comentario="'";;
		--asp)					comentario="'";shift;;
		*.asm)					comentario=';';;
		--asm)					comentario=';';shift;;
		*.ada | *.sql | *.e)			comentario='--';;
		--ada | --sql | --e)			comentario='--';shift;;
		*.bat)					comentario='rem';;
		--bat)					comentario='rem';shift;;
		*.tex)					comentario='%';;
		--tex)					comentario='%';shift;;
		*.c | *.css)				multi=1;;
		--c | --css)				multi=1;shift;;
		*.html | *.htm | *.xml)			comentario_ini='<!--'; comentario_fim='-->'; multi=1;;
		--html | --htm | --xml)			comentario_ini='<!--'; comentario_fim='-->'; multi=1;shift;;
		*.jsp)					comentario_ini='<%--'; comentario_fim='-->'; multi=1;;
		--jsp)					comentario_ini='<%--'; comentario_fim='-->'; multi=1;shift;;
		*.cc | *.d | *.js | *.php | *.scala)	comentario='\/\/';;
		--cc | --d | --js | --php | --scala)	comentario='\/\/';shift;;
	esac

	# Arquivos via STDIN ou argumentos
	zztool file_stdin "$@" |

	# Junta os comentários multilinhas
	if test $multi -eq 1
	then
		zzjuntalinhas -i "$comentario_ini" -f "$comentario_fim" |
		sed "/^[[:blank:]]*${comentario_ini}/d"

	else
		cat -
	fi |

		# Remove comentários e linhas em branco
		sed "
			/^[[:blank:]]*$comentario/ d
			/^[[:blank:]]*$/ d" |
		uniq
}

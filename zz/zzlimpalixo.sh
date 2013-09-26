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

	# Reconhecimento de comentários do Vim
	case "$1" in
		*.vim | *.vimrc*)			comentario='"';;
		*.asp)					comentario="'";;
		*.asm)					comentario=';';;
		*.ada | *.sql | *.e)			comentario='--';;
		*.bat)					comentario='rem ';;
		*.tex)					comentario='%';;
		*.c | *.css)				multi=1;;
		*.html | *.htm)				comentario_ini='<!--'; comentario_fim='-->'; multi=1;;
		*.cc | *.d | *.js | *.php | *.scala)	comentario='\/\/';;
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

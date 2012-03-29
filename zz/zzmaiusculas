# ----------------------------------------------------------------------------
# Converte todas as letras para MAIÚSCULAS, inclusive acentuadas.
# Uso: zzmaiusculas [texto]
# Ex.: zzmaiusculas eu quero gritar                # via argumentos
#      echo eu quero gritar | zzmaiusculas         # via STDIN
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2003-06-12
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzmaiusculas ()
{
	zzzz -h maiusculas "$1" && return

	# Dados via STDIN ou argumentos
	zztool multi_stdin "$@" |

	sed '
		y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/
		y/àáâãäåèéêëìíîïòóôõöùúûüçñ/ÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜÇÑ/'
}

# ----------------------------------------------------------------------------
# Converte todas as letras para minúsculas, inclusive acentuadas.
# Uso: zzminusculas [texto]
# Ex.: zzminusculas NÃO ESTOU GRITANDO             # via argumentos
#      echo NÃO ESTOU GRITANDOO | zzminusculas     # via STDIN
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2003-06-12
# Versão: 2
# Licença: GPL
# Tags: texto, conversão
# ----------------------------------------------------------------------------
zzminusculas ()
{
	zzzz -h minusculas "$1" && return

	# Dados via STDIN ou argumentos
	zztool multi_stdin "$@" |

	sed '
		y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/
		y/ÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜÇÑ/àáâãäåèéêëìíîïòóôõöùúûüçñ/'
}

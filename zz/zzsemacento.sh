# ----------------------------------------------------------------------------
# Tira os acentos de todas as letras (áéíóú vira aeiou).
# Uso: zzsemacento texto
# Ex.: zzsemacento AÇÃO 1ª bênção           # Retorna: ACAO 1a bencao
#      echo AÇÃO 1ª bênção | zzsemacento    # Retorna: ACAO 1a bencao
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2010-05-24
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzsemacento ()
{
	zzzz -h semacento "$1" && return

	# Dados via STDIN ou argumentos
	zztool multi_stdin "$@" |

	# Remove acentos
	sed '
		y/àáâãäåèéêëìíîïòóôõöùúûü/aaaaaaeeeeiiiiooooouuuu/
		y/ÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜ/AAAAAAEEEEIIIIOOOOOUUUU/
		y/çÇñÑß¢Ðð£Øø§µÝý¥¹²³ªº/cCnNBcDdLOoSuYyY123ao/
	'
}

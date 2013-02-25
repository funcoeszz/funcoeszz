# ----------------------------------------------------------------------------
# Codifica/decodifica um texto utilizando a cifra ROT47.
# Uso: zzrot47 texto
# Ex.: zzrot47 texto secreto               # Retorna: E6IE@ D64C6E@
#      zzrot47 E6IE@ D64C6E@               # Retorna: texto secreto
#      echo texto secreto | zzrot47        # Retorna: E6IE@ D64C6E@
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2008-07-23
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzrot47 ()
{
	zzzz -h rot47 "$1" && return

	# Dados via STDIN ou argumentos
	zztool multi_stdin "$@" |

	# Um tr faz tudo, é uma tradução letra a letra
	# Obs.: Os colchetes são parte da tabela, o tr não funcionará no Solaris
	tr '!-~' 'P-~!-O'
}

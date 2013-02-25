# ----------------------------------------------------------------------------
# Codifica/decodifica um texto utilizando a cifra ROT13.
# Uso: zzrot13 texto
# Ex.: zzrot13 texto secreto               # Retorna: grkgb frpergb
#      zzrot13 grkgb frpergb               # Retorna: texto secreto
#      echo texto secreto | zzrot13        # Retorna: grkgb frpergb
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2008-07-23
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzrot13 ()
{
	zzzz -h rot13 "$1" && return

	# Dados via STDIN ou argumentos
	zztool multi_stdin "$@" |

	# Um tr faz tudo, é uma tradução letra a letra
	# Obs.: Dados do tr entre colchetes para funcionar no Solaris
	tr '[a-zA-Z]' '[n-za-mN-ZA-M]'
}

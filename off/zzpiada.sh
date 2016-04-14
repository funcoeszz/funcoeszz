# ----------------------------------------------------------------------------
# http://www.xalexandre.com.br/
# Mostra uma piada diferente cada vez que é chamada.
# Uso: zzpiada
# Ex.: zzpiada
#
# Autor: Alexandre Brodt Fernandes, www.xalexandre.com.br
# Desde: 2008-12-29
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2016-04-14 Site inativo
zzpiada ()
{
	zzzz -h piada "$1" && return
	zztool dump -i latin1 'http://www.xalexandre.com.br/piadasAleiatorias/' |
		sed 's/^ *//'
}

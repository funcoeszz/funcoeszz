# ----------------------------------------------------------------------------
# http://www.xalexandre.com.br/
# Mostra uma piada diferente cada vez que é chamada.
# Uso: zzpiada
# Ex.: zzpiada
#
# Autor: Alexandre Brodt Fernandes, www.xalexandre.com.br
# Desde: 2008-12-29
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzpiada ()
{
	zzzz -h piada "$1" && return
	$ZZWWWDUMP 'http://www.xalexandre.com.br/piadasAleiatorias/'
}

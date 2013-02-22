# ----------------------------------------------------------------------------
# http://www.kernel.org/kdist/finger_banner
# Mostra as versões disponíveis do Kernel Linux.
# Uso: zzlinux
# Ex.: zzlinux
#
# Autor: Diogo Gullit <guuuuuuuuuullit (a) yahoo com br>
# Desde: 2008-05-01
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzlinux ()
{
	zzzz -h linux "$1" && return

	$ZZWWWDUMP http://www.kernel.org/kdist/finger_banner
}

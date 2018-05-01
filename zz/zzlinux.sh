# ----------------------------------------------------------------------------
# http://www.kernel.org/kdist/finger_banner
# Mostra as versões disponíveis do Kernel Linux.
# Uso: zzlinux
# Ex.: zzlinux
#
# Autor: Diogo Gullit <guuuuuuuuuullit (a) yahoo com br>
# Desde: 2008-05-01
# Versão: 2
# Licença: GPL
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzlinux ()
{
	zzzz -h linux "$1" && return

	zztool source http://www.kernel.org/kdist/finger_banner | grep -v '^$'
}

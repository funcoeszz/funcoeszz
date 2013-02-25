# ----------------------------------------------------------------------------
# http://casa.uol.com.br
# Pega as últimas notícias da casa dos artistas III.
# Uso: zzcasadosartistas
# Ex.: zzcasadosartistas
#
# Autor: Aurélio Marinho Jargas, www.aurelio.net
# Desde: 2002-02-18
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2002-10-30 O programa acabou.
zzcasadosartistas ()
{

	zzzz -z $1 zzcasadosartistas && return

	$ZZWWWDUMP http://casa3.aol.com.br/index.php |
		sed 's/^ *//;/'$ZZERDATA'/,$!d' |
		sed 15q
}

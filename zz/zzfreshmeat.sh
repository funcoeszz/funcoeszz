# ----------------------------------------------------------------------------
# http://freshmeat.net
# Procura por programas na base do site Freshmeat.
# Uso: zzfreshmeat programa
# Ex.: zzfreshmeat tetris
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-09-20
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzfreshmeat ()
{
	zzzz -h freshmeat "$1" && return

	local url='http://freecode.com/search/'
	local padrao=$1

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso freshmeat; return 1; }

	# Faz a consulta e filtra o resultado
	$ZZWWWLIST "$url?q=$padrao" |
		sed -n 's@.*\(http://freecode.com/projects/.*\)@\1@p' |
		grep -v '/projects/new' |
		sort |
		uniq
}

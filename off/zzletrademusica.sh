# ----------------------------------------------------------------------------
# http://letssingit.com
# Busca letras de músicas, procurando pelo nome da música.
# Obs.: Se encontrar mais de uma, mostra a lista de possibilidades.
#       E se a lista for muito longa, com o argumento -p, seguido sem espaço
#       do número da página, pode-se acessar o restante da lista não visível.
# Uso: zzletrademusica [-p<numero>] texto
# Ex.: zzletrademusica punkrock
#      zzletrademusica kkk took my baby
#      zzletrademusica -p2 Legião Urbana
#
# Autor: Thobias Salazar Trevisan, www.thobias.org - revisado por Itamar
# Desde: 2002-04-23
# Versão: 2
# Licença: GPL
# Requisitos: zzsemacento
# ----------------------------------------------------------------------------
# DESATIVADA: 2013-02-26 URL ainda existe, mas não retorna nada. [issue #31]
zzletrademusica ()
{
	zzzz -h letrademusica "$1" && return

	local pag

	echo "$1" | grep '^-p' >/dev/null
	if [ "$?" = "0" ]
	then
		pag="${1#-p}"
		zztool testa_numero $pag || pag="1"
		shift 1
	else
		pag="1"
	fi

	local padrao=$(echo "$*" | zzsemacento | sed "$ZZSEDURL")
	local url=http://letssingit.com/cgi-exe/am.cgi

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso letrademusica; return; }

	$ZZWWWDUMP "$url?a=search&l=archive&s=$padrao&p=$pag" |
	sed -n '
		s/^ *//
		s/^[0-9]*% *//
		/^Score/,/^ *$/p
		/^\[cell.png\]/,/^\[cell.png\]/p'|
		sed '1d;$d'
}

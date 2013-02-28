# ----------------------------------------------------------------------------
# Tenta quebrar o hash MD5 de uma string.
# Uso: zzquebramd5 <hash>
# Ex.: zzquebramd5 a4757d7419ff3b48e92e90596f0e7548
#
# Autor: Fernando Mercês <fernando (a) mentebinaria.com.br>
# Desde: 2012-02-24
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2013-02-27 Aparentemente não está funcionando (issue #29)
zzquebramd5 ()
{
	zzzz -h quebramd5 "$1" && return

	[ "$1" ] || { zztool uso quebramd5; return 1; }

	local url="http://md5crack.com/crackmd5.php"
	local resposta

	resposta=$(echo "term=$1" |
	$ZZWWWPOST $url |
	grep 'Found:' |
	sed 's/.*md5("\(.*\)").*/\1/')

	if echo $resposta | grep '[0-9a-f]' >/dev/null
	then
		echo $resposta
	else
		echo "Não foi possível descobrir a string que originou este hash."
	fi
}

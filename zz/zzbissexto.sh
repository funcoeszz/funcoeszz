# ----------------------------------------------------------------------------
# Diz se o ano informado é bissexto ou não.
# Obs.: Se o ano não for informado, usa o atual.
# Uso: zzbissexto [ano]
# Ex.: zzbissexto
#      zzbissexto 2000
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-21
# Versão: 1
# Requisitos: zzzz zztool zztestar
# Tags: data
# ----------------------------------------------------------------------------
zzbissexto ()
{
	zzzz -h bissexto "$1" && return

	local ano="$1"

	# Se o ano não for informado, usa o atual
	test -z "$ano" && ano=$(date +%Y)

	# Validação
	zztool -e testa_ano "$ano" || return 1

	if zztestar ano_bissexto "$ano"
	then
		echo "$ano é bissexto"
	else
		echo "$ano não é bissexto"
	fi
}

# ----------------------------------------------------------------------------
# Mostra a data de Corpus Christi para qualquer ano.
# Obs.: Se o ano não for informado, usa o atual.
# Regra: 60 dias depois do domingo de Páscoa.
# Uso: zzcorpuschristi [ano]
# Ex.: zzcorpuschristi
#      zzcorpuschristi 2009
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2008-11-21
# Versão: 1
# Licença: GPL
# Requisitos: zzdata zzpascoa
# Tags: data
# ----------------------------------------------------------------------------
zzcorpuschristi ()
{
	zzzz -h corpuschristi "$1" && return

	local ano="$1"

	# Se o ano não for informado, usa o atual
	test -z "$ano" && ano=$(date +%Y)

	# Validação
	zztool -e testa_ano $ano || return 1

	# Ah, como é fácil quando se tem as ferramentas certas ;)
	# e quando já temos o código e só precisamos mudar os numeros
	# tambem é bom :D ;)
	zzdata $(zzpascoa $ano) + 60
}

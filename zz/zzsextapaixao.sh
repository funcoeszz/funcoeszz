# ----------------------------------------------------------------------------
# Mostra a data da sexta-feira da paixão para qualquer ano.
# Obs.: Se o ano não for informado, usa o atual.
# Regra: 2 dias antes do domingo de Páscoa.
# Uso: zzsextapaixao [ano]
# Ex.: zzsextapaixao
#      zzsextapaixao 2008
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2008-11-21
# Versão: 1
# Licença: GPL
# Requisitos: zzdata zzpascoa
# Tags: data
# ----------------------------------------------------------------------------
zzsextapaixao ()
{
	zzzz -h sextapaixao "$1" && return

	local ano="$1"

	# Se o ano não for informado, usa o atual
	test -z "$ano" && ano=$(date +%Y)

	# Validação
	zztool -e testa_ano $ano || return 1

	# Ah, como é fácil quando se tem as ferramentas certas ;)
	# e quando já temos o código e só precisamos mudar os numeros
	# tambem é bom :D ;)
	zzdata $(zzpascoa $ano) - 2
}

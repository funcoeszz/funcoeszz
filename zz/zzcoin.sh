# ----------------------------------------------------------------------------
# Retorna a cotação de criptomoedas em Reais (Bitcoin, Litecoins ou BCash).
# Opções: btc ou bitecoin (padrão) / ltc ou litecoin / bch ou bcash.
#
# Uso: zzcoin [btc|bitcoin|ltc|litecoin|bch|bcash|-a|--all]
# Ex.: zzcoin
#      zzcoin btc
#      zzcoin litecoin
#      zzcoin bch
#
# Autor: Tárcio Zemel <tarciozemel (a) gmail com>
# Desde: 2014-03-24
# Versão: 6
# Licença: GPL
# Requisitos: zzminusculas zznumero zzsemacento
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzcoin ()
{
	zzzz -h coin "$1" && return

	# Variáveis gerais
	local moeda_informada=$(echo "${1:-btc}" | zzminusculas | zzsemacento)
	local url="https://www.mercadobitcoin.net/api"

	# Se não informou moeda válida, termina
	case "$moeda_informada" in
		btc | bitcoin )
			# Monta URL a ser consultada
			url="${url}/BTC/ticker/"
			zztool dump "$url" |
			sed 's/.*"last": *"//;s/", *"buy.*//' |
			zznumero -m
		;;
		ltc | litecoin )
			# Monta URL a ser consultada
			url="${url}/LTC/ticker/"
			zztool dump "$url" |
			sed 's/.*"last": *"//;s/", *"buy.*//' |
			zznumero -m
		;;
		bch | bcash )
			# Monta URL a ser consultada
			url="${url}/BCH/ticker/"
			zztool dump "$url" |
			sed 's/.*"last": *"//;s/", *"buy.*//' |
			zznumero -m
		;;
		* ) return 1;;
	esac
}

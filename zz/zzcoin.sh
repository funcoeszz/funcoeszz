# ----------------------------------------------------------------------------
# Retorna a cotação de criptomoedas em Reais (Bitcoin, Litecoins ou BCash).
# Opções: btc ou bitecoin / ltc ou litecoin / bch ou bcash.
# Com as opções -a ou --all, várias criptomoedas cotadas em dólar.
# Uso: zzcoin [btc|bitcoin|ltc|litecoin|bch|bcash|-a|--all]
# Ex.: zzcoin
#      zzcoin btc
#      zzcoin litecoin
#      zzcoin bch
#      zzcoin -a
#
# Autor: Tárcio Zemel <tarciozemel (a) gmail com>
# Desde: 2014-03-24
# Versão: 5
# Licença: GPL
# Requisitos: zzjuntalinhas zzminusculas zznumero zzsemacento zzsqueeze zztrim zzxml
# ----------------------------------------------------------------------------
zzcoin ()
{
	zzzz -h coin "$1" && return

	# Variáveis gerais
	local moeda_informada=$(echo "${1:--a}" | zzminusculas | zzsemacento)
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
		-a | --all )
			url="http://coinmarketcap.com/"
			zztool source http://coinmarketcap.com/ |
			sed -n '/<table class="table" id="currencies" >/,/<\/table>/p' |
			zzjuntalinhas -i '<td ' -f '</td>' |
			zzxml --untag |
			zztrim |
			zzsqueeze |
			sed 's/\.\.\./…/' |
			awk '{
				printf "%-4s", $0
				getline; printf "%-20s", $0
				getline;getline; printf "%17s", $0
				getline; printf "%12s", $0
				getline; printf "%17s", $0
				getline; printf "  %-23s", $0
				getline; if(NR==8) printf "%10s", $0
				getline; if(NR!=9) printf "%12s", $0
				getline; printf "\n"
			}' |
			tr '.,' ',.'
		;;
		* ) return 1;;
	esac
}

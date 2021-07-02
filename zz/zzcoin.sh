# ----------------------------------------------------------------------------
# Retorna a cotação de criptomoedas em Reais (Bitcoin, Litecoins, etc.).
#
# Uso: zzcoin [criptomoeda ...]
# Ex.: zzcoin              # Lista todas as criptomoedas disponíveis
#      zzcoin btc          # Cotação do Bitcoin
#      zzcoin ltc          # Cotação do Litecoin
#      zzcoin btc ltc eth  # Cotação do Bitcoin, Litecoin e Ethereum
#
# Autor: Tárcio Zemel <tarciozemel (a) gmail com>
# Desde: 2014-03-24
# Versão: 9
# Requisitos: zzzz zztool zzmaiusculas zznumero zzsemacento
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzcoin ()
{
	zzzz -h coin "$1" && return

	# Variáveis gerais
	local moeda
	local url="https://www.mercadobitcoin.com.br"

	# https://www.mercadobitcoin.com.br/api-doc/
	local moedas="\
		AAVE : Aave
		ACMFT : Fan Token ASR
		ACORDO01 : None
		ASRFT : Fan Token ASR
		ATMFT : Fan Token ATM
		AXS : Axie Infinity Shard
		BAL : Balancer
		BARFT : BARFT
		BAT : Basic Attention token
		BCH : Bitcoin Cash
		BTC : Bitcoin
		CAIFT : Fan Token CAI
		CHZ : Chiliz
		COMP : Compound
		CRV : Curve
		DAI : Dai
		DAL : Balancer
		ENJ : Enjin
		ETH : Ethereum
		GALFT : Fan Token GAL
		GRT : The Graph
		IMOB01 : None
		IMOB02 : None
		JUVFT : Fan Token JUV
		KNC : Kyber Network
		LINK : CHAINLINK
		LTC : Litecoin
		MANA : Decentraland
		MBCONS01 : Cota de Consórcio 01
		MBCONS02 : Cota de Consórcio 02
		MBFP01 : None
		MBFP02 : None
		MBFP03 : None
		MBFP04 : None
		MBFP05 : None
		MBPRK01 : Precatório MB SP01
		MBPRK02 : Precatório MB SP02
		MBPRK03 : Precatório MB BR03
		MBPRK04 : Precatório MB RJ04
		MBVASCO01 : MBVASCO01
		MCO2 : MCO2
		MKR : Maker
		OGFT : Fan Token ASR
		PAXG : PAX Gold
		PSGFT : Fan Token PSG
		REI : Ren
		REN : Ren
		SNX : Synthetix
		UMA : Uma
		UNI : Uniswap
		USDC : USD Coin
		WBX : WiBX
		XRP : XRP
		YFI : Yearn
		ZRX : 0x
	"

	if test $# -eq 0
	then
		# Lista as moedas disponíveis
		echo "$moedas" | tr -d '\t' | grep .
		return 0
	fi

	while test $# -gt 0
	do
		moeda=$(echo "$1" | zzmaiusculas | zzsemacento)

		if zztool grep_var "$moeda :" "$moedas"
		then
			# Mostra a cotação de uma criptomoeda específica
			printf '%s: ' $moeda
			zztool dump "${url}/api/${moeda}/ticker/" |
				sed 's/.*"last": *"//;s/", *"buy.*//' |
				zznumero -m

		else
			# Se não informou moeda válida, termina
			zztool erro "Moeda desconhecida: $1"
			return 1
		fi

		shift
	done
}

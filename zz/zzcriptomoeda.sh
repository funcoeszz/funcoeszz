# ----------------------------------------------------------------------------
# Retorna a cotação de criptomoedas em Reais.
# Com as opções -a ou --all, várias criptomoedas cotadas em dolar.
# Uso: zzcriptomoeda [btc|bitcoin|ltc|litecoin]
# Ex.: zzcriptomoeda btc
#      zzcriptomoeda litecoin
#      zzcriptomoeda -a
#
# Autor: Tárcio Zemel <tarciozemel (a) gmail com>
# Desde: 2014-03-24
# Versão: 2
# Licença: GPL
# Requisitos: zzminusculas zzsemacento
# ----------------------------------------------------------------------------
zzcriptomoeda ()
{
	zzzz -h criptomoeda "$1" && return

	# Variáveis gerais
	local moeda_informada=$(echo "$1" | zzminusculas | zzsemacento)

	# Se não informou moeda válida, termina
	case "$moeda_informada" in
		btc | bitcoin  ) query_string='BTC';;
		ltc | litecoin ) query_string='LTC';;
		-a | --all )
			$ZZWWWDUMP "http://coinmarketcap.com/mineable.html" |
			sed -n '/#/,/Last updated/{/^ *\*/d;/^ *$/d;s/Total Market Cap/Valor Total de Mercado/;s/Last updated/Última atualização/;s/ %//;p}' |
			awk '
				NR==1 {printf "%-20s %17s %10s %20s %11s %12s\n", "Nome", "Valor de Mercado", "Preço ", "Total de Oferta", "Volume (24h)", "%Var (24h)"}
				NR>=2 {
					if($0 ~ /Última/ || $0 ~ /Total/) { print }
					else {
						if (NF<=12) {
							sub(/\**$/,"",$9)
							printf "%-20s %17s %10s %20s %11s %12s %%\n", $3,       $5, $7, $8 " " $9,  $11, $12
						}
						else 	{
							sub(/\**$/,"",$10)
							printf "%-20s %17s %10s %20s %11s %12s %%\n", $3 " " $4,$6, $8, $9 " " $10, $12, $13
						}
					}
				}'
			return
		;;
		* ) return 1;;
	esac

	# Monta URL a ser consultada
	local url="https://www.bitinvest.com.br/?SDCC=$query_string"

	# Retorno
	$ZZWWWDUMP "$url" |
	sed -n '5{s/^ *//;s/Último Preço: R\$/R$ /;s/\([0-9]\) .*/\1/;p;}'
}

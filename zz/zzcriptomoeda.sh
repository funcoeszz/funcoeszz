# ----------------------------------------------------------------------------
# Retorna a cotação de criptomoedas em Reais (bitcoin e litecoins).
# Opções: btc ou bitecoin / ltc ou litecoin.
# Com as opções -a ou --all, várias criptomoedas cotadas em dolar.
# Uso: zzcriptomoeda [btc|bitcoin|ltc|litecoin|-a|--all]
# Ex.: zzcriptomoeda
#      zzcriptomoeda btc
#      zzcriptomoeda litecoin
#      zzcriptomoeda -a
#
# Autor: Tárcio Zemel <tarciozemel (a) gmail com>
# Desde: 2014-03-24
# Versão: 4
# Licença: GPL
# Requisitos: zzminusculas zzsemacento zznumero
# ----------------------------------------------------------------------------
zzcriptomoeda ()
{
	zzzz -h criptomoeda "$1" && return

	# Variáveis gerais
	local moeda_informada=$(echo "${1:--a}" | zzminusculas | zzsemacento)
	local url="https://www.mercadobitcoin.com.br/api"

	# Se não informou moeda válida, termina
	case "$moeda_informada" in
		btc | bitcoin  )
			# Monta URL a ser consultada
			url="${url}/ticker"
			$ZZWWWHTML "$url" |
			sed 's/.*"last"://;s/,"buy.*//' |
			zznumero -m
		;;
		ltc | litecoin  )
			# Monta URL a ser consultada
			url="${url}/ticker_litecoin"
			$ZZWWWHTML "$url" |
			sed 's/.*"last"://;s/,"buy.*//' |
			zznumero -m
		;;
		-a | --all )
			url="http://coinmarketcap.com/mineable.html"
			$ZZWWWDUMP "$url" |
			sed -n '/#/,/Last updated/{
				/^ *\*/d;
				/^ *$/d;
				s/Total Market Cap/Valor Total de Mercado/;
				s/Last updated/Última atualização/;
				s/ %//;
				s/\$ //g;
				s/  Name /Nome /;
				s/ Market Cap/Valor Mercado/;
				s/     Price/Preço/;
				s/Total Supply/Total Oferta/;
				s/ (24h)/(24h)/g;
				s/Change(24h)/%Var(24h)/;
				s/ Market Cap Graph (7d)//;
				s/ Price Graph (7d)//;
				/______/d;
				p;
				}' |
			awk '
				function espacos(  tamanho, saida, i) {
					for(i=1;i<=tamanho;i++)
						saida = saida " "
					return saida
				}
				NR==1 {print}
				NR>=2 {
					if($2 == $3) {
						atual = $2 " " $3
						novo = $2 " " espacos(length($3))
						sub(atual, novo)
						print
					}
					else if($2 == $4 && $3 == $5) {
						gsub(/\)/,"_"); gsub(/\(/,"_")
						atual = $2 " " $3 " " $4 " " $5
						novo = $2 " " $3 " " espacos(length($4)+length($5)+1)
						sub(atual, novo)
						gsub(/_/," "); gsub(/_/," ")
						print
					}
					else { print }
				}'
			return
		;;
		* ) return 1;;
	esac
}

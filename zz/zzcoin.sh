# ----------------------------------------------------------------------------
# Retorna a cotação de criptomoedas em Reais (Bitcoin, Litecoins, etc.).
# Com o argumento -a ou --all mostra a cotação de todas as criptomoedas.
#
# Uso: zzcoin [criptomoeda| -a | --all]
# Ex.: zzcoin       # Lista todas as criptomoedas disponíveis
#      zzcoin -a    # Cotação de todas as criptomoedas da lista
#      zzcoin btc   # Cotação do Bitcoin
#      zzcoin lc    # Cotação do Litecoin
#      zzcoin eth   # Cotação do Ethereum
#
# Autor: Tárcio Zemel <tarciozemel (a) gmail com>
# Desde: 2014-03-24
# Versão: 7
# Licença: GPL
# Requisitos: zzmaiusculas zznumero zzpad zzsemacento zzxml
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzcoin ()
{
	zzzz -h coin "$1" && return

	# Variáveis gerais
	local moeda_informada moeda
	local url="https://www.mercadobitcoin.com.br"
	local moedas=$(zztool source "${url}/api-doc/" |
		zzxml --tidy |
		sed -n '
			/<div class="tab domain">/,/div>/{
				/div>/q
				/<[^>]*>/d
				p
			}
		' |
		awk '
			!/ : /  { coin = $1; next }
			!/None/ { print coin $0 }
		')

	if test -n "$1"
	then
		case "$1" in
		-a | --all)
			# Todas as criptomoedas
			for moeda_informada in $(echo "${moedas}" | sed 's/ *:.*//' | zztool lines2list)
			do
				moeda=$(echo "$moedas" | awk -F ' : ' ' /'${moeda_informada}'/ {print $2 "(" $1 ")"}')
				echo "$(zzpad 31 ${moeda}): $(zzcoin ${moeda_informada})"
			done
			return
		;;
		*)
			moeda_informada=$(echo "${1}" | zzmaiusculas | zzsemacento)

			if zztool grep_var "|${moeda_informada}|" $(echo "|${moedas}" | sed 's/ *:.*//' | tr '\n' '|')
			then
				# Uma criptomoeda específica
				zztool dump "${url}/api/${moeda_informada}/ticker/" |
				sed 's/.*"last": *"//;s/", *"buy.*//' |
				zznumero -m

			else
				# Se não informou moeda válida, termina
				zztool -e uso coin
				return
			fi
		;;
		esac
	else
		# Listando as moedas disponíveis
		echo "$moedas"
	fi
}

# ----------------------------------------------------------------------------
# Retorna a cotação de criptomoedas em Reais.
# Uso: zzcriptomoeda [btc|bitcoin|ltc|litecoin]
# Ex.: zzcriptomoeda btc
#      zzcriptomoeda litecoin
#
# Autor: Tárcio Zemel <tarciozemel (a) gmail com>
# Versão: 1
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
        btc|bitcoin  ) query_string='BTC';;
        ltc|litecoin ) query_string='LTC';;
        * ) return;;
    esac

    # Monta URL a ser consultada
    local url="https://www.bitinvest.com.br/?SDCC=$query_string"

    # Retorno
    $ZZWWWDUMP "$url" |
    sed -n '5{s/^ *//;s/Último //;s/: R\$/: R$ /g ;s/ [BL]TC//;p;}' |
    sed 's/[0-9] /&\
    /g' |
    sed -n 1p |
    sed -e 's/Preço: //g' |
    sed 's/ //g'
}

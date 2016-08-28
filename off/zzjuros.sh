# ----------------------------------------------------------------------------
# Mostra a listagem de taxas de juros que o Banco Central acompanha.
# São instituições financeiras, que estão sob a supervisão do Banco Central.
# Com argumento numérico, detalha a listagem solicitada.
# A numeração fica entre 1 e 27
#
# Uso: zzjuros [numero consulta]
# Ex.: zzjuros
#      zzjuros 19  # Mostra as taxas de desconto de cheque para pessoa física.
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-05-06
# Versão: 2
# Licença: GPL
# Requisitos: zzxml zzunescape
# ----------------------------------------------------------------------------
# DESATIVADA: 2016-08-28 Site usa webservice com AJAX :(
zzjuros ()
{
	zzzz -h juros "$1" && return

	local nome
	local url='http://www.bcb.gov.br/pt-br/sfn/infopban/txcred/txjuros/Paginas/default.aspx'
	local cache=$(
				zztool source "$url" |
				sed -n '/Modalidades de/,/Histórico/p'|
				zzxml --tag a --tag strong |
				sed '/Historico.aspx/,$d;/^<\//d' |
				awk '/href|strong/ {
					printf $0 "|"
					getline
					print
					}' |
				sed '1d;$d;s/.*="//;s/">//' |
				awk '{if ($0 ~ /pt-br/) { print $0 "|" ++item } else print }'
				)

	# Testa se foi fornecido um numero dentre as opções disponiveis.
	if zztool testa_numero $1
	then
		test $1 -gt 27 -o $1 -lt 1 && { zztool -e uso juros; return 1; }

		# Buscando o nome e a url a ser pesquisada
		nome=$(echo "$cache" | grep "|${1}$" | cut -f 2 -d "|")
		url=$(echo "$cache" | grep "|${1}$" | zzunescape --html | cut -f 1 -d "|")
		url="http://www.bcb.gov.br${url}"

		# Fazendo a busca e filtrando no site do Banco Central.
		zztool eco "$nome"
		zztool dump "$url" |
		sed -n '/^ *Posição *$/,/^ *Atendimento/p' | sed '$d' |
		awk '{
			gsub(/  */," ")
			if (NR % 4 == 1) {linha1 = $0}
			if (NR % 4 == 2) {linha2 = $0}
			if (NR % 4 == 3) {linha3 = $0}
			if (NR % 4 == 0) {
				linha4 = $0
				printf "%-7s %-40s %8s %8s\n", linha1, linha2, linha3, linha4
			}
		}'

	else

		echo "$cache" |
		awk -F "|" '{
			if ($1 ~ /strong/) {
				if ($2 ~ /jurídica/) print ""
				print $2
			} else {
				printf "%3s. %s\n", $3, $2
			}
		}'

	fi
}

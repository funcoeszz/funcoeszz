# ----------------------------------------------------------------------------
# Mostra a listagem de taxas de juros que o Banco Central acompanha.
# São intituições financeiras, que estão sob a supervisão do Banco Central.
# Com argumento numérico, detalha a listagem solicitada.
# A numeração fica entre 1 e 25
#
# Uso: zzjuros [numero consulta]
# Ex.: zzjuros
#      zzjuros 19  # Mostra as taxas de desconto de cheque para pessoa física.
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-05-06
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzjuros ()
{
	zzzz -h juros "$1" && return

	local resultado tipo modalidade encargo
	local url='http://www.bcb.gov.br/pt-br/sfn/infopban/txcred/txjuros/Paginas'

	# Testa se foi fornecido um numero dentre as opções disponiveis.
	if zztool testa_numero $1
	then
		[ $1 -gt 25 -o $1 -lt 1 ] && { zztool uso juros; return 1; }

		# Variavel resultado guarda a linha da opção escolhida, com os códigos a seres usados.
		resultado=$(zzjuros cod | sed -n "/^ *$1 /p" | sed 's/,\([0-9]\)/, \1/g' | tr -d ',)(.')

		# Redefine a url conforme a opção escolhida
		if zztool grep_var 'Financiamento' "$resultado"
		then
			url="$url/RelTxJurosMensal.aspx"
		else
			url="$url/RelTxJuros.aspx"
		fi

		# Captura os valores de novas variáveis dentro da variavel resultado.
		tipo=$(		echo "$resultado" | awk '{print $(NF-2)}')
		modalidade=$(	echo "$resultado" | awk '{print $(NF-1)}')
		encargo=$(	echo "$resultado" | awk '{print $NF}')

		# Descrições conforme as caracteristas obtidas pelas variáveis acima.
		[ "$tipo" = "1" ] && echo -n "Pessoa Física - " || echo -n "Pessoa Jurídica - "
		[ $(echo "$encargo" | cut -c 1) = "1" ] && echo 'Taxas Pré-Fixada' || echo 'Taxas Pós-Fixada'
		zztool eco $(echo $resultado | sed 's/^[ 0-9]\{1,\}//;s/[ 0-9]\{1,\}$//')

		# Fazendo a busca e filtrando no site do Banco Central, conforme as variáveis obtidas.
		$ZZWWWDUMP "${url}?tipoPessoa=${tipo}&modalidade=${modalidade}&encargo=${encargo}" |
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
		# Sem opções, mostra a lista de taxas que podem ser pesquisadas.
		$ZZWWWDUMP http://www.bcb.gov.br/pt-br/sfn/infopban/txcred/txjuros/Paginas/default.aspx |
		sed -n '/Modalidades de/,/Histórico/p' | sed '1d;$d;/^ *$/d;s/^  */ /g' |
		awk '
			BEGIN { item = 1}
			{
				if (NF>0) {
					if ($2 == "Pessoa") { $1 = ""; printf "\n\n%s", $2 " " $3 }
					else if ($1 == "*" || $1 == "Taxas" || $2 == "Taxas") {
						if ($1 == "*" && $2 != "Taxas") {
							$1 = (item<10?" ":"") " " item++
						}
						printf "\n%s", $0
					}
					else {
						printf "%s", $0
					}
				}
			}
			END { print "" }
		' | sed '1,2d;s/^[ *]*Taxas /Taxas /g' |
		if test "$1" = "cod"
		then
			# Usado internamente, mostra a listagem com as opções a serem colocadas na url.
			cat -
		else
			# Em outros casos, elimina exibição das opções.
			sed 's/ *(.*$//g'
		fi
	fi
}

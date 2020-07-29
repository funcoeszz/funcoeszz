# ----------------------------------------------------------------------------
# http://www.infomoney.com.br
# Busca cotações do dia de algumas moedas em relação ao Real (compra e venda).
# Uso: zzcotacao
# Ex.: zzcotacao
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-19
# Versão: 4
# Licença: GPL
# Requisitos: zzjuntalinhas zzsqueeze zztrim zzunescape zzxml
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzcotacao ()
{
	zzzz -h cotacao "$1" && return

	zztool eco "Infomoney"
	zztool source "http://www.infomoney.com.br/mercados/cambio" |
	sed -n '/<table class="table-general">/,/<\/table>/{/table>/q;p;}' |
	zzjuntalinhas -i '<tr>' -f '</tr>' |
	zzxml --untag |
	zzsqueeze |
	zztrim |
	zzunescape --html |
	awk '
	/n\/d/ {next}
	{
		if ( NR == 1 ) printf "%18s  %6s  %6s   %6s\n", "", $2, $3, $4
		if ( NR >  1 ) {
			if (NF == 4) printf "%-18s  %6s  %6s  %6s\n", $1, $2, $3, $4
			if (NF == 5) printf "%-18s  %6s  %6s  %6s\n", $1 " " $2, $3, $4, $5
		}
	}'

	echo
	zztool eco "UOL - Economia"
	# Faz a consulta e filtra o resultado
	zztool source 'http://economia.uol.com.br/cotacoes' |
	zzxml --tidy |
	sed -n '/<table class="borda mod-grafico-wide quatro-colunas">/,/table>/p' |
	zzjuntalinhas -i '<tr>' -f '</tr>' |
	zzjuntalinhas -i '<thead>' -f '</thead>' |
	zzjuntalinhas -i '<caption' -f 'caption>' |
	zzxml --untag |
	zzsqueeze |
	zztrim |
	sed '1s/Dólar //;s/Variação/Var(%)/;s/comercial - //;s/com\./Comercial/;s/tur\./Turismo/;s/arg\./Argentino/;/^Fonte/d;/^Veja/d' |
		awk '
		NR==1
		{
			if ( NR == 2 ) printf "%18s  %6s  %6s   %6s\n", "", $1, $2, $3
			if ( NR >  2 ) {
				if (NF == 4 && $2 != "n/d" && $3 != "n/d") printf "%-18s  %6s  %6s  %6s\n", $1, $2, $3, $4
				if (NF == 5 && $3 != "n/d" && $4 != "n/d") printf "%-18s  %6s  %6s  %6s\n", $1 " " $2, $3, $4, $5
			}
		}'
}

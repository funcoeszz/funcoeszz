# ----------------------------------------------------------------------------
# http://www.infomoney.com.br
# Busca cotações do dia de algumas moedas em relação ao Real (compra e venda).
# Uso: zzcotacao
# Ex.: zzcotacao
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-19
# Versão: 3
# Licença: GPL
# Requisitos: zzsemacento
# ----------------------------------------------------------------------------
zzcotacao ()
{
	zzzz -h cotacao "$1" && return

	zztool eco "Infomoney"
	zztool dump "http://www.infomoney.com.br/mercados/cambio" |
	sed -n '/Real vs. Moedas/,/Hist.rico de Cota..es/p' |
	sed  '1d; $d; /^ *$/d' |
	sed 's/Venda  *Var/Venda Var/;s/\[//g;s/\]//g' |
	zzsemacento |
	awk '{
		if ($1 == "InfoMoney") next
		if ( NR == 1 ) printf "%18s  %6s  %6s   %6s\n", "", $2, $3, $4
		if ( NR >  1 ) {
			if (NF == 4 && $2 != "n/d" && $3 != "n/d") printf "%-18s  %6s  %6s  %6s\n", $1, $2, $3, $4
			if (NF == 5 && $3 != "n/d" && $4 != "n/d") printf "%-18s  %6s  %6s  %6s\n", $1 " " $2, $3, $4, $5
		}
	}'

	zztool eco "\nUOL - Economia"
	# Faz a consulta e filtra o resultado
	zztool dump 'http://economia.uol.com.br/cotacoes' |
		tr -s ' ' |
		sed -n '/Dólar comercial /,/Fonte Thompson Reuters/ {
			# Linha original:
			# Dólar com. 2,6203 2,6212 -0,79%

			# faxina
			/Bovespa/d
			/\]/d
			/^[[:blank:]]*$/d
			/Fonte Thompson Reuters/d
			s/com\./Comercial/
			s/tur\./Turismo /
			s/^[[:blank:]]*//
			s/[[:blank:]]*$//
			s/.*Dólar comercial[^0-9]*//
			s/Variação/Var(%)/
			s/arg\./Argentino/
			s/\(.*\) - \(.*\) \{0,1\}\([0-9][0-9]h[0-9][0-9]\)*/\2|\3\
\1/
		p
		}' |
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

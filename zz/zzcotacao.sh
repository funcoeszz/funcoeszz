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

	$ZZWWWDUMP "http://www.infomoney.com.br/mercados/cambio" |
	sed -n '/^Real vs. Moedas/,/^Cota/p' |
	sed -n '3p;/^   [DLPFIE]/p' |
	sed 's/Venda  *Var/Venda Var/;s/\[//g;s/\]//g' |
	zzsemacento |
	awk '{
		if ( NR == 1 ) printf "%18s  %6s  %6s   %6s\n", "", $2, $3, $4
		if ( NR >  1 ) {
			if (NF == 4) printf "%-18s  %6s  %6s  %6s\n", $1, $2, $3, $4
			if (NF == 5) printf "%-18s  %6s  %6s  %6s\n", $1 " " $2, $3, $4, $5
		}
	}'
}

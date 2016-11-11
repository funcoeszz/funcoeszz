$ zzeuro | sed 's/[0-9]/9/g;s/[+-]//g;s/99h99/HORA/;s/99\/99\/9999/DATA/g;s/9,9*\%/PORCENTAGEM/g;s/9,999*/DINHEIRO/g' | sed 's/[ 	]*$//'
	Compra	Venda	Variação	DATA	HORA
Euro	DINHEIRO	DINHEIRO	PORCENTAGEM
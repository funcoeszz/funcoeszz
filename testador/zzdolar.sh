$ zzdolar | sed 's/[0-9]/9/g;s/[+-]//g;s/99h99//;s/99\/99\/9999/DATA/g;s/9,9*\%/PORCENTAGEM/g;s/9,999*/DINHEIRO/g' | sed 's/[ 	]*$//'
DATA
		Compra	Venda	Variação
Comercial	DINHEIRO	DINHEIRO	PORCENTAGEM
Turismo		DINHEIRO	DINHEIRO	PORCENTAGEM

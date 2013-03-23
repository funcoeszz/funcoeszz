# ----------------------------------------------------------------------------
# Exibe 'cara' ou 'coroa' aleatoriamente.
# Uso: zzcaracoroa
# Ex.: zzcaracoroa
#
# Autor: Angelito M. Goulart, www.angelitomg.com
# Desde: 2012-12-06
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzcaracoroa ()
{

	# Comando especial das funcoes ZZ
	zzzz -h caracoroa "$1" && return

	# Gera um numero aleatorio entre 0 e 1. 0 -> Cara, 1 -> Coroa
	local NUM="$(($RANDOM % 2))"

	# Verifica o numero gerado e exibe o resultado
	if [ $NUM -eq 0 ]
	then
		echo "Cara"
	else
		echo "Coroa"
	fi

}

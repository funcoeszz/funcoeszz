# ----------------------------------------------------------------------------
# Calcula o valor do IMC correspodente a sua estrutura corporal.
#
# Uso: zzimc <peso_em_KG> <altura_em_metros>
# Ex.: zzimc 108.5 1.73
#
# Autor: Rafael Araújo <rafaelaraujosilva (a) gmail com>
# Desde: 2015-10-30
# Versão: 1
# Licença: GPL
# Requisitos: zztestar
# Tags: cálculo
# ----------------------------------------------------------------------------
zzimc ()
{

	zzzz -h imc "$1" && return

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso imc; return 1; }
	test -n "$2" || { zztool -e uso imc; return 1; }

	local PESO=`echo "$1" | tr "," "."`
	local ALTURA=`echo "$2" | tr "," "."`

	if ! ( zztestar numero_real "$PESO" )
	then

		zztool erro "Valor inserido para o peso está inválido, favor verificar!"
		return 1
	fi

	if ! ( zztestar numero_real "$ALTURA" )
	then

		zztool erro "Valor inserido para a altura está inválido, favor verificar!"
		return 1
	fi

	echo "scale=2;$PESO / ( $ALTURA^2 )" | bc |
	awk '{
		if ($1 >= 40 ) {print "IMC: "$1" - OBESIDADE GRAU III"}
		if ($1 < 40 && $1 >= 35) {print "IMC: "$1" - OBESIDADE GRAU II"}
		if ($1 < 35 && $1 >= 30) {print "IMC: "$1" - OBESIDADE GRAU I"}
		if ($1 < 30 && $1 >= 25) {print "IMC: "$1" - PRE-OBESIDADE"}
		if ($1 < 25 && $1 >= 18.5) {print "IMC: "$1" - PESO ADEQUADO"}
		if ($1 < 18.5 && $1 >= 17) {print "IMC: "$1" - MAGREZA GRAU I"}
		if ($1 < 17 && $1 >= 16) {print "IMC: "$1" - MAGREZA GRAU II"}
		if ($1 < 16 ) {print "IMC: "$1" - MAGREZA GRAU III"}
	}'
}

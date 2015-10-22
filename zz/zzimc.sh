# ----------------------------------------------------------------------------
# Calcula o valor do IMC correspodente a sua estrutura corporal
#
# Uso: zzimc <peso_em_KG> <altura_em_metros>
# Ex.: zzimc 108.5 1.73
#
# Autor: Rafael Araújo <rafaelaraujosilva (a) gmail com >
# Desde: 2015-10-30
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------

zzimc ()
{

   zzzz -h chaves "$1" && return
   
    local PESO=$1
    local ALTURA=$2

    VALOR_IMC=`echo "scale=2;$PESO / ( $ALTURA^2 )" | bc`

    awk 'BEGIN { 

        if ('$VALOR_IMC' >= 40 ) {print "IMC: '$VALOR_IMC' - OBESIDADE GRAU III"}

        if ('$VALOR_IMC' < 40 && '$VALOR_IMC' >= 35) {print "IMC: '$VALOR_IMC' - OBESIDADE GRAU II"}
        
        if ('$VALOR_IMC' < 35 && '$VALOR_IMC' >= 30) {print "IMC: '$VALOR_IMC' - OBESIDADE GRAU I"}
        
        if ('$VALOR_IMC' < 30 && '$VALOR_IMC' >= 25) {print "IMC: '$VALOR_IMC' - PRE-OBESIDADE"}
        
        if ('$VALOR_IMC' < 25 && '$VALOR_IMC' >= 18.5) {print "IMC: '$VALOR_IMC' - PESO ADEQUADO"}
        
        if ('$VALOR_IMC' < 18.5 && '$VALOR_IMC' >= 17) {print "IMC: '$VALOR_IMC' - MAGREZA GRAU I"}
        
        if ('$VALOR_IMC' < 17 && '$VALOR_IMC' >= 16) {print "IMC: '$VALOR_IMC' - MAGREZA GRAU II"}
        
        if ('$VALOR_IMC' < 16 ) {print "IMC: '$VALOR_IMC' - MAGREZA GRAU III"}
        
    }'

}

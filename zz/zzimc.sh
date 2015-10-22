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

    zzzz -h zzimc "$1" && return
    
    if zztool testa_numero "$1" || zztool testa_numero_fracionario "$1"
    then
        
        if zztool testa_numero "$2" || zztool testa_numero_fracionario "$2"
        then

            local PESO=$1
            local ALTURA=$2
            
            echo "scale=2;$PESO / ( $ALTURA^2 )" | bc | awk '{ 
            
                if ($1 >= 40 ) {print "IMC: "$1" - OBESIDADE GRAU III"}
            
                if ($1 < 40 && $1 >= 35) {print "IMC: "$1" - OBESIDADE GRAU II"}
                
                if ($1 < 35 && $1 >= 30) {print "IMC: "$1" - OBESIDADE GRAU I"}
                
                if ($1 < 30 && $1 >= 25) {print "IMC: "$1" - PRE-OBESIDADE"}
                
                if ($1 < 25 && $1 >= 18.5) {print "IMC: "$1" - PESO ADEQUADO"}
                
                if ($1 < 18.5 && $1 >= 17) {print "IMC: "$1" - MAGREZA GRAU I"}
                
                if ($1 < 17 && $1 >= 16) {print "IMC: "$1" - MAGREZA GRAU II"}
                
                if ($1 < 16 ) {print "IMC: "$1" - MAGREZA GRAU III"}
                
            }'
        else
    
            echo "Valor inserido inválido, favor verificar!"
            echo "Ex: "
            echo "    zzimc 108.5 1.73"
            echo "    zzimc 85 1.60"
            echo "    zzimc 125 2"
        fi
    else
    
        echo "Valor inserido inválido, favor verificar!"
        echo "Ex: "
        echo "    zzimc 108.5 1.73"
        echo "    zzimc 85 1.60"
        echo "    zzimc 125 2"
    fi
}
#!/bin/bash
# ----------------------------------------------------------------------------
# Da uma desculpa comum de desenvolvedor ( em ingles ).
# Fonte de pesquisa: http://programmingexcuses.com/
# Use a opção -t ou --traduzir para traduzir a desculpa em portugues
#
# Uso: zzexcuse [-t|--traduzir]
# Ex.: zzexcuse         # The user must not know how to use it
#      zzexcuse -t      # O usuário não deve saber como usá-lo
#
# Autor: Italo Gonçales, @goncalesi, <italo.goncales (a) gmail com>
# Desde: 2015-10-01
# Versão: 1
# Licença: GPL
# Requisitos: zztradutor
# ----------------------------------------------------------------------------
zzexcuse ()
{
    zzzz -h excuse "$1" && return
    
    case "$1" in 
        -t | --traduzir ) # O usuário informou a opção de tradução
            printf "$( curl -s http://developerexcuses.com/ |
                sed -rn 's/\s{2}<center.*nofollow.*?>(.*?)<\/a>.*/\1/p' |
                zztradutor en-pt $2 )\n"
            return
            ;;
        *)
            printf "$( curl -s http://developerexcuses.com/ |
                sed -rn 's/\s{2}<center.*nofollow.*?>(.*?)<\/a>.*/\1/p' )\n"
            return 
            ;;
    esac
}

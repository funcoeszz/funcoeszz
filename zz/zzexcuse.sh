#!/bin/bash
# ----------------------------------------------------------------------------
# Da uma desculpa comum de desenvolvedor ( em ingles )
# Fonte de pesquisa: http://programmingexcuses.com/
# Uso: zzexcuse
# Ex.: zzexcuse
#
# Autor: Italo Gonçales, @goncalesi, <italo.goncales (a) gmail com>
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzexcuse ()
{
    zzzz -h excuse "$1" && return

    printf "$( curl -s http://developerexcuses.com/ | 
           perl -ne '/center.*nofollow.*?>(.*?)<\/a>/ and print "$1"' )\n"
}

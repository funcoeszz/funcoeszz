# ------------------------------------------------------------------------------
# http://esporte.uol.com.br/futebol/agenda-de-jogos
# Mostra todos os jogos de futebol marcados para os proximos dias.
# Além de mostrar os times que irão jogar, o script também mostra o dia, 
# o horário e por campeonato será o jogo.
#
# Uso:  zzfutebol [ --hoje | --amanha | --ontem | --proximo-sabado | --proximo-domingo ]
# Ex.:  zzfutebol
#       zzfutebol --hoje  
#       zzfutebol --proximo-sabado
#
# Autor: Jefferson Fausto Vaz (www.faustovaz.com)
# Desde: 2014-04-08
# Versão: 1
# Licensa: GPL
# ------------------------------------------------------------------------------
zzfutebol(){

    zzzz -h futebol "$1" && return

    listajogos(){
        local url="http://esporte.uol.com.br/futebol/agenda-de-jogos"
        $ZZWWWDUMP $url | awk -v diadojogo="$1" ' {
            if ( diadojogo == "" ){
                if ($1 ~ /[0-9]+\/[0-9]+\/[0-9]+/){
                    gsub(/^[\t ]+/, "", $0)
                    dadosdojogo = $0
                    imprimir = 1
                }
            }
            else{
                if ( $1 == diadojogo ){
                    gsub(/^[\t ]+/, "", $0)
                    dadosdojogo = $0
                    imprimir = 1
                }
            }
            if ( imprimir ){
                if ( $0 ~ /[\w\t -]+ X [\w\t -]+/ ){
                    gsub(/^[\t ]+/, "", $0)
                    gsub(/[\t ]+$/, "", $0)
                    printf "%-40s    %s\n", dadosdojogo, $0
                    imprimir = 0
                }
            }
        }'
    }   

    futebolhoje(){
        local hoje=$( zzdata hoje | zzdatafmt -f DD/MM/AA )
        listajogos "$hoje"
    }

    futebolamanha(){
        local amanha=$( zzdata amanha | zzdatafmt -f DD/MM/AA )
        listajogos "$amanha"
    }

    futebolontem(){
        local ontem=$( zzdata ontem | zzdatafmt -f DD/MM/AA )
        listajogos "$ontem"
    }

    futebolproximosabado(){
        local diadasemana=$( date "+%u" )
        local diasparaproximosabado=$( expr 6 - $diadasemana )
        local sabado=$( zzdata hoje + $diasparaproximosabado | zzdatafmt -f DD/MM/AA )
        listajogos "$sabado"
    }

    futebolproximodomingo(){
        local diadasemana=$( date "+%u" )
        local diasparaproximodomingo=$( expr 7 - $diadasemana )
        local domingo=$( zzdata hoje + $diasparaproximodomingo | zzdatafmt -f DD/MM/AA )
        listajogos "$domingo"
    }

    futebol(){
        listajogos
    }

    case "$1" in
        "--hoje")
            futebolhoje
            ;;
        "--amanha")
            futebolamanha
            ;;
        "--ontem")
            futebolontem
            ;;
        "--proximo-sabado")
            futebolproximosabado
            ;;
        "--proximo-domingo")
            futebolproximodomingo
            ;;
        *)
            futebol
            ;;
    esac
}
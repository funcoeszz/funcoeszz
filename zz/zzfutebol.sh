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
        local hoje=$( date "+%d/%m/%y" )
        listajogos "$hoje"
    }

    futebolamanha(){
        local agora=$( date "+%s" )
        local amanha=$( expr $agora + 86400 )
        amanha=$( date --date=@$amanha "+%d/%m/%y" )
        listajogos "$amanha"
    }

    futebolontem(){
        local agora=$(date "+%s")
        local ontem=$(expr $agora - 86400)
        ontem=$(date --date=@$ontem "+%d/%m/%y")
        listajogos "$ontem"
    }

    futebolproximosabado(){
        local agora=$(date "+%s")
        local diadasemana=$(date "+%u")
        local proximosabadodias=$(expr 6 - $diadasemana)
        local proximosabadosegundos=$(expr $proximosabadodias \* 86400)
        local sabado=$(expr $agora + $proximosabadosegundos)
        sabado=$(date --date=@$sabado "+%d/%m/%y")
        listajogos "$sabado"
    }

    futebolproximodomingo(){
        local agora=$(date "+%s")
        local diadasemana=$(date "+%u")
        local proximodomingodias=$(expr 7 - $diadasemana)
        local proximodomingosegundos=$(expr $proximodomingodias \* 86400)
        local domingo=$(expr $agora + $proximodomingosegundos)
        domingo=$(date --date=@$domingo "+%d/%m/%y")
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

zzfutebol(){

    listajogos(){
        #Função principal.
        #Essa função recebe uma data e lista os jogos desta data passada.
        local cmd="lynx -dump -nolist -width=300 -accept_all_cookies -display_charset=UTF-8"
        local link="http://esporte.uol.com.br/futebol/agenda-de-jogos"
        $cmd $link | awk -v diadojogo="$1" '
        {
            if ( diadojogo == "" )
            {
                if ($1 ~ /[0-9]+\/[0-9]+\/[0-9]+/)
                {
                    gsub(/^[\t ]+/, "", $0)
                    dadosdojogo = $0
                    imprimir = 1
                }
            }
            else
            {
                if ( $1 == diadojogo )
                {
                    gsub(/^[\t ]+/, "", $0)
                    dadosdojogo = $0
                    imprimir = 1
                }
            }
            if ( imprimir )
            {
                if ( $0 ~ /[\w\t -]+ X [\w\t -]+/ )
                {
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

    if test "$1" == '--help' || test "$1" == '-h' 
    then
    cat <<EOF
        Futebol: Lista todos os jogos marcados para os proximos dias.
        Uso:
            futebol [Opcao]
        Opcao:
            hoje                Exibe os jogos de hoje
            amanha              Exibe os jogos de amanha
            ontem               Exibe os jogos de ontem
            proximo-sabado      Exibe os jogos do proximo sabado
            proximo-domingo     Exibe os jogos do proximo domingo
EOF
    else
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
    fi
}
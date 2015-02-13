# ----------------------------------------------------------------------------
# http://esporte.uol.com.br/futebol/agenda-de-jogos
# Mostra todos os jogos de futebol marcados para os proximos dias.
# Além de mostrar os times que irão jogar, o script também mostra o dia,
# o horário e por campeonato será o jogo.
#
# Uso: zzfutebol [ hoje | amanha | ontem | sabado | domingo ]
# Ex.: zzfutebol
#      zzfutebol hoje
#      zzfutebol sabado
#
# Autor: Jefferson Fausto Vaz (www.faustovaz.com)
# Desde: 2014-04-08
# Versão: 2
# Licença: GPL
# Requisitos: zzdata zzdatafmt
# ----------------------------------------------------------------------------
zzfutebol ()
{

    #zzzz -h futebol "$1" && return

    listajogos(){
        local url="http://esporte.uol.com.br/futebol/agenda-de-jogos"
        $ZZWWWDUMP $url | awk ' {
            gsub(/^[\t ]+/, "", $0)
            gsub(/[\t ]+$/, "", $0)
            imprimir=0

            if ($0 ~ /^[0-9]+\/[0-9]+\/[0-9]+[\t ]+[0-9]+h[0-9]+/){
                dadosdojogo=$0
            }

            if ($0 ~ /^[[:alpha:]\t _-]+X[[:alpha:]\t _-]/){
                gsub( /^[A-Z]+ /, "", $0 )
                gsub( / [A-Z]+$/, "", $0 )
                gsub( / [_X ]+ /, "    x    ", $0)
                jogo=$0
                imprimir=1
            }

            if(imprimir){
                imprimir=0
                printf "%-38s %s\n", dadosdojogo, jogo
            }

        }'
    }

    case "$1" in
        "hoje")
            listajogos | grep -e $( zzdata hoje | zzdatafmt -f DD/MM/AA )
            ;;
        "amanha")
            listajogos | grep -e $( zzdata amanha | zzdatafmt -f DD/MM/AA )
            ;;
        "ontem")
            listajogos | grep -e $( zzdata ontem | zzdatafmt -f DD/MM/AA )
            ;;
        "sabado")
            listajogos | grep -e $( zzdata sabado | zzdatafmt -f DD/MM/AA )
            ;;
        "domingo")
            listajogos | grep -e $( zzdata domingo | zzdatafmt -f DD/MM/AA )
            ;;
        *)
            listajogos
            ;;
    esac
}

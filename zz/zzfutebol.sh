# ----------------------------------------------------------------------------
# http://esporte.uol.com.br/futebol/agenda-de-jogos
# Mostra todos os jogos de futebol marcados para os proximos dias.
# Além de mostrar os times que irão jogar, o script também mostra o dia,
# o horário e por campeonato será o jogo.
#
# Uso:  zzfutebol [ hoje | amanha | ontem | sabado | domingo ]
# Ex.:  zzfutebol
#       zzfutebol hoje
#       zzfutebol sabado
#
# Autor: Jefferson Fausto Vaz (www.faustovaz.com)
# Desde: 2014-04-08
# Versão: 2
# Licensa: GPL
# Requisitos: zzdata zzdatafmt
# ----------------------------------------------------------------------------
zzfutebol ()
{

	zzzz -h futebol "$1" && return

	listajogos(){
		local url="http://esporte.uol.com.br/futebol/agenda-de-jogos"
		$ZZWWWDUMP $url | awk -v diadojogo="$1" ' {
			if ( diadojogo == "" ){
				if ( $1 ~ /[0-9]+\/[0-9]+\/[0-9]+/ ){
					gsub( /^[\t ]+/, "", $0 )
					dadosdojogo = $0
					imprimir = 1
				}
			}
			else{
				if ( $1 == diadojogo ){
					gsub( /^[\t ]+/, "", $0 )
					dadosdojogo = $0
					imprimir = 1
				}
			}
			if ( imprimir ){
				if ( $0 ~ /[\w\t -]+ X [\w\t -]+/ ){
					gsub( /^[\t ]+/, "", $0 )
					gsub( /[\t ]+$/, "", $0 )
					gsub( /^[A-Z]+ /, "", $0 )
					gsub( / [A-Z]+$/, "", $0 )
					printf "%-38s	%s\n", dadosdojogo, $0
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
		local sabado=$( zzdata sabado | zzdatafmt -f DD/MM/AA )
		listajogos "$sabado"
	}

	futebolproximodomingo(){
		local domingo=$( zzdata domingo | zzdatafmt -f DD/MM/AA )
		listajogos "$domingo"
	}

	futebol(){
		listajogos
	}

	case "$1" in
		"hoje")
			futebolhoje
			;;
		"amanha")
			futebolamanha
			;;
		"ontem")
			futebolontem
			;;
		"sabado")
			futebolproximosabado
			;;
		"domingo")
			futebolproximodomingo
			;;
		*)
			futebol
			;;
	esac
}

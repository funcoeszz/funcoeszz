# ----------------------------------------------------------------------------
# http://esporte.uol.com.br/futebol/agenda-de-jogos
# Mostra todos os jogos de futebol marcados para os próximos dias.
# Ou os resultados de jogos recentes.
# Além de mostrar os times que jogam, o script também mostra o dia,
# o horário e por qual campeonato será ou foi o jogo.
#
# Suporta um argumento que pode ser um dos dias da semana, como:
#  hoje, amanhã, segunda, terça, quarta, quinta, sexta, sábado, domingo.
#
# Ou um ou dois argumentos para ver resultados do jogos:
#   resultado ou placar, que pode ser acompanhado de hoje, ontem, anteontem.
#
# Um filtro com nome do campeonato, nome do time, ou horário de uma partida.
#
# Uso: zzfutebol [resultado | placar ] [ argumento ]
# Ex.: zzfutebol                 # Todas as partidas nos próximos dias.
#      zzfutebol hoje            # Partidas que acontecem hoje.
#      zzfutebol sabado          # Partidas que acontecem no sábado.
#      zzfutebol libertadores    # Próximas partidas da Libertadores.
#      zzfutebol 21h             # Partidas que começam entre 21 e 22h.
#      zzfutebol resultado       # Placar dos jogos já ocorridos.
#      zzfutebol placar ontem    # Placar dos jogos de ontem.
#      zzfutebol placar espanhol # Placar dos jogos do Campeonato Espanhol.
#
# Autor: Jefferson Fausto Vaz (www.faustovaz.com)
# Desde: 2014-04-08
# Versão: 9
# Licença: GPL
# Requisitos: zzdata zzdatafmt zztrim zzpad
# ----------------------------------------------------------------------------
zzfutebol ()
{

	zzzz -h futebol "$1" && return
	local url="http://esporte.uol.com.br/futebol/central-de-jogos/proximos-jogos"
	local linha campeonato time1 time2

	case "$1" in
		resultado | placar) url="http://esporte.uol.com.br/futebol/central-de-jogos/resultados"; shift;;
		ontem | anteontem)  url="http://esporte.uol.com.br/futebol/central-de-jogos/resultados";;
	esac

	zztool dump "$url" |
	sed -n '/[0-9]h[0-9]/{N;N;p;}' |
	sed '
		s/^ *__* *$/XXX/
		s/Amistoso.*/Amistoso/
		s/ [A-Z][A-Z][A-Z]$//
		s/__*//' |
	zztrim |
	awk '
		NR % 3 == 1 { campeonato = $0 }
		NR % 3 ~ /^[02]$/ {
			if ($1 ~ /^[0-9-]{1,}$/ && $2 ~ /^[0-9-]{1,}$/) {
				penais[NR % 3]=$1; placar[NR % 3]=$2; $1=""; $2=""
			}
			else if ($1 ~ /^[0-9-]{1,}$/ && $2 !~ /^[0-9-]{1,}$/) {
				penais[NR % 3]=""; placar[NR % 3]=$1; $1=""
			}
			sub(/^ */,"");sub(/ *$/,"")
			time[NR % 3]=" " $0 " "
		}
		NR % 3 == 0 {
			if (length(penais[0])>0 && length(penais[2])>0) {
				placar[2] = placar[2] " ( " penais[2]
				placar[0] = penais[0] " ) " placar[0]
			}
			else {
				penais[0]=""; penais[2]=""
			}
			sub(/  *$/,""); print campeonato ":" time[2] placar[2] ":" placar[0] time[0]
			placar[0]="";placar[2]=""
		}
		' |
	case "$1" in
		hoje | amanh[aã] | segunda | ter[cç]a | quarta | quinta | sexta | s[aá]bado | domingo | ontem | anteontem)
			grep --color=never -e $( zzdata $1 | zzdatafmt -f 'DD/MM/AA' )
			;;
		*)
			grep --color=never -i "${1:-.}"
			;;
	esac |
	while read linha
	do
		campeonato=$(echo $linha | cut -d":" -f 1)
		time1=$(echo $linha | cut -d":" -f 2)
		time2=$(echo $linha | cut -d":" -f 3 | zztrim)
		echo "$(zzpad -r 45 $campeonato) $(zzpad -l 25 $time1) x $time2"
	done
}

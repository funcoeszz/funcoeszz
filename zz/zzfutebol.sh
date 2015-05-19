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
# Versão: 8
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

	$ZZWWWDUMP "$url" |
	sed -n '/[0-9]h[0-9]/{N;N;p;}' |
	sed '
		s/[A-Z][A-Z][A-Z] //
		s/__*//
		/º / { s/.*\([0-9]\{1,\}º\)/\1/ }' |
	zztrim |
	awk '
		NR % 3 == 1 { campeonato = $0 }
		NR % 3 == 2 { time1 = $0; if ($(NF-1) ~ /^[0-9]{1,}$/) { penais1=$(NF -1)} else {penais1=""} }
		NR % 3 == 0 {
			if ($NF ~ /^[0-9]{1,}$/) { reserva=$NF " "; $NF=""; } else { reserva="" }
			if ($(NF-1) ~ /^[0-9]{1,}$/ ) { penais2=$(NF -1)} else {penais2=""}
			if (length(penais1)>0 && length(penais2)>0) {
				sub(" " penais1, "", time1)
				sub(" " penais2, "")
				penais1 = " ( " penais1
				penais2 = penais2 " ) "
			}
			else {penais1="";penais2=""}
			print campeonato ":" time1 penais1 ":" penais2 reserva $0
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
		echo "$(zzpad -r 40 $campeonato) $(zzpad -l 25 $time1) x $time2"
	done
}

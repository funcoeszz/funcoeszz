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
# Nos casos dos dias, podem ser usadas datas no formato DD/MM/AAAA.
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
# Versão: 10
# Licença: GPL
# Requisitos: zzcut zzdatafmt zzjuntalinhas zzpad zztrim zzxml
# ----------------------------------------------------------------------------
zzfutebol ()
{

	zzzz -h futebol "$1" && return
	local url="http://esporte.uol.com.br/futebol/central-de-jogos"
	local pagina='proximos-jogos'
	local linha campeonato time1 time2

	case "$1" in
		resultado | placar) pagina='resultados'; shift;;
		ontem | anteontem)  pagina='resultados';;
	esac

	zztool source "${url}/${pagina}" |
	zzxml --tidy |
	zzjuntalinhas -i 'td class="league"' -f '</td>' |
	if test "$pagina" = 'proximos-jogos'
	then
		sed -n '/class="league"/p;/<span class="\(data\|hora\)">/,/<\/span>/p;;/<meta itemprop="\(name\|location\)"/{/content=""/d;s/">//;s/.*"//;p;}'
	else
		sed -n '/class="league"/p;/<span class="\(data\|hora\)">/,/<\/span>/p;/abbr title=/{s/">//;s/.*"//;p;};/<label class="gols">/,/label>/p'
	fi |
	zzxml --untag |
	zztrim |
	awk -v pag="$pagina" '
		BEGIN { lim = (pag=="resultados"?7:4) }
		/[0-3][0-9]\// {printf $0; for(i=1;i<lim;i++){getline;printf ":" $0};print ""}
	' |
	case "$1" in
		hoje | amanh[aã] | segunda | ter[cç]a | quarta | quinta | sexta | s[aá]bado | domingo | ontem | anteontem | [0-3][0-9]/[01][0-9]/20[1-9][0-9])
			grep --color=never -e $(zzdatafmt -f 'DD/MM/AA' $1)
			;;
		*)
			grep --color=never -i "${1:-.}"
			;;
	esac |
	while read linha
	do
		campeonato=$(echo $linha | zzcut -d : -D ' ' -f1-3)
		if test "$pagina" = 'proximos-jogos'
		then
			time1=$(echo $linha | zzcut -d : -f 4 | zzcut -d ' x ' -f 1)
			time2=$(echo $linha | zzcut -d : -f 4 | zzcut -d ' x ' -f 2)
		else
			time1=$(echo $linha | zzcut -d : -f 5,4 -D ' ')
			time2=$(echo $linha | zzcut -d : -f 6,7 -D ' ')
		fi
		echo "$(zzpad -r 45 $campeonato) $(zzpad -l 25 $time1) x $time2"
	done
}

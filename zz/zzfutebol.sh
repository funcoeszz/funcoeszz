# ----------------------------------------------------------------------------
# https://www.ogol.com.br
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
#      zzfutebol resultado       # Placar dos jogos já ocorridos.
#      zzfutebol placar ontem    # Placar dos jogos de ontem.
#      zzfutebol placar espanhol # Placar dos jogos do Campeonato Espanhol.
#
# Autor: Jefferson Fausto Vaz (www.faustovaz.com)
# Desde: 2014-04-08
# Versão: 11
# Requisitos: zzzz zztool zzdatafmt zzjuntalinhas zzpad zzsqueeze zztrim zzutf8 zzxml
# Tags: internet, futebol, consulta
# ----------------------------------------------------------------------------
zzfutebol ()
{

	zzzz -h futebol "$1" && return
	local url='https://www.ogol.com.br/'
	local pagina='proximos_jogos.php'
	local data hora time1 placar time2 campeonato

	case "$1" in
		resultado | placar) pagina='ultimos_resultados.php'; shift;;
		ontem | anteontem)  pagina='ultimos_resultados.php' ;;
	esac

	zztool source "${url}/${pagina}" |
	zzutf8 |
	zzxml --tidy |
	zzjuntalinhas -i '<td' -f 'td>' -d ' ' |
	zzxml --untag |
	zztrim |
	zzsqueeze |
	awk '/h2h/ {
		for (i=1;i<=7;i++) {
			getline
			if(i==2 && $0 !~ /[012][0-9]:[0-5][0-9]/) { printf " n/d ;"; i++ }
			if(i!=6) printf $0 ";" (i==7?"\n":"")
		}
	}' |
	while IFS=';' read -r data hora time1 placar time2 campeonato
	do
		echo "$(zzdatafmt $data) $hora $(zzpad -e 24 $time1) $(zzpad -a 14 $placar) $(zzpad 24 $time2) $campeonato"
	done |
	if test 'proximos_jogos.php' = "$pagina"
	then
		grep --color=never ' vs '
	else
		cat -
	fi |
	case "$1" in
		hoje | amanh[aã] | segunda | ter[cç]a | quarta | quinta | sexta | s[aá]bado | domingo | ontem | anteontem | [0-3][0-9]/[01][0-9]/20[1-9][0-9])
			grep --color=never -e $(zzdatafmt -f 'DD/MM/AAAA' $1)
			;;
		*)
			grep --color=never -i "${1:-.}"
			;;
	esac
}

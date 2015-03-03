# ----------------------------------------------------------------------------
# http://esporte.uol.com.br/futebol/agenda-de-jogos
# Mostra todos os jogos de futebol marcados para os proximos dias.
# Além de mostrar os times que irão jogar, o script também mostra o dia,
# o horário e por qual campeonato será o jogo.
#
# Suporta um argumento que pode ser:
#
# Um dos dias da semana, como:
#  hoje, amanhã, segunda, terça, quarta, quinta, sexta, sábado, domingo.
#
# Um filtro como nome do campeonato ou nome do time.
# Ou o horário de uma partida.
#
# Uso: zzfutebol [ argumento ]
# Ex.: zzfutebol                 # Todas as partidas nos próximos dias.
#      zzfutebol hoje            # Partidas que acontecem hoje.
#      zzfutebol sabado          # Partidas que acontecem no sábado.
#      zzfutebol libertadores    # Próximas partidas da Libertadores.
#      zzfutebol 21h             # Partidas que começam entre 21 e 22h.
#
# Autor: Jefferson Fausto Vaz (www.faustovaz.com)
# Desde: 2014-04-08
# Versão: 3
# Licença: GPL
# Requisitos: zzdata zzdatafmt
# ----------------------------------------------------------------------------
zzfutebol ()
{

	zzzz -h futebol "$1" && return
	local url="http://esporte.uol.com.br/futebol/agenda-de-jogos"

	$ZZWWWDUMP "$url" |
	sed -n '/[0-9]h[0-9]/p;/_ X/p' |
	zztool trim |
	awk -F "[_]+" '
		{
			if ($0 ~ /[0-9]h[0-9]/) {
				printf "%-40s", $0
			}
			else {
				sub(/^[A-Z]+ /, "")
				sub(/ [A-Z]+$/, "")
				printf "%25s x %-25s\n", $1, $3
			}
		}' |
	sed 's/  x  /x/' |
	case "$1" in
		hoje | amanh[aã] | segunda | ter[cç]a | quarta | quinta | sexta | s[aá]bado | domingo)
			grep --color=never -e $( zzdata $1 | zzdatafmt -f 'DD/MM/AA' )
			;;
		*)
			grep --color=never -i "${1-.}"
			;;
	esac
}

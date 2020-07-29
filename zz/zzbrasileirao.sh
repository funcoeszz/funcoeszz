# ----------------------------------------------------------------------------
# http://esporte.uol.com.br/
# Mostra a tabela atualizada do Campeonato Brasileiro - Série A, B, C ou D.
# Se for fornecido um numero mostra os jogos da rodada, com resultados.
#
# Nomenclatura:
#   PG  - Pontos Ganhos
#   J   - Jogos
#   V   - Vitórias
#   E   - Empates
#   D   - Derrotas
#   GP  - Gols Pró
#   GC  - Gols Contra
#   SG  - Saldo de Gols
#   (%) - Aproveitamento (pontos)
#
# Uso: zzbrasileirao [a|b|c|d] [numero rodada]
# Ex.: zzbrasileirao
#      zzbrasileirao a
#      zzbrasileirao b
#      zzbrasileirao c
#      zzbrasileirao 27
#      zzbrasileirao b 12
#
# Autor: Alexandre Brodt Fernandes, www.xalexandre.com.br
# Desde: 2011-05-28
# Versão: 26
# Licença: GPL
# Requisitos: zzecho zzjuntalinhas zzpad zztrim zzxml
# Tags: internet, futebol, consulta
# ----------------------------------------------------------------------------
zzbrasileirao ()
{
	zzzz -h brasileirao "$1" && return

	test $(date +%Y%m%d) -lt 20190426 && { zztool erro "Campeonato Brasileiro 2018 só a partir de 14 de Abril."; return 1; }

	local rodada serie time1 time2 horario pos time resto cor
	local url="https://www.gazetaesportiva.com/campeonatos/brasileiro-serie-"

	test $# -gt 2 && { zztool -e uso brasileirao; return 1; }

	serie='a'
	case $1 in
	a | b | c | d) serie="$1"; shift;;
	esac

	if test -n "$1"
	then
		zztool testa_numero "$1" && rodada="$1" || { zztool -e uso brasileirao; return 1; }
	fi

	url="${url}${serie}/"

	if test -n "$rodada"
	then
		case $serie in
		a | b | c)
			printf "$(
				zztool source $url |
				awk  '/rodadas\[/{gsub(/"(numero_rodada|equipe_[12])"/,"\n&");print}' |
				sed  '/"numero_rodada":'${rodada}',/,/"numero_rodada"/!d' |
				awk -F '[:,]' '/equipe_1/{printf $5 "_" $11 " X "} ; /equipe_2/{printf $11 "_" $5 "\n"}'
			)" |
			sed 's/"//g;s/null/ /g' |
			zztool nl_eof |
			while IFS="_" read time1 placar time2
			do
				echo "$(zzpad -r 22 $time1) $placar $(zzpad -l 22 $time2)"
			done
		;;
		esac
	else
		zztool eco $(echo "Série $serie" | tr 'abcd' 'ABCD')
		zztool source "$url" |
		sed -n '/<thead/,/table>/{/\(__shield\|thead\|tbody\)/d;s/<tr class="\(.* \)">/\1/;p;}' |
		zztrim |
		zzjuntalinhas -d '|' -i '<th' -f 'tr>' |
		zzxml --untag |
		sed 's/| *$//' |
		while IFS='|' read pos time resto
		do
			case "$pos" in
				"GRUPO A")            printf "$pos\n" ;;
				"GRUPO B"|"GRUPO A"*) printf "\n$pos\n" ;;
			esac
			if [ $ZZCOR -eq 1 ]
			then
				case "$pos" in
					table__green)  cor='verde' ;;
					table__orange) cor='ciano' ;;
					table__red)    cor='vermelho' ;;
					[0-9]*)        cor="$cor" ;;
					*)             unset cor ;;
				esac
			fi
			if [ -n "$time" ]
			then
				case "$cor" in
					verde|ciano|vermelho) zzecho -f $cor -l preto "$(zzpad 3 $pos) $(zzpad 20 $time) $(echo "$resto" | sed 's/|/\t/g' | expand -t 5)";;
					*)                    echo "$(zzpad 3 $pos) $(zzpad 20 $time) $(echo "$resto" | sed 's/|/\t/g' | expand -t 5)";;
				esac
			fi
		done

		if test $ZZCOR -eq 1
		then
			echo
			if test "$serie" = "a"
			then
				zzecho -f verde -l preto  " Libertadores  "
				zzecho -f ciano -l preto  " Sul-Americana "
				zzecho -f vermelho -l preto   " Rebaixamento  "
			elif test "$serie" = "b"
			then
				zzecho -f verde -l preto  "   Série  A    "
				zzecho -f vermelho -l preto   " Rebaixamento  "
			elif test "$serie" = "c"
			then
				zzecho -f verde -l preto " Quartas de Final "
				zzecho -f vermelho -l preto "   Rebaixamento   "
			elif test "$serie" = "d"
			then
				zzecho -f verde -l preto "      Segunda Fase       "
				zzecho -f ciano -l preto  "15 MELHORES CLASSIFICADOS"
			fi
		fi

	fi
}

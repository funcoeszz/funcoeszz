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
# Versão: 24
# Licença: GPL
# Requisitos: zzecho zzpad
# ----------------------------------------------------------------------------
zzbrasileirao ()
{
	zzzz -h brasileirao "$1" && return

	test $(date +%Y%m%d) -lt 20180414 && { zztool erro "Campeonato Brasileiro 2018 só a partir de 14 de Abril."; return 1; }

	local rodada serie ano time1 time2 horario linha num_linha
	local url="http://esporte.uol.com.br/futebol"

	test $# -gt 2 && { zztool -e uso brasileirao; return 1; }

	serie='a'
	case $1 in
	a | b | c | d) serie="$1"; shift;;
	esac

	if test -n "$1"
	then
		zztool testa_numero "$1" && rodada="$1" || { zztool -e uso brasileirao; return 1; }
	fi

	test "$serie" = "a" && url="${url}/campeonatos/brasileirao/jogos" || url="${url}/campeonatos/serie-${serie}/jogos"

	if test -n "$rodada"
	then
		zztool testa_numero $rodada || { zztool -e uso brasileirao; return 1; }
		zztool dump "$url" |
		sed -n "/Rodada ${rodada}$/,/\(Rodada\|^ *$\)/p" |
		sed '
		/Rodada /d
		s/^ *//
		/[0-9]h[0-9]/{s/pós[ -]jogo *//; s/\(h[0-9][0-9]\).*/\1/;}
		s/ [A-Z][A-Z][A-Z]$//
		s/ *__*//' |
		awk '
			NR % 3 ~ /^[12]$/ {
				if ($1 ~ /^[0-9-]{1,}$/) {
					placar[NR % 3]=$1; $1=""
				}
				sub(/^ */,"");sub(/ *$/,"")
				time[NR % 3]=" " $0 " "
			}
			NR % 3 == 0 {
				sub(/  *$/,""); print time[1] placar[1] "|" placar[2] time[2] "|" $0
				placar[1]="";placar[2]=""
			}
		' |
		sed '/^ *$/d' |
		while read linha
		do
			time1=$(  echo $linha | cut -d"|" -f 1 )
			time2=$(  echo $linha | cut -d"|" -f 2 )
			horario=$(echo $linha | cut -d"|" -f 3 | sed 's/^ *//' )
			echo "$(zzpad -l 22 $time1) X $(zzpad -r 22 $time2) $horario"
		done
	else
		zztool eco $(echo "Série $serie" | tr 'abcd' 'ABCD')
		if test "$serie" = "c" -o "$serie" = "d"
		then
			zztool dump "$url" |
			sed -n "/Grupo [AB][1-9]\{0,2\} *PG .*/,/Rodada 1 *$/{s/^/_/;s/.*Rodada .*//;s/°/./;p;}" |
			while read linha
			do
				if echo "$linha" | grep -E '[12]\.' >/dev/null && test "$serie" = "c"
				then
					zzecho -f verde -l preto "$linha"
				elif echo "$linha" | grep '1\.' >/dev/null && test "$serie" = "d"
				then
					zzecho -f verde -l preto "$linha"
				elif echo "$linha" | grep -E '[34]\.' >/dev/null && test "$serie" = "c"
				then
					zzecho -f verde -l preto "$linha"
				elif echo "$linha" | grep -E '(9\.|10\.)' >/dev/null && test "$serie" = "c"
				then
					zzecho -f vermelho -l preto "$linha"
				else
					echo "$linha"
				fi
			done |
			tr -d _
			if test "$serie" = "c"
			then
				zzecho -f verde -l preto " Quartas de Final "
				zzecho -f vermelho -l preto "   Rebaixamento   "
			else
				zzecho -f verde -l preto " Segunda Fase "
			fi
		else
			num_linha=0
			zztool dump "$url" |
			sed -n "/^ *Classificação *PG/,/20°/{ s/^/_/; s/°/./; p; }" |
			while read linha
			do
				linha=$(echo "$linha" | awk '{pontos=sprintf("%3d", $NF);sub(/[0-9]+$/,pontos);print}')
				num_linha=$((num_linha + 1))
				case $num_linha in
					[2-5]) zzecho -f verde -l preto "$linha";;
					[67])
						if test "$serie" = "a"
						then
							zzecho -f verde -l preto "$linha"
						else
							echo "$linha"
						fi
					;;
					[89] | 1[0-3])
						if test "$serie" = "a"
						then
							zzecho -f ciano -l preto "$linha"
						else
							echo "$linha"
						fi
					;;
					1[89] | 2[01] ) zzecho -f vermelho -l preto "$linha";;
					*) echo "$linha";;
				esac
			done |
			tr -d _

				echo
				if test "$serie" = "a"
				then
					zzecho -f verde -l preto  " Libertadores  "
					zzecho -f ciano -l preto  " Sul-Americana "
				elif test "$serie" = "b"
				then
					zzecho -f verde -l preto  "   Série  A    "
				fi
				zzecho -f vermelho -l preto   " Rebaixamento  "

		fi
	fi
}

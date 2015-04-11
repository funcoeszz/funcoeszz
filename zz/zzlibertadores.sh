# ----------------------------------------------------------------------------
# Mostra a classificação e jogos do torneio Libertadores da América.
# Opções:
#  <número> | <fase>: Mostra jogos da fase selecionada
#    fases: pre ou primeira, grupos ou segunda, oitavas
#  -g <número>: Jogos da segunda fase do gupo selecionado
#  -c [número]: Mostra a classificação, nos grupos da segunda fase
#  -cg <número> ou -gc <número>: Classificação e jogos do grupo selecionado.
#
# As fases podem ser:
#  pré, pre, primeira ou 1, para a fasé pré-libertadores
#  grupos, segunda ou 2, para a fase de grupos da libertadores
#  oitavas ou 3
#  quartas ou 4
#  semi, semi-final ou 5
#  final ou 6
#
# Nomenclatura:
#  PG  - Pontos Ganhos
#  J   - Jogos
#  V   - Vitórias
#  E   - Empates
#  D   - Derrotas
#  GP  - Gols Pró
#  GC  - Gols Contra
#  SG  - Saldo de Gols
#  (%) - Aproveitamento (pontos)
#
# Uso: zzlibertadores [ fase | -c [número] | -g <número> ]
# Ex.: zzlibertadores 2     # Jogos da Fase 2 (Grupos)
#      zzlibertadores -g 5  # Jogos do grupo 5 da fase 2
#      zzlibertadores -c    # Calssificação de todos os grupos
#      zzlibertadores -c 3  # Classificação no grupo 3
#      zzlibertadores -cg 7 # Classificação e jogos do grupo 7
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-17
# Versão: 11
# Licença: GPL
# Requisitos: zzecho zzpad
# ----------------------------------------------------------------------------
zzlibertadores ()
{
	zzzz -h libertadores "$1" && return

	local ano=$(date +%Y)
	local url="http://esporte.uol.com.br/futebol/campeonatos/libertadores/jogos"
	local awk_jogo='
		NR % 3 == 1 { time1=$0 }
		NR % 3 == 2 { if ($NF ~ /^[0-9]$/) { reserva=$NF " "; $NF=""; } else reserva=""; time2=reserva $0 }
		NR % 3 == 0 { sub(/  *$/,""); print time1 "|" time2 "|" $0 }
		'
	local sed_mata='
		1d; $d
		/Confronto/d;/^ *$/d;
		s/pós[ -]jogo//; s/^ *//; s/__*//g; s/[A-Z][A-Z][A-Z] //;
		s/\([0-9]\{1,\}\) *pênaltis *\([0-9]\{1,\}\)\(.*\) X \(.*$\)/\3 (\1 X \2) \4/g
	'
	local time1 time2 horario linha

	test -n "$1" || { zztool -e uso libertadores; return 1; }

	# Mostrando os jogos
	# Escolhendo as fases
	# Fase 1 (Pré-libertadores)
	case "$1" in
	1 | pr[eé] | primeira)
		$ZZWWWDUMP "$url" | sed -n '/PRIMEIRA FASE/,/SEGUNDA/p' |
		sed "$sed_mata" |
		awk "$awk_jogo" |
		while read linha
		do
			time1=$(  echo $linha | cut -d"|" -f 1 )
			time2=$(  echo $linha | cut -d"|" -f 2 )
			horario=$(echo $linha | cut -d"|" -f 3 )
			echo "$(zzpad -l 28 $time1) X $(zzpad -r 28 $time2) $horario"
		done
	;;
	# Fase 2 (Fase de Grupos)
	2 | grupos | segunda)
		for grupo in 1 2 3 4 5 6 7 8
		do
			zzlibertadores -g $grupo
			echo
		done
	;;
	3 | oitavas)
		$ZZWWWDUMP "$url" | sed -n '/^OITAVAS DE FINAL/,/^ *\*/p' |
		sed "$sed_mata" |
		sed 's/.*\([0-9]º\)/\1/' |
		awk "$awk_jogo" |
		while read linha
		do
			time1=$(  echo $linha | cut -d"|" -f 1 )
			time2=$(  echo $linha | cut -d"|" -f 2 )
			horario=$(echo $linha | cut -d"|" -f 3 )
			echo "$(zzpad -l 28 $time1) X $(zzpad -r 28 $time2) $horario"
		done
	;;
	4 | quartas)
		$ZZWWWDUMP "$url" | sed -n '/^Quartas de Final/,/^Oitavas de Final/p' |
		sed "$sed_mata" |
		awk 'BEGIN {FS=" X "} {if (NF>=2){printf "%23s X %-23s   ", $1, $2; getline proxima; print proxima } }'
	;;
	5 | semi | semi-final)
		$ZZWWWDUMP "$url" | sed -n '/^Semifinal/,/^Quartas de Final/p' |
		sed "$sed_mata" |
		awk 'BEGIN {FS=" X "} {if (NF>=2){printf "%23s X %-23s   ", $1, $2; getline proxima; print proxima } }'
	;;
	6 | final)
		$ZZWWWDUMP "$url" | sed -n '/^Final/,/^Semifinal/p' |
		sed "$sed_mata" |
		awk 'BEGIN {FS=" X "} {if (NF>=2){printf "%23s X %-23s   ", $1, $2; getline proxima; print proxima } }'
	;;
	esac

	# Escolhendo o grupo para os jogos
	if test "$1" = "-g" && zztool testa_numero $2 && test $2 -le 8  -a $2 -ge 1
	then
		echo "Grupo $2"
		$ZZWWWDUMP "$url" |
		sed -n "/^ *Grupo $2/,/Grupo /p" |
		sed '
			/Rodada [2-9]/d;
			/Classificados para as oitavas de final/,$d
			1,5d' |
		sed "$sed_mata" |
		awk "$awk_jogo" |
		sed 's/\(h[0-9][0-9]\).*$/\1/' |
		while read linha
		do
			time1=$(  echo $linha | cut -d"|" -f 1 )
			time2=$(  echo $linha | cut -d"|" -f 2 )
			horario=$(echo $linha | cut -d"|" -f 3 )
			echo "$(zzpad -l 28 $time1) X $(zzpad -r 28 $time2) $horario"
		done
	fi

	# Mostrando a classificação (Fase de grupos)
	if test "$1" = "-c" -o "$1" = "-cg" -o "$1" = "-gc"
	then
		if zztool testa_numero $2 && test $2 -le 8  -a $2 -ge 1
		then
			grupo="$2"
			$ZZWWWDUMP "$url" | sed -n "/^ *Grupo $2/,/Rodada 1/p" | sed -n '/PG/p;/°/p' |
			sed 's/[^-][A-Z][A-Z][A-Z] //;s/ [A-Z][A-Z][A-Z]//' |
			awk -v cor_awk="$ZZCOR" '{
				if (NF <  10) { print }
				if (NF == 10) {
					printf "%-28s", $1
					for (i=2;i<=10;i++) { printf " %3s", $i }
					print ""
				}
				if (NF > 10) {
					if (cor_awk==1 && ($1 == "1°" || $1 == "2°")) { printf "\033[42;30m" } else { printf "\033[m" }
					time=""
					for (i=1;i<NF-8;i++) { time=time " " $i }
					printf "%-28s", time
					for (i=NF-8;i<=NF;i++) { printf " %3s", $i }
					printf "\033[m\n"
				}
			}'
			test "$1" = "-cg" -o "$1" = "-gc" && { echo; zzlibertadores -g $2 | sed '1d'; }
		else
			for grupo in 1 2 3 4 5 6 7 8
			do
				zzlibertadores -c $grupo -n
				test "$1" = "-cg" -o "$1" = "-gc" && { echo; zzlibertadores -g $grupo | sed '1d'; }
				echo
			done
		fi
		test "$3" != "-n" && { echo ""; zzecho -f verde -l preto " Oitavas de Final "; }
	fi
}

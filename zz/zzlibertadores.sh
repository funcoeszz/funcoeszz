# ----------------------------------------------------------------------------
# Mostra a classificação e jogos do torneio Libertadores da América.
# Opções:
#  <número> | <fase>: Mostra jogos da fase selecionada
#    fases: pre ou primeira, grupos ou segunda, oitavas
#  -g <número>: Jogos da segunda fase do grupo selecionado
#  -c [número]: Mostra a classificação, nos grupos da segunda fase
#  -cg <número> ou -gc <número>: Classificação e jogos do grupo selecionado.
#
# As fases podem ser:
#  pré, pre, primeira ou 1, para a fase pré-libertadores
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
# Obs.: Se a opção for --atualiza, o cache usado é renovado
#
# Uso: zzlibertadores [ fase | -c [número] | -g <número> ]
# Ex.: zzlibertadores 2     # Jogos da Fase 2 (Grupos)
#      zzlibertadores -g 5  # Jogos do grupo 5 da fase 2
#      zzlibertadores -c    # Classificação de todos os grupos
#      zzlibertadores -c 3  # Classificação no grupo 3
#      zzlibertadores -cg 7 # Classificação e jogos do grupo 7
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-17
# Versão: 15
# Licença: GPL
# Requisitos: zzecho zzpad zzdatafmt
# Tags: internet, futebol, consulta
# ----------------------------------------------------------------------------
zzlibertadores ()
{
	zzzz -h libertadores "$1" && return

	local ano=$(date +%Y)
	local cache=$(zztool cache libertadores)
	local url="http://esporte.uol.com.br/futebol/campeonatos/libertadores/jogos/"
	local awk_jogo='
		NR % 3 ~ /^[12]$/ {
			if ($1 ~ /^[0-9-]+$/ && $2 ~ /^[0-9-]+$/) {
				penais[NR % 3]=$1; placar[NR % 3]=$2; $1=""; $2=""
			}
			else if ($1 ~ /^[0-9-]+$/ && $2 !~ /^[0-9-]+$/) {
				penais[NR % 3]=""; placar[NR % 3]=$1; $1=""
			}
			sub(/^ */,"");sub(/ *$/,"")
			time[NR % 3]=" " $0 " "
		}
		NR % 3 == 0 {
			if (length(penais[1])>0 && length(penais[2])>0) {
				placar[1] = placar[1] " ( " penais[1]
				placar[2] = penais[2] " ) " placar[2]
			}
			else {
				penais[1]="";penais[2]=""
			}
			sub(/  *$/,""); print time[1] placar[1] "|" placar[2] time[2] "|" $0
			placar[1]="";placar[2]=""
		}
		'
	local sed_mata='
		1d; $d
		/Confronto/d;/^ *$/d;
		s/pós[ -]jogo *//; s/^ *//; s/__*//g; s/ [A-Z][A-Z][A-Z]//;
	'
	local time1 time2 horario linha

	test -n "$1" || { zztool -e uso libertadores; return 1; }

	# Tempo de resposta do site está elevando, usando cache para minimizar efeito
	test '--atualiza' = "$1" && { zztool cache rm libertadores; shift; }
	if ! test -s "$cache" || test $(head -n 1 "$cache") != $(zzdatafmt --iso hoje)
	then
		zzdatafmt --iso hoje > "$cache"
		zztool dump "$url" >> "$cache"
	fi

	# Mostrando os jogos
	# Escolhendo as fases
	# Fase 1 (Pré-libertadores)
	case "$1" in
	1 | pr[eé] | primeira)
		sed -n '/PRIMEIRA FASE/,/FASE DE GRUPOS/{/FASE/d; p;}' "$cache" |
		sed "$sed_mata" |
		awk "$awk_jogo" |
		while read linha
		do
			time1=$(  echo $linha | cut -d"|" -f 1 )
			time2=$(  echo $linha | cut -d"|" -f 2 )
			horario=$(echo $linha | cut -d"|" -f 3 )
			echo "$(zzpad -l 45 $time1) X $(zzpad -r 45 $time2) $horario"
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
		sed -n '/^OITAVAS DE FINAL/,/^Notícias/p' "$cache" |
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
	4 | quartas | 5 | semi | semi-final | 6 | final)
		case $1 in
		4 | quartas)
			sed -n '/^QUARTAS DE FINAL/,/^OITAVAS DE FINAL/p' "$cache";;
		5 | semi | semi-final)
			sed -n '/^SEMIFINAIS/,/^QUARTAS DE FINAL/p' "$cache";;
		6 | final)
			sed -n '/^FINAL/,/^SEMIFINAIS/p' "$cache";;
		esac |
		sed "$sed_mata" |
		sed 's/.*Vencedor/Vencedor/' |
		awk "$awk_jogo" |
		while read linha
		do
			time1=$(  echo $linha | cut -d"|" -f 1 )
			time2=$(  echo $linha | cut -d"|" -f 2 )
			horario=$(echo $linha | cut -d"|" -f 3 )
			echo "$(zzpad -l 28 $time1) X $(zzpad -r 28 $time2) $horario"
		done
	;;
	esac

	# Escolhendo o grupo para os jogos
	if test '-g' = "$1" && zztool testa_numero $2 && test $2 -le 8  -a $2 -ge 1
	then
		echo "Grupo $2"
		sed -n "/^ *Grupo $2/,/Grupo /p"  "$cache"|
		sed '
			1d; /°/d; /Rodada [2-9]/d;
			/ para as oitavas de final/,$d
			' |
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
	if test '-c' = "$1" -o '-cg' = "$1" -o '-gc' = "$1"
	then
		if zztool testa_numero $2 && test $2 -le 8  -a $2 -ge 1
		then
			grupo="$2"
			sed -n "/^ *Grupo $2/,/Rodada 1/p" "$cache" | sed -n '/PG/p;/°/p' |
			sed 's/ LDU / ldu /g'|
			sed 's/[^-][A-Z][A-Z][A-Z] //;s/ [A-Z][A-Z][A-Z]//' |
			sed 's/ ldu / LDU /g'|
			awk -v cor_awk="$ZZCOR" '{
				if (NF <  10) { print }
				if (NF == 10) {
					printf "%-28s", $1
					for (i=2;i<=10;i++) { printf " %3s", $i }
					print ""
				}
				if (NF > 10) {
					if (cor_awk==1 && ($1 == "1°" || $1 == "2°")) { printf "\033[42;30m" }
					time=""
					for (i=1;i<NF-8;i++) { time=time " " $i }
					printf "%-28s", time
					for (i=NF-8;i<=NF;i++) { printf " %3s", $i }
					if (cor_awk==1) { printf "\033[m\n" } else {print ""}
				}
			}'
			test '-cg' = "$1" -o '-gc' = "$1" && { echo; zzlibertadores -g $2 | sed '1d'; }
		else
			for grupo in 1 2 3 4 5 6 7 8
			do
				zzlibertadores -c $grupo -n
				test '-cg' = "$1" -o '-gc' = "$1" && { echo; zzlibertadores -g $grupo | sed '1d'; }
				echo
			done
		fi
		if test $ZZCOR -eq 1
		then
			test '-n' != "$3" && { echo ""; zzecho -f verde -l preto " Oitavas de Final "; }
		fi
	fi
}

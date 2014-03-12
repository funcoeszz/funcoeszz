# ----------------------------------------------------------------------------
# Mostra a classificação e jogos do torneio Libertadores da América.
# Opções:
#  <número> | <fase>: Mostra jogos da fase selecionada
#    fases: pre ou primeira, grupos ou segunda, oitavas
#  -g <número>: Jogos da segunda fase do gupo selecionado
#  -c [numero]: Mostra a classificação, nos grupos da segunda fase
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
#	PG  - Pontos Ganhos
#	J   - Jogos
#	V   - Vitórias
#	E   - Empates
#	D   - Derrotas
#	GP  - Gols Pró
#	GC  - Gols Contra
#	SG  - Saldo de Gols
#	(%) - Aproveitamento (pontos)
#
# Uso: zzlibertadores [ fase | -c [número] | -g <número> ]
# Ex.: zzlibertadores 2     # Jogos da Fase 2 (Grupos)
#      zzlibertadores -g 5  # Jogos do grupo 5 da fase 2
#      zzlibertadores -c    # Calssificação de todos os grupos
#      zzlibertadores -c 3  # Classificação no grupo 3
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-17
# Versão: 6
# Licença: GPL
# ----------------------------------------------------------------------------
zzlibertadores ()
{
	zzzz -h libertadores "$1" && return

	local ano=$(date +%Y)
	local url="http://esporte.uol.com.br/futebol/campeonatos/libertadores/jogos"
	local grupo

	[ "$1" ] || { zztool uso libertadores; return 1; }

	# Mostrando os jogos
	# Escolhendo as fases
	# Fase 1 (Pré-libertadores)
	case "$1" in
	1 | pr[eé] | primeira)
		$ZZWWWDUMP "$url" | sed -n '/Primeira Fase/,/Segunda/p' |
		sed '1d;$d;/Confronto/d;/pós jogo/d;/^ *$/d;s/^ *//;s/[A-Z][A-Z][A-Z] //;s/ [A-Z][A-Z][A-Z]//' |
		awk '{if (NR%2==0){print} else {printf "%-60s ", $0}}' |
		awk 'BEGIN {FS="( X )|( {4,})"} {if (NF>=2){printf "%29s X %-29s %s\n", $1, $2, $3} else print }'

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
		$ZZWWWDUMP "$url" | sed -n '/^Oitavas de Final/,/^ *\*/p' |
		sed '1d;$d;/Confronto/d;/pós jogo/d;/^ *$/d;s/^ *//;s/[A-Z][A-Z][A-Z] //;s/ [A-Z][A-Z][A-Z]//' |
		awk 'BEGIN {FS="( X )|( {4,})"} {if (NF>=2){printf "%29s X %-29s %s\n", $1, $2, $3} else print }'

	;;
	4 | quartas)
		$ZZWWWDUMP "$url" | sed -n '/^Quartas de Final/,/^Oitavas de Final/p' |
		sed '1d;$d;/Confronto/d;/pós jogo/d;/^ *$/d;s/^ *//;s/[A-Z][A-Z][A-Z] //;s/ [A-Z][A-Z][A-Z]//' |
		awk 'BEGIN {FS="( X )|( {4,})"} {if (NF>=2){printf "%29s X %-29s %s\n", $1, $2, $3} else print }'

	;;
	5 | semi | semi-final)
		$ZZWWWDUMP "$url" | sed -n '/^Semifinal/,/^Quartas de Final/p' |
		sed '1d;$d;/Confronto/d;/pós jogo/d;/^ *$/d;s/^ *//;s/[A-Z][A-Z][A-Z] //;s/ [A-Z][A-Z][A-Z]//' |
		awk 'BEGIN {FS="( X )|( {4,})"} {if (NF>=2){printf "%29s X %-29s %s\n", $1, $2, $3} else print }'

	;;
	6 | final)
		$ZZWWWDUMP "$url" | sed -n '/^Final/,/^Semifinal/p' |
		sed '1d;$d;/Confronto/d;/pós jogo/d;/^ *$/d;s/^ *//;s/[A-Z][A-Z][A-Z] //;s/ [A-Z][A-Z][A-Z]//' |
		awk 'BEGIN {FS="( X )|( {4,})"} {if (NF>=2){printf "%29s X %-29s %s\n", $1, $2, $3} else print }'

	;;
	esac

	# Escolhendo o grupo para os jogos
	if [ "$1" = "-g" ] && zztool testa_numero $2 && [ $2 -le 8  -a $2 -ge 1 ]
	then
		grupo="$2"
		echo "Grupo $2"
		$ZZWWWDUMP "$url" | sed -n "/^ *Grupo $2/,/Grupo /p" |
		sed '/Classificados para Oitavas de Final/,$d;/pós jogo/d;s/^ *//' | sed -n '/ X /{N;p;}' |
		sed 's/[A-Z][A-Z][A-Z] //;s/ [A-Z][A-Z][A-Z]//' |
		awk '{if (NR%2==0){print} else {printf "%-60s ", $0}}' |
		awk 'BEGIN {FS="( X )|( {4,})"} {if (NF>=2){printf "%29s X %-29s %s\n", $1, $2, $3} else print }'

	fi

	# Mostrando a classificação (Fase de grupos)
	if [ "$1" = "-c" ]
	then
		if [ "$1" = "-c" ] && zztool testa_numero $2 && [ $2 -le 8  -a $2 -ge 1 ]
		then
			grupo="$2"
			$ZZWWWDUMP "$url" | sed -n "/^ *Grupo $2/,/Rodada 1/p" | sed -n '1p;/PG/p;/°/p' |
			sed 's/[A-Z][A-Z][A-Z] //;s/ [A-Z][A-Z][A-Z]//'
		else
			for grupo in 1 2 3 4 5 6 7 8
			do
				zzlibertadores -c $grupo
				echo
			done
		fi
	fi
}

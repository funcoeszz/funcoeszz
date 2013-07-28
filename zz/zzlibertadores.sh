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
#	P   - Pontos Ganhos
#	J   - Jogos
#	V   - Vitórias
#	E   - Empates
#	D   - Derrotas
#	GP  - Gols Pró
#	GC  - Gols Contra
#	SG  - Saldo de Gols
#	(%) - Aproveitamento (pontos)
#
# Uso: zzlibertadores [ fase | -c []número] | -g <número> ]
# Ex.: zzlibertadores 2     # Jogos da Fase 2 (Grupos)
#      zzlibertadores -g 5  # Jogos do grupo 5 da fase 2
#      zzlibertadores -c    # Calssificação de todos os grupos
#      zzlibertadores -c 3  # Classificação no grupo 3
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-17
# Versão: 5
# Licença: GPL
# ----------------------------------------------------------------------------
zzlibertadores ()
{
	zzzz -h libertadores "$1" && return

	local ano=$(date +%Y)
	local url="http://esporte.uol.com.br/futebol/campeonatos/libertadores/$ano"
	local grupo

	[ "$1" ] || { zztool uso libertadores; return 1; }

	# Mostrando os jogos
	# Escolhendo as fases
	url="${url}/tabela-de-jogos"
	# Fase 1 (Pré-libertadores)
	case "$1" in
	1 | pr[eé] | primeira)
		url="${url}/primeira-fase"
		$ZZWWWDUMP "$url" | sed -n '/Primeira fase - IDA/,/primeira-fase/p' |
		sed '$d;s/RELATO//g;s/Ler o relato .*//g;s/^ *Primeira fase/\n&/g' | sed "s/.*${ano}$/\n&/g"
	;;
	# Fase 2 (Fase de Grupos)
	2 | grupos | segunda)
		for grupo in 1 2 3 4 5 6 7 8
		do
			zzlibertadores -g $grupo
		done
	;;
	3 | oitavas)
		url="${url}/oitavas-de-final"
		$ZZWWWDUMP "$url" | sed -n '/Oitavas de final - IDA/,/^ *$/p' |
		sed "s/ *RELATO.*//g;s/ *Ler o relato.*//g" | sed '$d;/^ *\*/d' |
		sed 's/ *Oitavas de final - VOLTA/\n&/;'
	;;
	4 | quartas)
		url="${url}/quartas-de-final"
		$ZZWWWDUMP "$url" | sed -n '/Quartas de final - IDA/,/^ *$/p' |
		sed "s/ *RELATO.*//g;s/ *Ler o relato.*//g" | sed '$d;/^ *\*/d' |
		sed 's/ *Quartas de final - VOLTA/\n&/;'
	;;
	5 | semi | semi-final)
		url="${url}/semifinal"
		$ZZWWWDUMP "$url" | sed -n '/Semifinal - IDA/,/^ *$/p' |
		sed "s/ *RELATO.*//g;s/ *Ler o relato.*//g" | sed '$d;/^ *\*/d' |
		sed 's/ *Semifinal - VOLTA/\n&/;'
	;;
	6 | final)
		url="${url}/final"
		$ZZWWWDUMP "$url" | sed -n '/Final - IDA/,/^ *$/p' |
		sed "s/ *RELATO.*//g;s/ *Ler o relato.*//g" | sed '$d;/^ *\*/d' |
		sed 's/ *Final - VOLTA/\n&/;'
	;;
	esac

	# Escolhendo o grupo para os jogos
	if [ "$1" = "-g" ] && zztool testa_numero $2 && [ $2 -le 8  -a $2 -ge 1 ]
	then
		grupo="$2"
		url="${url}/segunda-fase/grupo-${grupo}.htm"
		$ZZWWWDUMP "$url" | sed -n '/^ *Grupo /,/segunda-fase/p' |
		sed '$d;s/RELATO//g;s/Ler o relato .*//g;s/^ *Grupo/\n&/g'
	fi

	# Mostrando a classificação (Fase de grupos)
	if [ "$1" = "-c" ]
	then
		if [ "$1" = "-c" ] && zztool testa_numero $2 && [ $2 -le 8  -a $2 -ge 1 ]
		then
			grupo="$2"
			url="http://esportes.terra.com.br/bcg/pt-br.libertadores-${ano}_segunda-fase.html"
			$ZZWWWDUMP "$url"| iconv -f utf8 -t iso-8859-1 | sed -n "/Grupo $grupo/,/Anterior/p" |
			sed '/^ *$/d;s/Subiu[0-9]*//g;s/Desceu[0-9]*//g;s/Anterior//g;s/Times//g;s/^ *\*//g' |
			awk -v cor_awk="$ZZCOR" '{
				if (NF >= 9) {
					time_fut = $2

					for (i=3;i<(NF-8);i++) {
						if ($i != $2) {
							time_fut = time_fut " " $i
						} else {
							break
						}
					}

					if (NF==9) {
						printf " %s %-25s", " ", " "
						printf " %3s %3s %3s %3s %3s %3s %3s %3s %3s\n", $(NF-8), $(NF-7), $(NF-6), $(NF-5), $(NF-4), $(NF-3), $(NF-2), $(NF-1), $NF
					}

					if (NF>9) {
						if (cor_awk==1 && ($1==1 || $1==2)) printf "\033[42;30m"
						printf "%s %-25s ", $1, time_fut
						printf " %3s %3s %3s %3s %3s %3s %3s %3s %3s", $(NF-8), $(NF-7), $(NF-6), $(NF-5), $(NF-4), $(NF-3), $(NF-2), $(NF-1), $NF
						if (cor_awk==1 && ($1==1 || $1==2)) printf "\033[m"
						printf "\n"
					}
				}
				else print
			}'
			[ "$3" != "-n" -a "$ZZCOR" -eq "1" ] && printf "\033[42;30m Classificados \033[m\n"

		else
			for grupo in 1 2 3 4 5 6 7 8
			do
				zzlibertadores -c $grupo -n
			done
			[ "$ZZCOR" -eq "1" ] && printf "\033[42;30m Classificados \033[m\n"
		fi
	fi
}

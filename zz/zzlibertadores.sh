# ----------------------------------------------------------------------------
# Mostra a classificação e jogos do torneio Libertadores da América
# Opções:
#  -j <número>: Mostra jogos da fase selecionada
#  -g <número>: Jogos da segunda fase do gupo selecionado
#  -c [numero]: Mostra a classificação, nos grupos da segunda fase
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
# Uso: zzlibertadores <-c|-j|-g> [número]
# Exemplo: zzlibertadores -j 2  # Jogos da Fase 2 (Grupos)
#          zzlibertadores -g 5  # Jogos do grupo 5 da fase 2
#          zzlibertadores -c    # Calssificação de todos os grupos
#          zzlibertadores -c 3  # Classificação no grupo 3
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-17
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzlibertadores ()
{
	local ano=$(date +%Y)
	local url="http://esporte.uol.com.br/futebol/campeonatos/libertadores/$ano"
	local grupo
	
	[ "$1" ] || { zztool uso libertadores; return 1; }
	
	# Mostrando os jogos
	# Escolhendo as fases
	if [ "$1" = "-j" ]
	then
		url="${url}/tabela-de-jogos"
		# Fase 1 (Pré-libertadores)
		if [ "$2" = "1" ]
		then
			url="${url}/primeira-fase"
			$ZZWWWDUMP "$url" | sed -n '/Primeira fase - IDA/,/primeira-fase/p' |
			sed '$d;s/RELATO//g;s/Ler o relato .*//g;s/^ *Primeira fase/\n&/g'| sed "s/.*${ano}$/\n&/g"
		fi
		
		# Fase 2 (Fase de Grupos)
		if [ "$2" = "2" ]
		then
			for grupo in 1 2 3 4 5 6 7 8
			do
				zzlibertadores -g $grupo
			done
		fi
	fi
	
	# Escolhendo o grupo para os jogos
	if [ "$1" = "-g" ] && zztool testa_numero $2 && [ $2 -le 8  -a $2 -ge 1 ]
	then
		grupo="$2"
		url="${url}/tabela-de-jogos/segunda-fase/grupo-${grupo}.htm"
		$ZZWWWDUMP "$url" | sed -n '/^ *Grupo /,/segunda-fase/p' |
		sed '$d;s/RELATO//g;s/Ler o relato .*//g;s/^ *Grupo/\n&/g'
	fi
	
	# Mostrando a classificação (Fase de grupos)
	if [ "$1" = "-c" ]
	then
		if [ "$1" = "-c" ] && zztool testa_numero $2 && [ $2 -le 8  -a $2 -ge 1 ]
		then
			grupo="$2"
			url="http://esportes.terra.com.br/futebol/libertadores/"
			$ZZWWWDUMP "$url" | sed -n "/Grupo $grupo/,/Anterior/p"| 
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

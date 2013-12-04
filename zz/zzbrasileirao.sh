# ----------------------------------------------------------------------------
# http://esporte.uol.com.br/
# Mostra a tabela atualizada do Campeonato Brasileiro - Série A, B ou C.
# Se for fornecido um numero mostra os jogos da rodada, com resultados.
# Com argumento -l lista os todos os clubes da série A e B.
# Se o argumento -l for seguido do nome do clube, lista todos os jogos já
# ocorridos do clube desde o começo do ano de qualquer campeonato.
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
# Uso: zzbrasileirao [a|b|c] [numero rodada] ou zzbrasileirao -l [nome clube]
# Ex.: zzbrasileirao
#      zzbrasileirao a
#      zzbrasileirao b
#      zzbrasileirao c
#      zzbrasileirao 27
#      zzbrasileirao b 12
#      zzbrasileirao -l
#      zzbrasileirao -l portuguesa
#
# Autor: Alexandre Brodt Fernandes, www.xalexandre.com.br
# Desde: 2011-05-28
# Versão: 16
# Licença: GPL
# Requisitos: zzxml
# ----------------------------------------------------------------------------
zzbrasileirao ()
{
	zzzz -h brasileirao "$1" && return

	local rodada serie ano urls
	local url="http://esporte.uol.com.br"

	[ $# -gt 2 ] && { zztool uso brasileirao; return 1; }

	serie='a'
	[ "$1" = "a" -o "$1" = "b" -o "$1" = "c" ] && { serie="$1"; shift; }

	if [ "$1" = "-l" ]
	then
		if [ "$2" ]
		then
			$ZZWWWDUMP "${url}/futebol/times/$2/resultados" | sed -n "/Data  .*Campeonato/,/Comunicar erro/p" |
			awk '
				BEGIN { printf "%-14s  %-20s  %-43s %s\n", "     Data","     Campeonato","                   Jogos","     Local"}
				$2 ~ /[0-9][0-9]h[0-9][0-9]/ { linha=1 }
				{ if (linha != 2 || linha != 4 || linha > 0)
					{
						tam_ini = length()
						if (linha != 1 )gsub(/^  */,"")
						tam[linha] = tam_ini - length()
						if ($0 !~ /Comunicar erro/) { jogo[linha] = $0 } else { jogo[linha] = "" }
					}
					if (linha==6) {
						sub(/^ */,"",jogo[1])
						sub(/^ */,"",jogo[3])
						sub("penâltis","pen", jogo[3])
						sub(/^ */,"",jogo[5])
						sub(/^ */,"",jogo[6])
						printf "%-35s  %-43s  %s\n", jogo[1], jogo[3], jogo[5] " (" jogo[6] ")"
					}
					linha++
				}
			'
			return 0
		else
			$ZZWWWHTML "$url/futebol/" | zzxml --tidy |
			sed -n '/<li class="serie-[ab] [^>]*>/p;' |
			awk '{print $3}' | sort
			return 0
		fi
	else
		if [ "$1" ]
		then
			zztool testa_numero "$1" && rodada="$1" || { zztool uso brasileirao; return 1; }
		fi
	fi

	[ $(date +%Y%m%d) -lt 20130525 ] && { zztool eco " Brasileirão 2013 só a partir de 25 de Maio"; return 1; }

	ano=$(date +%Y)

	url="${url}/futebol/campeonatos/brasileiro/${ano}/serie-${serie}"
	if [ "$rodada" ]
	then
		zztool testa_numero $rodada || { zztool uso brasileirao; return 1; }
		# url="${url}/tabela-de-jogos/tabela-de-jogos-${rodada}a-rodada.htm"
		url="${url}/tabela-de-jogos/fase-unica/tabela-de-jogos-${rodada}a-rodada.htm"
		$ZZWWWDUMP $url | sed -n "/ RODADA - /,/^ *\* http/p" |
		sed "s/ *RELATO.*//g;s/ *Ler o relato.*//g" | sed '$d'
	else
		# urls="${url}/classificacao/classificacao.htm"
		if [ "$serie" = "a" ]
		then
			urls="http://esporte.uol.com.br/futebol/campeonatos/brasileirao/jogos/"
		else
			urls="${url}/classificacao/fase-unica"
		fi

		[ "$serie" = "a" ] && zztool eco "Série A"
		[ "$serie" = "b" ] && zztool eco "Série B"
		if [ "$serie" = "c" ]
		then
			zztool eco "Série C"
			# urls="${url}/classificacao/classificacao-grupo-a.htm ${url}/classificacao/classificacao-grupo-b.htm"
			urls="${url}/classificacao/primeira-fase/grupo-a ${url}/classificacao/primeira-fase/grupo-b"

		fi

		for url in $urls
		do
			if [ "$serie" = "c" ]
			then
				echo
				echo "$url" |sed 's/.*grupo-/Grupo /;s/\.htm//' | tr 'ab' 'AB'
			fi

			$ZZWWWDUMP $url | sed  -n "/^ *Time *PG/,/^ *\* /p;/^ *Classificação *PG/,/20°/p;" |
			sed '/^ *$/d' | sed '/^ *[0-9]\{1,\} *$/{N;N;s/\n//g;}' | sed 's/\([0-9]\{1,\}\) */\1 /g;/^ *PG/d' |
			awk -v cor_awk="$ZZCOR" -v serie_awk="$serie" '{ time=""; for(ind=1;ind<=(NF-9);ind++) { time = time sprintf(" %3s",$ind) }

			if (cor_awk==1)
			{
				cor="\033[m"

				if (NR >= 18 && NR <=21)
					cor="\033[41;30m"

				if (NR >= 6 && NR <=13)
					cor=(serie_awk=="a"?"\033[46;30m":"\033[m")

				if (NR >=10 && NR <= 11 && serie_awk=="c")
					cor="\033[41;30m"

				if (NR >= 2 && NR <=5)
					cor="\033[42;30m"
			}

			gsub(/ +/," ",time)
			sub (/^ [0-9] /, " &", time)
			if (NF>9)
			printf "%s%-23s %3s %3s %3s %3s %3s %3s %3s %3s %4s \033[m\n", cor, time, $(NF-8), $(NF-7), $(NF-6), $(NF-5), $(NF-4), $(NF-3), $(NF-2), $(NF-1), $NF}'

			if [ "$ZZCOR" = "1" ]
			then
				echo
				if [ "$serie" = "a" ]
				then
					printf "\033[42;30m Libertadores \033[m"
					printf "\033[46;30m Sul-Americana \033[m"
				elif [ "$serie" = "b" ]
				then
					printf "\033[42;30m   Série  A   \033[m"
				else
					printf "\033[42;30m  Classifica  \033[m"
				fi
				printf "\033[41;30m Rebaixamento \033[m\n"
			fi
		done
	fi
}

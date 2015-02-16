# ----------------------------------------------------------------------------
# http://esporte.uol.com.br/
# Mostra a tabela atualizada do Campeonato Brasileiro - Série A, B, C ou D.
# Se for fornecido um numero mostra os jogos da rodada, com resultados.
# Com argumento -l lista os todos os clubes da série A e B.
# Se o argumento -l for seguido do nome do clube, lista todos os jogos já
# ocorridos do clube desde o começo do ano de qualquer campeonato.
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
# Versão: 21
# Licença: GPL
# Requisitos: zzxml zzlimpalixo zztac
# ----------------------------------------------------------------------------
zzbrasileirao ()
{
	zzzz -h brasileirao "$1" && return

	test $(date +%Y%m%d) -lt 20150509 && { zztool eco " Brasileirão 2015 só a partir de 9 de Maio."; return 1; }

	local rodada serie ano urls
	local url="http://esporte.uol.com.br/futebol"

	test $# -gt 2 && { zztool uso brasileirao; return 1; }

	serie='a'
	test "$1" = "a" -o "$1" = "b" -o "$1" = "c" -o "$1" = "d" && { serie="$1"; shift; }

	if test "$1" = "-l"
	then
		if test -n "$2"
		then
			awk 'BEGIN { printf "%-14s  %-20s  %-43s %s\n", "     Data","     Campeonato","             Jogos","     Local"}'
			for urls in resultados proximos-jogos
			do
				$ZZWWWDUMP "${url}/times/$2/${urls}" | sed -n "/Data .*Campeonato/,/Comunicar erro/{/pós jogo/d;p;}" | zzlimpalixo |
				awk 'BEGIN { split("",jogo) }
				{
					if (length(jogo)>0 && ( $2 ~ /[0-9][0-9]h[0-9][0-9]/ || $0 ~ /Comunicar erro/))
					{
						printf "%-35s  %-43s  %s\n", jogo["data"], jogo["times"], jogo["estadio"] (length(jogo)==4 ? " (" jogo["cidade"] ")" :  "")
						split("",jogo)
					}
					pular = 0
					if ($2 ~ /[0-9][0-9]h[0-9][0-9]/) { sub(/^/,"   ",$3); sub(/^ */,""); jogo["data"] = $0 }
					if ($0 ~ / X /) { sub(/^ */,""); sub(/^[A-Z]{3}/,""); sub(/[A-Z]{3}$/,""); jogo["times"] = $0}
					{
						if (length(jogo)==2) { getline; sub(/^ */,""); jogo["estadio"] = $0; pular = 1 }
					}
					{
						if (length(jogo)==3 && pular == 0) { sub(/^ */,""); jogo["cidade"] = $0 }
					}
				}' |
				if test $urls = 'resultados'
				then
					zztac
				else
					cat -
				fi
				echo
			done
			return 0
		else
			$ZZWWWHTML "$url" | zzxml --tidy |
			sed -n '/<li class="serie-[ab] [^>]*>/p;' |
			awk '{print $3}' | sort
			return 0
		fi
	else
		if test -n "$1"
		then
			zztool testa_numero "$1" && rodada="$1" || { zztool uso brasileirao; return 1; }
		fi
	fi

	test "$serie" = "a" && url="${url}/campeonatos/brasileirao/jogos" || url="${url}/campeonatos/serie-${serie}/jogos"

	if test -n "$rodada"
	then
		zztool testa_numero $rodada || { zztool uso brasileirao; return 1; }
		$ZZWWWDUMP $url | sed '/pós jogo/d;/ X /s/^/\
/;' |
		awk 'BEGIN { FS=" X " }
			/Rodada '$rodada'$/,/(Rodada '$((rodada+1))'|Zona)/ {
				if (NF >= 2) {
					time1 = $1; sub(/^ */,"", time1); sub(/^[A-Z]{3}/,"", time1); sub(/ *$/,"", time1)
					time2 = $2; sub(/^ */,"", time2); sub(/[A-Z]{3}$/,"", time2); sub(/ *$/,"", time2)
					getline; sub(/^ */,""); data = $0
					printf "%20s  X  %-20s  %s\n", time1, time2, data
				}
			}
		' | sed '/^ *$/d'
	else
		zztool eco $(echo "Série $serie" | tr 'abcd' 'ABCD')
		if test "$serie" = "c" -o "$serie" = "d"
		then
			$ZZWWWDUMP $url |
			awk -v cor_awk="$ZZCOR" -v serie_awk=$serie '
			/Grupo (A|B)/,/10°/ { if (serie_awk=="c") {
				cor="\033[m"
				if (cor_awk==1) {
					if ($1 ~ /9°/ || $1 ~ /10°/) { cor="\033[41;30m" }
					else if ($1 ~ /[1-4]°/) { cor="\033[42;30m" }
					else { cor="\033[m" }
				}
				if ($0 ~ /Grupo/) {print "";print $1, $2 ;getline;getline;getline;}
				else { printf "%s%s\033[m\n", cor, $0 }
			}}
			/Grupo A/,/Rodada 1/ { if (serie_awk=="d") {
				cor="\033[m"
				if (cor_awk==1) {
					if ($1 ~ /[12]°/) { cor="\033[42;30m" }
					else { cor="\033[m" }
				}
				if ($0 ~ /Grupo/) {print "";print $1, $2 ;getline;getline;getline;}
				else if ($0 !~ /Rodada/) { printf "%s%s\033[m\n", cor, $0 }
			}}
			/^ *Quartas de Final/,/^ *\*/ {
				if ($NF ~ /[Ff]inal$/) { sub(/^ */,""); print ""; printf $0 }
				if (/Confronto/) { sub(/^.*C/,"C"); print ""; print }
				if ($0 ~ / X /) {
					if ($1 ~ /pênaltis/ && separador=="   X   ")
						{ separador=$1; sub(/pênaltis/,")X(",separador);  separador="(" separador ")"; $1="" }
					else { separador="   X   " }
					sub(/^ */,""); sub(/^[A-Z]{3}/,""); sub(/[A-Z]{3}$/,"")
					split($0, times, " X ")
					getline; if (/pós jogo/) {getline}; sub(/^ */,""); data = $0
					printf "%20s %s %-20s  %s\n", times[1], separador, times[2], data
				}
			}'
			if test "$ZZCOR" = "1"
			then
				printf "\n\033[42;30m Quartas de Final \033[m"
				test "$serie" = "c" && printf "\033[41;30m Rebaixamento \033[m\n"
			fi
		else

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

				if (NR >= 2 && NR <=5)
					cor="\033[42;30m"
			}

			gsub(/ +/," ",time)
			sub (/^ [0-9] /, " &", time)
			if (NF>9)
			printf "%s%-23s %3s %3s %3s %3s %3s %3s %3s %3s %4s \033[m\n", cor, time, $(NF-8), $(NF-7), $(NF-6), $(NF-5), $(NF-4), $(NF-3), $(NF-2), $(NF-1), $NF}'

			if test "$ZZCOR" = "1"
			then
				echo
				if test "$serie" = "a"
				then
					printf "\033[42;30m Libertadores \033[m"
					printf "\033[46;30m Sul-Americana \033[m"
				elif test "$serie" = "b"
				then
					printf "\033[42;30m   Série  A   \033[m"
				fi
				printf "\033[41;30m Rebaixamento \033[m\n"
			fi
		fi
	fi
}

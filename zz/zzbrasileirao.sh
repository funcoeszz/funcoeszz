# ----------------------------------------------------------------------------
# https://www.ogol.com.br
# Mostra a tabela atualizada do Campeonato Brasileiro - Série A, B ou C.
#
# Nomenclatura:
#   P   - Pontos Ganhos
#   J   - Jogos
#   V   - Vitórias
#   E   - Empates
#   D   - Derrotas
#   GP  - Gols Pró
#   GC  - Gols Contra
#   SG  - Saldo de Gols
#
# Uso: zzbrasileirao [a|b|c]
# Ex.: zzbrasileirao
#      zzbrasileirao a
#      zzbrasileirao b
#      zzbrasileirao c
#
# Autor: Alexandre Brodt Fernandes, www.xalexandre.com.br
# Desde: 2011-05-28
# Versão: 27
# Requisitos: zzzz zztool zzecho zzjuntalinhas zzpad zzxml
# Tags: internet, futebol, consulta
# ----------------------------------------------------------------------------
zzbrasileirao ()
{
	zzzz -h brasileirao "$1" && return

	local serie pos time resto cor
	local cache=$(zztool cache brasileirao)
	local url='https://www.ogol.com.br/'
	local tab="$(printf '\t')"

	test $# -gt 2 && { zztool -e uso brasileirao; return 1; }

	# Lista dos links para as séries
	if ! test -e "$cache" || test $(head -n 1 "$cache") -lt $(date +%Y%m)
	then
		date +%Y%m > "$cache"
		zztool source "$url" |
		zztool texto_em_iso |
		zzxml --tidy |
		awk '
			/<div class="zz-menulinks-sub">/ { exit }
			/<div class="zz-menulinks-main">/,/<div class="zz-menulinks-sub">/ {
				if ($0 ~ /href=/) {
					printf $0 "\t"
					getline
					getline
					print
				}
			}' |
		sed 's/">//;s/.*"//;s/Brasileirão/Série A/;3q' >> "$cache"
	fi

	serie='a'
	if test -n "$1"
	then
		case $1 in
			[aA] | [bB] | [cC]) serie="$1"; shift ;;
			*) zztool -e uso brasileirao; return 1 ;;
		esac
	fi

	serie=$(echo $serie | tr 'abc' 'ABC')

	url=${url}$(grep "${serie}$" "$cache" | cut -f 1)

	zztool eco "Série $serie"
	zztool source "$url" |
	zztool texto_em_iso |
	zzxml --tidy |
	if test 'C' = "$serie"
	then
		sed -n '/^Final *$/,/table>/p;/^Grupo /,/table>/p;/ Fase/p;'
	else
		sed -n '/Classifica/,/table>/p'
	fi |
	zzjuntalinhas -i '<tr' -f 'tr>' -d '|' |
	zzxml --untag |
	if test 'C' = "$serie"
	then
		awk 'NR>3 && / Fase/{print ""};NR>2'
	else
		cat -
	fi |
	tr -s '|' |
	if test 'C' = "$serie"
	then
		sed 's/|J|/|#|Time|J|/;s/$/|/'
	else
		sed 's/|P|/|#|Time|P|/'
	fi |
	sed 's/^|//;s/| *$//;s/a$/ /' |
	awk 'NR==1 && /Final/ {next};1' |
	while IFS='|' read -r pos time resto
	do
		unset cor
		zztool grep_var 'Grupo' "$pos" && echo '--------------------------------'
		test '1ª Fase' = "$pos" && serie='c'
		if test  1 -eq "$ZZCOR" && zztool testa_numero $pos
		then
			# Verde
			case "$serie" in
				A) test "$pos" -le 6 && cor='verde' ;;
				B) test "$pos" -le 4 && cor='verde' ;;
				c) test "$pos" -le 4 && cor='verde' ;;
			esac
			# Ciano
			test "A" = "$serie" && test "$pos" -gt 6 && test "$pos" -lt 13 && cor='ciano'
			# Vermelho
			case "$serie" in
				A|B) test "$pos" -ge 17 && cor='vermelho' ;;
				c)   test "$pos" -ge 9  && cor='vermelho' ;;
			esac
		fi
		if test -n "$time"
		then
			case "$cor" in
				verde|ciano|vermelho) zzecho -f $cor -l preto "$(zzpad 3 $pos) $(zzpad 20 $time) $(echo "$resto" | sed "s/|/${tab}/g" | expand -t 5)";;
				*)
					if zztool testa_numero "$pos" || test "#" == "$pos"
					then
						echo "$(zzpad 3 $pos) $(zzpad 20 $time) $(echo "$resto" | sed "s/|/${tab}/g" | expand -t 5)"
					else
						echo "${pos}|${time}|${resto}" | sed 's/|F|G|/|/g;s/Ida|Volta|/|||&/;s/&nbsp;/ /g' | awk -F '|' '{ printf "%25s %-5s %-25s %-12s %-12s\n", $1, $2, $3, $4, $5 }'
					fi
				;;
			esac
		else
			zztool grep_var ' Fase' "$pos" && zzecho -l amarelo "$pos" && continue
			zztool grep_var 'Final' "$pos" && zzecho -l amarelo "$pos" && continue
			echo "$pos"
		fi
	done

	if test $ZZCOR -eq 1
	then
		echo
		if test "$serie" = "A"
		then
			zzecho -f verde -l preto  " Libertadores  "
			zzecho -f ciano -l preto  " Sul-Americana "
			zzecho -f vermelho -l preto   " Rebaixamento  "
		elif test "$serie" = "B"
		then
			zzecho -f verde -l preto  "   Série  A    "
			zzecho -f vermelho -l preto   " Rebaixamento  "
		elif test "$serie" = "C"
		then
			zzecho -f verde -l preto " Quartas de Final "
			zzecho -f vermelho -l preto "   Rebaixamento   "
		fi
	fi
}

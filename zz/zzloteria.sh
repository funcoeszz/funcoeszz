# ----------------------------------------------------------------------------
# Resultados da quina megasena duplasena lotomania lotofacil federal timemania loteca lotogol sorte sete.
#
# Se o 2º argumento for um número, pesquisa o resultado filtrando o concurso.
# Se o 2º argumento for a palavra "quantidade" ou "qtde" mostra quantas vezes
#  um número foi sorteado. Nem todas as loterias suportam essa funcionalidade.
# Se nenhum argumento for passado, todas as loterias são mostradas.
#
# Uso: zzloteria [[loterias suportadas] [concurso|[quantidade|qtde]]
# Ex.: zzloteria
#      zzloteria quina megasena
#      zzloteria loteca 550
#      zzloteria quina qtde
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2004-05-18
# Versão: 19
# Requisitos: zzzz zztool zzdatafmt zzjuntalinhas zzhoramin zzsemacento zzsqueeze zzunescape zzxml
# Tags: internet, jogo, consulta
# Nota: requer unzip
# ----------------------------------------------------------------------------
zzloteria ()
{
	zzzz -h loteria "$1" && return

	local tipo num_con qtde codscript
	local url='https://www.sorteonline.com.br/todas/resultados'
	local todas='quina megasena duplasena lotomania lotofacil federal timemania loteca lotogol sorte sete'
	local tipos="$todas"
	local cache=$(zztool cache loteria)
	local tab=$(printf '\t')
	local un_zip='unzip -q -a -C -o'
	local tmp_dir="${ZZTMP%/*}"

	# Caso o segundo argumento seja um numero, filtra pelo concurso equivalente
	if zztool testa_numero "$2"
	then
		tipos=$1
		num_con=$2
	elif test 'quantidade' = "$2" -o 'qtde' = "$2"
	then
		tipos=$1
		num_con=0
	elif test '--atualiza' = "$1"
	then
		echo "$(zzdatafmt --iso hoje) $(zzhoramin)" > "$cache"
		zztool source "$url" >> "$cache"
		return
	else
		unset num_con
		test -n "$1" && tipos="$*"
	fi

	zzloteria_faxina() {
		# Remove todas as subfunções pra não poluir a shell do usuário
		unset zzloteria_atualiza_cache_historico
		unset zzloteria_resultado_historico
		unset zzloteria_resultado_mais_recente
		unset zzloteria_faxina
	}

	zzloteria_atualiza_cache_historico() {
		local datafile
		local url_historico
		local filtro="^ *$num_con "

		# A federal pode iniciar com zero no numero do concurso
		test 'federal' = "$tipo" && filtro="^[ 0]*$num_con "

		case $tipo in
			lotomania)
				datafile="d_lotman.htm"
				url_historico="http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_lotoma.zip"
			;;
			lotofacil)
				datafile="d_lotfac.htm"
				url_historico="http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_lotfac.zip"
			;;
			megasena)
				datafile="d_megasc.htm"
				url_historico="http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_mgsasc.zip"
			;;
			duplasena)
				datafile="d_dplsen.htm"
				url_historico="http://www1.caixa.gov.br/loterias/_arquivos/loterias/d_dplsen.zip"
			;;
			quina)
				datafile="d_quina.htm"
				url_historico="http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_quina.zip"
			;;
			federal)
				datafile="d_lotfed.htm"
				url_historico="http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_federa.zip"
			;;
			timemania)
				datafile="d_timasc.htm"
				url_historico="http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_timasc.zip"
			;;
			loteca)
				datafile="d_loteca.htm"
				url_historico="http://www1.caixa.gov.br/loterias/_arquivos/loterias/d_loteca.zip"
			;;
		esac

		# Se o arquivo de cache não existir, crie-o
		# Se o arquivo existir, porém não tiver o concurso desejado, atualize-o
		if ! test -e "${cache}.${tipo}.htm" ||
			! zztool dump "${cache}.${tipo}.htm" | grep "$filtro" >/dev/null
		then
			wget -q -O "${cache}.${tipo}.zip" "$url_historico"
			$un_zip "${cache}.${tipo}.zip" "*.htm" -d "$tmp_dir" 2>/dev/null
			mv -f "${tmp_dir}/${datafile}" ${cache}.${tipo}.htm
			rm -f ${cache}.${tipo}.zip

			# A loteca tem esse tratamento adicional, mas não sei o porquê
			if test 'loteca' = "$tipo"
			then
				zzdatafmt --iso hoje >> ${cache}.${tipo}.htm
			fi
		fi
	}

	zzloteria_resultado_mais_recente() {
		if ! test -e "$cache" ||
			test $(sed -n '1{s/ .*//;p;}' "$cache") != $(zzdatafmt --iso hoje) ||
			test $(sed -n '1{s/.* //;p;}' "$cache") -lt 1200 -a $(zzhoramin) -gt 1200
		then
			zzloteria --atualiza
		fi

		case "$tipo" in
			quina)     codscript='Quina'; qtde=5;;
			megasena)  codscript='Mega'; qtde=6;;
			duplasena) codscript='Dupla'; qtde=6;;
			lotomania) codscript='Lotomania'; qtde=5;;
			lotofacil) codscript='Lotof'; qtde=5;;
			timemania) codscript='Timemania'; qtde=7;;
			federal)   codscript='Loteria'; qtde=5;;
			loteca)    codscript='Loteca'; qtde=5;;
			lotogol)   codscript='Lotogol'; qtde=5;;
			sorte)     codscript='Dia'; qtde=7;;
			sete)      codscript='Super'; qtde=7;;
		esac

		sed -n '/<h2 class="name color">'${codscript}'/,/APOSTE AGORA/ {
			/SORTEIO */{s///;p;}
			/CONCURSO */{s///;p;}
			/nome-sorteio/p
			/<div class="nome-sorteio color">/{ n;p; }
			/time-coracao/{ s/<[^>]*>//; s/ */		/; p; }
			/<li/p
			/<table class="result /,/table>/p
			/Ganhadores/,/footer/p
			/[Aa]cumulado/,/R\$/{ s/R\$/ & /;p; }
			/Arrecada/,/R\$/{ s/R\$/ & /;p; }
		}' "$cache" |
		if test "$codscript" = 'Super'
		then
			awk 'NR<15 && /<li /{ sub(/<li /,"<li l=\042" NR "\042") };1'
		else
			cat -
		fi |
		uniq |
		awk 'NR==1{sorteio=$0;next};NR==2{printf "Concurso " $0; print " ("sorteio")"};/<a /{next};/<li /{printf "\t" $0 (++i%'$qtde'==0?"\n":"");next};NR>2' |
		zzjuntalinhas -i ' class="tr"' -f 'div>' |
		zzjuntalinhas -i '<tr' -f 'tr>' |
		zzxml --untag |
		sed '
			s/Faixa.*mio//
			/Ver Rateio/d
			/Arrecada.*total/{
				n
				q
			}
			s/	 \{1,\}/	/
			s/	\{1,\}/	/g
			s/	X	/ X /
			s/ACUMULOU.*//' |
		awk '/[Aa]cumulado|Arrecada/{print ""};1' |
		case "$tipo" in
			duplasena)
				awk 'NR > 7 && NR < 16 && NF==0 {next};/Sorteio$/{printf "\n" $0 "\n";next};/Sena/ && NR>10{printf "\n"};1'
			;;
			federal)
				awk 'NR > 2 && NR < 12 && NR %2 == 1 {milhar[(NR-1)/2]=$0};NR==1; NR > 12 && NR < 18 {print $1 "\t" milhar[++i] "\t" $3 "\t" $4 }'
			;;
			loteca)
				awk -F '\t' 'NR > 1 && NR < 16 {sub(/^ */,"");printf "%s %22s  %s  %s\n", $1, $2, $3, $4;next};1'
			;;
			*)
				cat -
			;;
		esac |
		zzunescape --html |
		zzsqueeze -l
	}

	zzloteria_quantidade() {
		zzloteria_atualiza_cache_historico || return 1

		zztool dump "${cache}.${tipo}.htm" |
		case "$tipo" in

			federal | loteca)
				zztool erro "Não se aplica a loteria $tipo."
				return 1
			;;

			lotomania)
				awk '
				BEGIN { printf "## QTD\t## QTD\t## QTD\t## QTD\n" }
				$2 ~ /[0-9]\/[0-9][0-9]\/[0-9]/ { for (i=3;i<23;i++) numeros[$i]++ }
				END {
					for (i=0;i<25;i++) {
						num=sprintf("%02d",i)
						printf "%02d %d\t%02d %d\t%02d %d\t%02d %d\n", i, numeros[num], i+25, numeros[i+25], i+50, numeros[i+50], i+75, numeros[i+75]
					}
				}
				' |
				expand -t 10
			;;

			lotofacil)
				awk '
				BEGIN { print "## QTD" }
				$2 ~ /[0-9]\/[0-9][0-9]\/[0-9]/ { for (i=3;i<18;i++) numeros[$i]++ }
				END {
					for (i=1;i<=25;i++) {
						num=sprintf("%02d",i)
						printf "%02d %d\n", i, numeros[num]
					}
				}
				' |
				expand -t 10
			;;

			megasena)
				awk '
				BEGIN { printf "## QTD\t## QTD\t## QTD\n" }
				$2 ~ /[0-9]\/[0-9][0-9]\/[0-9]/ { for (i=3;i<9;i++) numeros[$i]++ }
				END {
					for (i=1;i<=20;i++) {
						num=sprintf("%02d",i)
						printf "%02d %d\t%02d %d\t%02d %d\n", i, numeros[num], i+20, numeros[i+20], i+40, numeros[i+40]
					}
				}
				' |
				expand -t 10
			;;

			duplasena)
				awk '
				BEGIN {
					printf "1º sorteio          2º sorteio\n"
					printf "## QTD\t## QTD\t## QTD\t## QTD\n"
					}
				$2 ~ /[0-9]\/[0-9][0-9]\/[0-9]/ {
					for (i=3;i<9;i++)  numeros1[$i]++
					for (i=15;i>9;i--) numeros2[$(NF-i) ]++
				}
				END {
					for (i=1;i<=25;i++) {
						num=sprintf("%02d",i)
						printf "%02d %d\t%02d %d\t%02d %d\t%02d %d\n", i, numeros1[num], i+25, numeros1[i+25], i, numeros2[num], i+25, numeros2[i+25]
					}
				}
				' |
				expand -t 10
			;;

			quina)
				awk '
				BEGIN { printf "## QTD\t## QTD\t## QTD\t## QTD\n" }
				$2 ~ /[0-9]\/[0-9][0-9]\/[0-9]/ { for (i=3;i<8;i++) numeros[$i]++ }
				END {
					for (i=1;i<=20;i++) {
						num=sprintf("%02d",i)
						printf "%02d %d\t%02d %d\t%02d %d\t%02d %d\n", i, numeros[num], i+20, numeros[i+20], i+40, numeros[i+40], i+60, numeros[i+60]
					}
				}
				' |
				expand -t 10
			;;

			timemania)
				awk '
				BEGIN { printf "## QTD\t## QTD\t## QTD\t## QTD\n" }
				$2 ~ /[0-9]\/[0-9][0-9]\/[0-9]/ { for (i=3;i<10;i++) numeros[$i]++ }
				END {
					for (i=1;i<=20;i++) {
						num=sprintf("%02d",i)
						printf "%02d %d\t%02d %d\t%02d %d\t%02d %d\n", i, numeros[num], i+20, numeros[i+20], i+40, numeros[i+40], i+60, numeros[i+60]
					}
				}
				' |
				expand -t 10
			;;
		esac
	}

	zzloteria_resultado_historico() {
		zzloteria_atualiza_cache_historico || return 1

		zztool dump "${cache}.${tipo}.htm" |
		case "$tipo" in

			lotomania)
				grep "^ *$num_con " 2>/dev/null |
				tr -d '[A-Z]' |
				awk '{
					print "Concurso", $1, "(" $2 ")"
					comando="sort -n | paste -d _ - - - - -"
					for (i=3;i<23;i++) {print $i | comando }
					close(comando)
					i=(NF==42?1:0)
					print ""
					printf "20 pts.\t%s\t%s\n", ($24==0?"Nao houve acertador!":$24), ($24==0?"":"R$ " $(NF-13+i))
					printf "19 pts.\t%s\t%s\n", $(NF-18+i), "R$ " $(NF-12+i)
					printf "18 pts.\t%s\t%s\n", $(NF-17+i), "R$ " $(NF-11+i)
					printf "17 pts.\t%s\t%s\n", $(NF-16+i), "R$ " $(NF-10+i)
					printf "16 pts.\t%s\t%s\n", $(NF-15+i), "R$ " $(NF-9+i)
					printf " 0 pts.\t%s\t%s\n", ($(NF-14+i)==0?"Nao houve acertador!":$(NF-14+i)), ($(NF-14+i)==0?"":"R$ " $(NF-8+i))
				}' |
				sed '/^[0-9 ]/s/^/   /;s/_/     /g' |
				expand -t 5,15,25
			;;

			lotofacil)
				grep "^ *$num_con " 2>/dev/null |
				awk '{
					print "Concurso", $1, "(" $2 ")"
					comando="sort -n | paste -d _ - - - - -"
					for (i=3;i<18;i++) {print $i | comando }
					close(comando)
					print ""
					printf "15 pts.\t%s\t%s\n", ($19==0?"Nao houve acertador!":$19), ($19==0?"":"R$ " $(NF-7))
					printf "14 pts.\t%s\t%s\n", $(NF-11), "R$ " $(NF-6)
					printf "13 pts.\t%s\t%s\n", $(NF-10), "R$ " $(NF-5)
					printf "12 pts.\t%s\t%s\n", $(NF-9), "R$ " $(NF-4)
					printf "11 pts.\t%s\t%s\n", $(NF-8), "R$ " $(NF-3)
				}' |
				sed '/^[0-9 ]/s/^/   /;s/_/     /g' |
				expand -t 5,15,25
			;;

			megasena)
				grep "^ *$num_con " 2>/dev/null |
				awk '{
					print "Concurso", $1, "(" $2 ")"
					printf "%4s %4s %4s %4s %4s %4s\n", $3, $4, $5, $6, $7, $8
					print ""
					printf "   Sena  \t%s\t%s\n", ($10==0?"Nao houve acertador!":$10), ($10==0?"":"R$ " $(NF-8))
					printf "   Quina \t%s\t%s\n", $(NF-7), "R$ " $(NF-6)
					printf "   Quadra\t%s\t%s\n", $(NF-5), "R$ " $(NF-4)
				}' |
				expand -t 15,25,35
			;;

			duplasena)
				grep "^ *$num_con " 2>/dev/null |
				awk '{
					print "Concurso", $1, "(" $2 ")"
					printf "\n  1º sorteio\n"
					comando="sort -n | paste -d _ - - - - - -"
					for (i=3;i<9;i++) {print $i | comando }
					close(comando)
					printf "\n  2º sorteio\n"
					for (i=15;i>9;i--) {print $(NF-i) | comando }
					close(comando)
					printf "\n  1º Sorteio\n"
					printf "   Sena  \t%s\t%s\n", ($10==0?"Nao houve acertador":$10), ($10==0?"":"R$ " $(NF-22))
					printf "   Quina \t%s\t%s\n", $(NF-21), "R$ " $(NF-20)
					printf "   Quadra\t%s\t%s\n", $(NF-19), "R$ " $(NF-19)
					printf "\n  2º Sorteio\n"
					printf "   Sena  \t%s\t%s\n", ($(NF-9)==0?"Nao houve acertador":$(NF-9)), ($(NF-9)==0?"":"R$ " $(NF-8))
					printf "   Quina \t%s\t%s\n", $(NF-7), "R$ " $(NF-6)
					printf "   Quadra\t%s\t%s\n", $(NF-5), "R$ " $(NF-4)
				}' |
				sed '/^[0-9][0-9]/s/^/   /;s/_/   /g'
			;;

			quina)
				grep "^ *$num_con " 2>/dev/null |
				awk '{
					print "Concurso", $1, "(" $2 ")"
					comando="sort -n | paste -d _ - - - - -"
					for (i=3;i<8;i++) {print $i | comando }
					close(comando)
					print ""
					printf "   Quina \t%s\t%s\n", ($9==0?"Nao houve acertador":$9), ($9==0?"":"R$ " $(NF-10))
					printf "   Quadra\t%s\t%s\n", $(NF-9), "R$ " $(NF-8)
					printf "   Terno \t%s\t%s\n", $(NF-7), "R$ " $(NF-6)
				}' |
				sed '/^[0-9][0-9]/s/^/   /;s/_/   /g' |
				expand -t 15,25,35
			;;

			federal)
				# A federal pode iniciar com zero no numero do concurso
				grep "^[ 0]*$num_con " 2>/dev/null |
				awk '{
					print "Concurso", $1, "(" $2 ")"
					print ""
					printf "   1º Premio     %s   %s\n", $3, "R$ " $8
					printf "   2º Premio     %s   %s\n", $4, "R$ " $9
					printf "   3º Premio     %s   %s\n", $5, "R$ " $10
					printf "   4º Premio     %s   %s\n", $6, "R$ " $11
					printf "   5º Premio     %s   %s\n", $7, "R$ " $12
				}'
			;;

			timemania)
				grep "^ *$num_con " 2>/dev/null |
				sed 's/\([[:upper:]]\) \([[:upper:]]\)/\1_\2/g' |
				awk '{
					print "Concurso", $1, "(" $2 ")"
					printf "%5s %4s %4s %4s %4s %4s %4s\n", $3, $4, $5, $6, $7, $8, $9
					print ""
					printf "   7 pts.\t%s\t%s\n", ($12==0?"Nao houve acertador!":$12), ($12==0?"":"R$ " $(NF-7))
					printf "   6 pts.\t%s\t%s\n", $(NF-12), "R$ " $(NF-6)
					printf "   5 pts.\t%s\t%s\n", $(NF-11), "R$ " $(NF-5)
					printf "   4 pts.\t%s\t%s\n", $(NF-10), "R$ " $(NF-4)
					printf "   3 pts.\t%s\t%s\n", $(NF-9), "R$ " $(NF-3)
					printf "\n   Time: %s\t\n\t%s\t%s\n", $10, $(NF-8),  "R$ " $(NF-2)
				}' |
				expand -t 15,25,35
			;;

			loteca)
				grep "^ *$num_con " 2>/dev/null |
				awk '{
					print "Concurso", $1, "(" $2 ")"
					print " Jogo   Resultado"
					printf "  1    %8s\n", "Col. " ($(NF-15)=="x"?"Meio":$(NF-15))
					printf "  2    %8s\n", "Col. " ($(NF-14)=="x"?"Meio":$(NF-14))
					printf "  3    %8s\n", "Col. " ($(NF-13)=="x"?"Meio":$(NF-13))
					printf "  4    %8s\n", "Col. " ($(NF-12)=="x"?"Meio":$(NF-12))
					printf "  5    %8s\n", "Col. " ($(NF-11)=="x"?"Meio":$(NF-11))
					printf "  6    %8s\n", "Col. " ($(NF-10)=="x"?"Meio":$(NF-10))
					printf "  7    %8s\n", "Col. " ($(NF-9)=="x"?"Meio":$(NF-9))
					printf "  8    %8s\n", "Col. " ($(NF-8)=="x"?"Meio":$(NF-8))
					printf "  9    %8s\n", "Col. " ($(NF-7)=="x"?"Meio":$(NF-7))
					printf " 10    %8s\n", "Col. " ($(NF-6)=="x"?"Meio":$(NF-6))
					printf " 11    %8s\n", "Col. " ($(NF-5)=="x"?"Meio":$(NF-5))
					printf " 12    %8s\n", "Col. " ($(NF-4)=="x"?"Meio":$(NF-4))
					printf " 13    %8s\n", "Col. " ($(NF-3)=="x"?"Meio":$(NF-3))
					printf " 14    %8s\n", "Col. " ($(NF-2)=="x"?"Meio":$(NF-2))
					print ""
					printf "  14 pts.\t%s\t%s\n", ($3==0?"Nao houve acertador":$3), ($3==0?"":"R$ " $(NF-21))
					printf "  13 pts.\t%s\t%s\n", $(NF-18), "R$ " $(NF-17)
				}'
			;;
		esac
	}

	# Para cada tipo de loteria...
	for tipo in $tipos
	do
		tipo=$(echo "$tipo" | zzsemacento)  # lotofácil -> lotofacil

		zztool grep_var "$tipo" "$tipos" || {
			zztool erro "Loteria desconhecida: $tipo"
			zzloteria_faxina
			return 1
		}

		zztool eco "${tipo}:"

		case "$num_con" in
			"") zzloteria_resultado_mais_recente;;
			0) zzloteria_quantidade;;
			*) zzloteria_resultado_historico;;
		esac || {
			zzloteria_faxina
			return 1
		}

		# Linha em branco para separar os resultados de cada loteria
		echo
	done
	zzloteria_faxina
}

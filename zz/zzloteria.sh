# ----------------------------------------------------------------------------
# Resultados da quina megasena duplasena lotomania lotofacil federal timemania loteca lotogol sorte sete.
#
# Se o 2º argumento for um número, pesquisa o resultado filtrando o concurso.
# Se o 2º argumento for a palavra "quantidade" ou "qtde" mostra quantas vezes
#  um número foi sorteado.
# ( Não se aplica para federal, loteca, lotogol, sorte, sete)
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
# Versão: 18
# Requisitos: zzzz zztool zzdatafmt zzjuntalinhas zzhoramin zzsqueeze zzunescape zzxml
# Tags: internet, jogo, consulta
# Nota: requer unzip
# ----------------------------------------------------------------------------
zzloteria ()
{
	zzzz -h loteria "$1" && return

	local tipo num_con qtde codscript
	local url='https://www.sorteonline.com.br/todas/resultados'
	local tipos='quina megasena duplasena lotomania lotofacil federal timemania loteca lotogol sorte sete'
	local cache=$(zztool cache loteria)
	local tab=$(printf '\t')
	local un_zip='unzip -q -a -C -o'
	local tmp_dir="${ZZTMP%/*}"


	# Essa URL feiosa está no final da página
	# http://www.loterias.caixa.gov.br/wps/portal/loterias/landing/megasena
	local url_historico_megasena='http://www.loterias.caixa.gov.br/wps/portal/loterias/landing/megasena/!ut/p/a1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLNDH0MPAzcDbwMPI0sDBxNXAOMwrzCjA0sjIEKIoEKnN0dPUzMfQwMDEwsjAw8XZw8XMwtfQ0MPM2I02-AAzgaENIfrh-FqsQ9wNnUwNHfxcnSwBgIDUyhCvA5EawAjxsKckMjDDI9FQE-F4ca/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_HGK818G0K8DBC0QPVN93KQ10G1/res/id=historicoHTML/c=cacheLevelPage/=/'

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

	# Para cada tipo de loteria...
	for tipo in $tipos
	do

		# Para o caso de ser fornecido "lotofácil"
		tipo=$(echo "$tipo" | sed 's/á/a/')

		zztool eco "${tipo}:"
		if ! test -n "$num_con"
		then
			if ! test -e "$cache" || test $(sed -n '1{s/ .*//;p;}' "$cache") != $(zzdatafmt --iso hoje) || test $(sed -n '1{s/.* //;p;}' "$cache") -lt 1200 -a $(zzhoramin) -gt 1200
			then
				zzloteria --atualiza
			fi

			# Resultados mais recentes das loterias selecionadas.
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
				*) zztool erro "Loteria escolhida inválida\n"; continue ;;
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
			sed 's/Faixa.*mio//;/Ver Rateio/d;/Arrecada.*total/{n;q;};s/	 \{1,\}/	/;s/	\{1,\}/	/g;s/	X	/ X /;s/ACUMULOU.*//' |
			awk '/[Aa]cumulado|Arrecada/{print ""};1' |
			case "$tipo" in
				duplasena) awk 'NR > 7 && NR < 16 && NF==0 {next};/Sorteio$/{printf "\n" $0 "\n";next};/Sena/ && NR>10{printf "\n"};1' ;;
				federal)   awk 'NR > 2 && NR < 12 && NR %2 == 1 {milhar[(NR-1)/2]=$0};NR==1; NR > 12 && NR < 18 {print $1 "\t" milhar[++i] "\t" $3 "\t" $4 }' ;;
				loteca)    awk -F '\t' 'NR > 1 && NR < 16 {sub(/^ */,"");printf "%s %22s  %s  %s\n", $1, $2, $3, $4;next};1' ;;
				*) cat -;;
			esac |
			zzunescape --html |
			zzsqueeze -l
			echo
		else
			# Resultados históricos das loterias selecionadas.
			case "$tipo" in
				lotomania)
					if ! test -e ${cache}.lotomania.htm || ! $(zztool dump ${cache}.lotomania.htm | grep "^ *$num_con " >/dev/null)
					then
						wget -q -O "${cache}.lotomania.zip" "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_lotoma.zip"
						$un_zip "${cache}.lotomania.zip" "*.htm" -d "$tmp_dir" 2>/dev/null
						mv -f "${tmp_dir}/d_lotman.htm" ${cache}.lotomania.htm
						rm -f ${cache}.lotomania.zip
					fi
					zztool dump ${cache}.lotomania.htm |
					if test 0 = "$num_con"
					then
						awk '
						BEGIN { printf "## QTD\t## QTD\t## QTD\t## QTD\n" }
						$2 ~ /[0-9]\/[0-9][0-9]\/[0-9]/ { for (i=3;i<23;i++) numeros[$i]++ }
						END {
							for (i=0;i<25;i++) {
								num=sprintf("%02d",i)
								printf "%02d %d\t%02d %d\t%02d %d\t%02d %d\n", i, numeros[num], i+25, numeros[i+25], i+50, numeros[i+50], i+75, numeros[i+75]
							}
						}
						' | expand -t 10
					else
						grep "^ *$num_con " 2>/dev/null |
						tr -d '[A-Z]' |
						awk ' {
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
						}' | sed '/^[0-9 ]/s/^/   /;s/_/     /g' | expand -t 5,15,25
					fi
				;;
				lotofacil)
					if ! test -e ${cache}.lotofacil.htm || ! $(zztool dump ${cache}.lotofacil.htm | grep "^ *$num_con " >/dev/null)
					then
						wget -q -O "${cache}.lotofacil.zip" "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_lotfac.zip"
						$un_zip "${cache}.lotofacil.zip" "*.htm" -d "$tmp_dir" 2>/dev/null
						mv -f "${tmp_dir}/d_lotfac.htm" ${cache}.lotofacil.htm
						rm -f ${cache}.lotofacil.zip
					fi
					zztool dump ${cache}.lotofacil.htm |
					if test 0 = "$num_con"
					then
						awk '
						BEGIN { print "## QTD" }
						$2 ~ /[0-9]\/[0-9][0-9]\/[0-9]/ { for (i=3;i<18;i++) numeros[$i]++ }
						END {
							for (i=1;i<=25;i++) {
								num=sprintf("%02d",i)
								printf "%02d %d\n", i, numeros[num]
							}
						}
						' | expand -t 10
					else
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
						}' | sed '/^[0-9 ]/s/^/   /;s/_/     /g' | expand -t 5,15,25
					fi
				;;

				megasena)
					# Cria ou atualiza o cache, caso necessário
					if ! test -e "${cache}.megasena.htm" ||
						! $(zztool dump "${cache}.megasena.htm" | grep "^ *$num_con " >/dev/null)
					then
						wget -q -O "${cache}.megasena.htm" "$url_historico_megasena"
					fi

					# Trata o argumento 'quantidade'
					if test 0 = "$num_con"
					then
						zztool dump "${cache}.megasena.htm" |
						awk '
						BEGIN { printf "## QTD\t## QTD\t## QTD\n" }
						$2 ~ /[0-9]\/[0-9][0-9]\/[0-9]/ { for (i=3;i<9;i++) numeros[$i]++ }
						END {
							for (i=1;i<=20;i++) {
								num=sprintf("%02d",i)
								printf "%02d %d\t%02d %d\t%02d %d\n", i, numeros[num], i+20, numeros[i+20], i+40, numeros[i+40]
							}
						}
						' | expand -t 10

					# Trata argumento numérico (pesquisa resultado histórico)
					else
						zztool dump "${cache}.megasena.htm" |
						grep "^ *$num_con " 2>/dev/null |
						# Exemplos saída do grep anterior:
						#
						# Com cidade (num_con=1111):
						#    1111 MESQUITA, RJ 23/09/2009 004 009 025 032 033 043 1 52 5266 2.100.928,15 21.932,77 309,39
						# Sem cidade (num_con=100):
						#    100 01/02/1998 014 029 030 046 048 051 0 56 3600 0,00 15.930,48 247,32
						#
						# A cidade não aparece no resultado, podemos removê-la.
						# Para fazer isso de uma maneira mais simples, o próximo
						# grep só pega os dados a partir do terceiro campo
						# (data) e o sed logo em seguida recoloca o número do
						# concurso no início da linha.
						grep -E -o '[0-9]{2}/[0-9]{2}/[0-9]{4} .*' |
						sed "s/^/$num_con /" |

						# Neste ponto, a linha com os dados está assim:
						# 100 01/02/1998 014 029 030 046 048 051 0 56 3600 0,00 15.930,48 247,32
						awk '{
							print "Concurso", $1, "(" $2 ")"
							printf "%4s %4s %4s %4s %4s %4s\n", $3, $4, $5, $6, $7, $8
							print ""
							printf "   Sena  \t%s\t%s\n", $9, "R$ " $12
							printf "   Quina \t%s\t%s\n", $10, "R$ " $13
							printf "   Quadra\t%s\t%s\n", $11, "R$ " $14
						}' | expand -t 15,25,35 |
						# Dezenas vêm com 3 dígitos, muda pra 2. Exemplo: 012 -> 12
						sed '2s/ 0/  /g'
					fi
				;;

				duplasena)
					if ! test -e ${cache}.duplasena.htm || ! $(zztool dump ${cache}.duplasena.htm | grep "^ *$num_con " >/dev/null)
					then
						wget -q -O "${cache}.duplasena.zip" "http://www1.caixa.gov.br/loterias/_arquivos/loterias/d_dplsen.zip"
						$un_zip "${cache}.duplasena.zip" "*.htm" -d "$tmp_dir" 2>/dev/null
						mv -f "${tmp_dir}/d_dplsen.htm" ${cache}.duplasena.htm
						rm -f ${cache}.duplasena.zip
					fi
					zztool dump ${cache}.duplasena.htm |
					if test 0 = "$num_con"
					then
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
						' | expand -t 10
					else
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
						}' | sed '/^[0-9][0-9]/s/^/   /;s/_/   /g'
					fi
				;;
				quina)
					if ! test -e ${cache}.quina.htm || ! $(zztool dump ${cache}.quina.htm | grep "^ *$num_con " >/dev/null)
					then
						wget -q -O "${cache}.quina.zip" "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_quina.zip"
						$un_zip "${cache}.quina.zip" "*.htm" -d "$tmp_dir" 2>/dev/null
						mv -f "${tmp_dir}/d_quina.htm" ${cache}.quina.htm
						rm -f ${cache}.quina.zip
					fi
					zztool dump ${cache}.quina.htm |
					if test 0 = "$num_con"
					then
						awk '
						BEGIN { printf "## QTD\t## QTD\t## QTD\t## QTD\n" }
						$2 ~ /[0-9]\/[0-9][0-9]\/[0-9]/ { for (i=3;i<8;i++) numeros[$i]++ }
						END {
							for (i=1;i<=20;i++) {
								num=sprintf("%02d",i)
								printf "%02d %d\t%02d %d\t%02d %d\t%02d %d\n", i, numeros[num], i+20, numeros[i+20], i+40, numeros[i+40], i+60, numeros[i+60]
							}
						}
						' | expand -t 10
					else
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
						}' | sed '/^[0-9][0-9]/s/^/   /;s/_/   /g' | expand -t 15,25,35
					fi
				;;
				federal)
					if test 0 = "$num_con"
					then
						zztool erro "Não se aplica a loteria federal."
						return 1
					fi

					if ! test -e ${cache}.federal.htm || ! $(zztool dump ${cache}.federal.htm | grep "^[ 0]*$num_con " >/dev/null)
					then
						wget -q -O "${cache}.federal.zip" "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_federa.zip"
						$un_zip "${cache}.federal.zip" "*.htm" -d "$tmp_dir" 2>/dev/null
						mv -f "${tmp_dir}/d_lotfed.htm" ${cache}.federal.htm
						rm -f ${cache}.federal.zip
					fi
					zztool dump ${cache}.federal.htm |
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
					if ! test -e ${cache}.timemania.htm || ! $(zztool dump ${cache}.timemania.htm | grep "^ *$num_con " >/dev/null)
					then
						wget -q -O "${cache}.timemania.zip" "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_timasc.zip"
						$un_zip "${cache}.timemania.zip" "*.htm" -d "$tmp_dir" 2>/dev/null
						mv -f "${tmp_dir}/d_timasc.htm" ${cache}.timemania.htm
						rm -f ${cache}.timemania.zip
					fi
					zztool dump ${cache}.timemania.htm |
					if test 0 = "$num_con"
					then
						awk '
						BEGIN { printf "## QTD\t## QTD\t## QTD\t## QTD\n" }
						$2 ~ /[0-9]\/[0-9][0-9]\/[0-9]/ { for (i=3;i<10;i++) numeros[$i]++ }
						END {
							for (i=1;i<=20;i++) {
								num=sprintf("%02d",i)
								printf "%02d %d\t%02d %d\t%02d %d\t%02d %d\n", i, numeros[num], i+20, numeros[i+20], i+40, numeros[i+40], i+60, numeros[i+60]
							}
						}
						' | expand -t 10
					else
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
						}' | expand -t 15,25,35
					fi
				;;
				loteca)
					if test 0 = "$num_con"
					then
						zztool erro "Não se aplica a loteca."
						return 1
					fi

					if ! test -e ${cache}.loteca.htm || ! $(zztool dump ${cache}.loteca.htm | grep "^ *$num_con " >/dev/null)
					then
						wget -q -O "${cache}.loteca.zip" "http://www1.caixa.gov.br/loterias/_arquivos/loterias/d_loteca.zip"
						$un_zip "${cache}.loteca.zip" "*.htm" -d "$tmp_dir"
						mv -f "${tmp_dir}/d_loteca.htm" ${cache}.loteca.htm
						zzdatafmt --iso hoje >> ${cache}.loteca.htm
						rm -f ${cache}.loteca.zip
					fi
					zztool dump ${cache}.loteca.htm |
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
			echo
		fi
	done
}

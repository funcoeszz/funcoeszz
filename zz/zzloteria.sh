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
		local url_historico
		local filtro="^ *$num_con "

		# A federal é um JSON, precisa de um filtro diferente
		test 'federal' = "$tipo" && filtro="\"numero\":$num_con,"

		# URLs feiosas para acesso aos dados históricos. Geralmente esta
		# URL está em um link no fim da página principal da loteria.
		case $tipo in
			lotofacil)
				# https://www.loterias.caixa.gov.br/wps/portal/loterias/landing/lotofacil
				url_historico='http://www.loterias.caixa.gov.br/wps/portal/loterias/landing/lotofacil/!ut/p/a1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLNDH0MPAzcDbz8vTxNDRy9_Y2NQ13CDA0sTIEKIoEKnN0dPUzMfQwMDEwsjAw8XZw8XMwtfQ0MPM2I02-AAzgaENIfrh-FqsQ9wBmoxN_FydLAGAgNTKEK8DkRrACPGwpyQyMMMj0VAcySpRM!/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_HGK818G0K85260Q5OIRSC42046/res/id=historicoHTML/c=cacheLevelPage/=/'
			;;
			megasena)
				# http://www.loterias.caixa.gov.br/wps/portal/loterias/landing/megasena
				url_historico='http://www.loterias.caixa.gov.br/wps/portal/loterias/landing/megasena/!ut/p/a1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLNDH0MPAzcDbwMPI0sDBxNXAOMwrzCjA0sjIEKIoEKnN0dPUzMfQwMDEwsjAw8XZw8XMwtfQ0MPM2I02-AAzgaENIfrh-FqsQ9wNnUwNHfxcnSwBgIDUyhCvA5EawAjxsKckMjDDI9FQE-F4ca/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_HGK818G0K8DBC0QPVN93KQ10G1/res/id=historicoHTML/c=cacheLevelPage/=/'
			;;
			duplasena)
				# http://www.loterias.caixa.gov.br/wps/portal/loterias/landing/duplasena
				url_historico='http://www.loterias.caixa.gov.br/wps/portal/loterias/landing/duplasena/!ut/p/a1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLNDH0MPAzcDbwMPI0sDBxNXAOMwrzCjA2cDIAKIoEKnN0dPUzMfQwMDEwsjAw8XZw8XMwtfQ0MPM2I02-AAzgaENIfrh-FqsQ9wNnUwNHfxcnSwBgIDUyhCvA5EawAjxsKckMjDDI9FQGgnyPS/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_HGK818G0K85260Q5OIRSC420O6/res/id=historicoHTML/c=cacheLevelPage/=/'
			;;
			quina)
				# http://www.loterias.caixa.gov.br/wps/portal/loterias/landing/quina
				url_historico='http://www.loterias.caixa.gov.br/wps/portal/loterias/landing/quina/!ut/p/a1/jc69DoIwAATgZ_EJepS2wFgoaUswsojYxXQyTfgbjM9vNS4Oordd8l1yxJGBuNnfw9XfwjL78dmduIikhYFGA0tzSFZ3tG_6FCmP4BxBpaVhWQuA5RRWlUZlxR6w4r89vkTi1_5E3CfRXcUhD6osEAHA32Dr4gtsfFin44Bgdw9WWSwj/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_HGK818G0K85260Q5OIRSC420O4/res/id=historicoHTML/c=cacheLevelPage/=/'
			;;
			federal)
				# https://www.loterias.caixa.gov.br/wps/portal/loterias/landing/federal
				url_historico='http://www.loterias.caixa.gov.br/wps/portal/loterias/landing/federal/!ut/p/a1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLNDH0MPAzcDbz8vTxNDRy9_Y2NQ13CDA0MzIAKIoEKnN0dPUzMfQwMDEwsjAw8XZw8XMwtfQ0MPM2I02-AAzgaENIfrh-FqsQ9wBmoxN_FydLAGAgNTKEK8DkRrACPGwpyQyMMMj0VAYe29yM!/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_HGK818G0KGAB50QMU0UQ6S10G0/res/id=historicoHTML/c=cacheLevelPage/=/'
			;;
			timemania)
				# http://www.loterias.caixa.gov.br/wps/portal/loterias/landing/timemania
				url_historico='http://www.loterias.caixa.gov.br/wps/portal/loterias/landing/timemania/!ut/p/a1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLNDH0MPAzcDbz8vTxNDRy9_Y2NQ13CDA1MzIEKIoEKnN0dPUzMfQwMDEwsjAw8XZw8XMwtfQ0MPM2I02-AAzgaENIfrh-FqsQ9wBmoxN_FydLAGAgNTKEK8DkRrACPGwpyQyMMMj0VASrq9qk!/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_HGK818G0K85260Q5OIRSC42047/res/id=historicoHTML/c=cacheLevelPage/=/'
			;;
			loteca)
				# https://www.loterias.caixa.gov.br/wps/portal/loterias/landing/loteca
				url_historico='http://www.loterias.caixa.gov.br/wps/portal/loterias/landing/loteca/!ut/p/a1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLNDH0MPAzcDbz8vTxNDRy9_Y2NQ13CDA3cDYEKIoEKnN0dPUzMfQwMDEwsjAw8XZw8XMwtfQ0MPM2I02-AAzgaENIfrh-FqsQ9wBmoxN_FydLAGAgNTKEK8DkRrACPGwpyQyMMMj0VAbNnwlU!/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_HGK818G0K85260Q5OIRSC420O7/res/id=historicoHTML/c=cacheLevelPage/=/'
			;;
			*)
				zztool erro "Desculpe, no momento não suportamos dados históricos para $tipo."
				return 1
			;;
		esac

		# Se o arquivo de cache não existir, crie-o
		# Se o arquivo existir, porém não tiver o concurso desejado, atualize-o
		if ! test -e "${cache}.${tipo}.htm" ||
			! zztool dump "${cache}.${tipo}.htm" | grep "$filtro" >/dev/null
		then
			echo "Aguarde, atualizando o cache local para $tipo..." >&2
			wget -q -O "${cache}.${tipo}.htm" "$url_historico"

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

		if test 'federal' = "$tipo"
		then
			cat "${cache}.${tipo}.htm"  # é na verdade um JSON
		else
			zztool dump "${cache}.${tipo}.htm"
		fi |
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
					printf "15 pts.\t%s\t%s\n", $19, "R$ " $(NF-7)
					printf "14 pts.\t%s\t%s\n", $(NF-11), "R$ " $(NF-6)
					printf "13 pts.\t%s\t%s\n", $(NF-10), "R$ " $(NF-5)
					printf "12 pts.\t%s\t%s\n", $(NF-9), "R$ " $(NF-4)
					printf "11 pts.\t%s\t%s\n", $(NF-8), "R$ " $(NF-3)
				}' |
				sed '/^[0-9 ]/s/^/   /;s/_/     /g' |
				expand -t 5,15,25 |

				# Dezenas vêm com 3 dígitos, muda pra 2. Exemplo: 012 -> 12
				sed '2,4 s/ 0/ /g'
			;;

			megasena)
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
				}' |
				expand -t 15,25,35 |

				# Dezenas vêm com 3 dígitos, muda pra 2. Exemplo: 012 -> 12
				sed '2s/ 0/  /g'
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
					printf "   Sena  \t%s\t%s\n", ($10), "R$ " $(NF-24)
					printf "   Quina \t%s\t%s\n", $(NF-21), "R$ " $(NF-20)
					printf "   Quadra\t%s\t%s\n", $(NF-19), "R$ " $(NF-18)
					printf "\n  2º Sorteio\n"
					printf "   Sena  \t%s\t%s\n", $(NF-9), "R$ " $(NF-8)
					printf "   Quina \t%s\t%s\n", $(NF-7), "R$ " $(NF-6)
					printf "   Quadra\t%s\t%s\n", $(NF-5), "R$ " $(NF-4)
				}' |
				sed '/^[0-9][0-9]/s/^/   /;s/_/   /g' |

				# Dezenas vêm com 3 dígitos, muda pra 2. Exemplo: 012 -> 12
				sed '4s/ 0/ /g; 7s/ 0/ /g'
			;;

			quina)
				grep "^ *$num_con " 2>/dev/null |
				awk '{
					print "Concurso", $1, "(" $2 ")"
					comando="sort -n | paste -d _ - - - - -"
					for (i=3;i<8;i++) {print $i | comando }
					close(comando)
					print ""
					printf "   Quina \t%s\t%s\n", ($9), "R$ " $(NF-10)
					printf "   Quadra\t%s\t%s\n", $(NF-9), "R$ " $(NF-8)
					printf "   Terno \t%s\t%s\n", $(NF-7), "R$ " $(NF-6)
				}' |
				sed '/^[0-9][0-9]/s/^/   /;s/_/   /g' |
				expand -t 15,25,35 |

				# Dezenas vêm com 3 dígitos, muda pra 2. Exemplo: 012 -> 12
				sed '2s/ 0/ /g'
			;;

			federal)
				# O resultado não é um HTML, mas sim um JSON. Poderíamos
				# usar o `jq` para fazer o parsing, mas não é comum as
				# pessoas o terem instalado. Em vez disso, vamos fazer
				# uma extração de dados em shell mesmo e torcer para que
				# a CEF não mude o formato do JSON.

				# Como o JSON não tem quebra de linhas (é uma enorme
				# linha única com todos os dados), primeiro deixaremos
				# somente um concurso por linha.
				sed 's/{"tipoJogo":"LOTERIA_FEDERAL"/\
&/g' |

				# Agora pega somente a linha do concurso desejado
				grep -F "\"numero\":$num_con," |

				# Para a posteridade, aqui está um exemplo da linha
				# completa em toda a sua glória de 1350+ caracteres
				# (concurso 2500):
				#
				# {"tipoJogo":"LOTERIA_FEDERAL","numero":2500,"nomeMunicipioUFSorteio":"","dataApuracao":"11/01/1989","valorArrecadado":0.00,"valorEstimadoProximoConcurso":0.00,"valorAcumuladoProximoConcurso":0.00,"valorAcumuladoConcursoEspecial":0.00,"valorAcumuladoConcurso_0_5":0.00,"acumulado":true,"indicadorConcursoEspecial":1,"dezenasSorteadasOrdemSorteio":["066069","077589","060325","003547","048642"],"numeroJogo":10,"nomeTimeCoracaoMesSorte":"                 ","tipoPublicacao":3,"observacao":"","localSorteio":"                                        ","dataProximoConcurso":null,"numeroConcursoAnterior":0,"numeroConcursoProximo":2501,"valorTotalPremioFaixaUm":0,"numeroConcursoFinal_0_5":0,"mensagem":null,"listaResultadoEquipeEsportiva":null,"listaMunicipioUFGanhadores":[],"listaRateioPremio":[{"faixa":1,"numeroDeGanhadores":0,"valorPremio":200000.00,"descricaoFaixa":"1 acertos"},{"faixa":2,"numeroDeGanhadores":0,"valorPremio":8000.00,"descricaoFaixa":"2 acertos"},{"faixa":3,"numeroDeGanhadores":0,"valorPremio":5000.00,"descricaoFaixa":"3 acertos"},{"faixa":4,"numeroDeGanhadores":0,"valorPremio":4000.00,"descricaoFaixa":"4 acertos"},{"faixa":5,"numeroDeGanhadores":0,"valorPremio":2000.00,"descricaoFaixa":"5 acertos"}],"listaDezenas":["066069","077589","060325","003547","048642"],"listaDezenasSegundoSorteio":null,"id":null},

				grep -E -o \
					-e '"numero":[0-9]+' \
					-e '"dataApuracao":"[^"]+"' \
					-e '"dezenasSorteadasOrdemSorteio":\[[^]]+\]' \
					-e '"valorPremio":[^,]+' |

				# Usando `grep -o` e múltiplos patterns, conseguimos
				# extrair os dados desejados, em uma linha para cada
				# match:
				#
				# "numero":2500
				# "dataApuracao":"11/01/1989"
				# "dezenasSorteadasOrdemSorteio":["066069","077589","060325","003547","048642"]
				# "valorPremio":200000.00
				# "valorPremio":8000.00
				# "valorPremio":5000.00
				# "valorPremio":4000.00
				# "valorPremio":2000.00

				# Faremos agora uma limpeza pra deixar somente os dados
				cut -d : -f 2 |
				tr '[]",' ' ' |

				# Este é o resultado:
				#
				# 2500
				#  11/01/1989
				#   066069   077589   060325   003547   048642
				# 200000.00
				# 8000.00
				# 5000.00
				# 4000.00
				# 2000.00

				# Tira o zero inicial dos números sorteados
				sed 's/ 0//g' |

				# E agora podemos finalmente deixar tudo em uma única
				# linha, para o awk fazer a festa com ela
				tr '\n' ' ' |
				awk '{
					print "Concurso", $1, "(" $2 ")"
					print ""

					printf "   1º Premio     %s   %s\n", $3, "R$ " $8
					printf "   2º Premio     %s   %s\n", $4, "R$ " $9
					printf "   3º Premio     %s   %s\n", $5, "R$ " $10
					printf "   4º Premio     %s   %s\n", $6, "R$ " $11
					printf "   5º Premio     %s   %s\n", $7, "R$ " $12
				}'

				# XXX O ideal seria formatar os valores em reais com a
				# zznumero, mas não sei como chamar ela de dentro do
				# awk. Fica para uma melhoria futura.
			;;

			timemania)
				grep "^ *$num_con " 2>/dev/null |
				sed 's/\([[:upper:]]\) \([[:upper:]]\)/\1_\2/g' |
				awk '{
					print "Concurso", $1, "(" $2 ")"
					printf "%5s %4s %4s %4s %4s %4s %4s\n", $3, $4, $5, $6, $7, $8, $9
					print ""
					printf "   7 pts.\t%s\t%s\n", $12, "R$ " $(NF-7)
					printf "   6 pts.\t%s\t%s\n", $(NF-12), "R$ " $(NF-6)
					printf "   5 pts.\t%s\t%s\n", $(NF-11), "R$ " $(NF-5)
					printf "   4 pts.\t%s\t%s\n", $(NF-10), "R$ " $(NF-4)
					printf "   3 pts.\t%s\t%s\n", $(NF-9), "R$ " $(NF-3)
					printf "\n   Time: %s\n\t%s\t%s\n", $10, $(NF-8), "R$ " $(NF-2)
				}' |
				expand -t 15,25,35
			;;

			loteca)
				# O resultado vem quebrado em 3 linhas, junta tudo numa
				# só e então formata com o awk
				grep -A 2 "^ *$num_con " 2>/dev/null |
				tr '\n' ' ' |
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
					printf "  14 pts.\t%s\t%s\n", $3, "R$ " $(NF-22)
					printf "  13 pts.\t%s\t%s\n", $(NF-19), "R$ " $(NF-18)
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

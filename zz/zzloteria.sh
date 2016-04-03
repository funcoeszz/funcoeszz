# ----------------------------------------------------------------------------
# Resultados da quina, megasena, duplasena, lotomania, lotofácil, federal, timemania e loteca.
#
# Se o 2º argumento for um número, pesquisa o resultado filtrando o concurso.
# Se nenhum argumento for passado, todas as loterias são mostradas.
#
# Uso: zzloteria [[loteria suportada] concurso]
# Ex.: zzloteria
#      zzloteria quina megasena
#      zzloteria loteca 550
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2004-05-18
# Versão: 13
# Licença: GPL
# Requisitos: zzlimpalixo
# Nota: requer links
# ----------------------------------------------------------------------------
zzloteria ()
{
	zzzz -h loteria "$1" && return

	local dump tipo num_con download
	local url='http://loterias.caixa.gov.br/wps/portal/loterias/landing'
	local tipos='quina megasena duplasena lotomania lotofacil federal timemania loteca'
	local cache=$(zztool cache loteria)
	local tab=$(printf '\t')
	local un_zip='unzip -q -a -C -o'

	which links >/dev/null 2>&1 || {
		zztool erro 'Necessário instalar o navegador de modo texto "links", "links2" ou "elinks".'
		return 1
	}

	download='links -source'

	# Caso o segundo argumento seja um numero, filtra pelo concurso equivalente
	if zztool testa_numero "$2"
	then
		tipos=$1
		num_con=$2
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
			# Resultados mais recentes das loterias selecionadas.
			dump=$(zztool dump links "${url}/${tipo}" | sed -n '/Resultado Concurso/,/^ *Arrecada/p' | sed '2,6d;s/^Resultado //')
			case "$tipo" in
				lotomania | lotofacil)
					echo "$dump" |
					zzlimpalixo |
					awk '
						NR==1{print}
						/^ *[0-9 ]*$/{print}
						$1 ~ /Estimativa/ || $2 ~ /acertos/ {printf $0;getline;print}
						/^ *Acumulado/
					' |
					sed "
						/^ *Estimativa/ i \

						/^ *\(20\|15\) acertos/ i \

						s/ 0 /  0 /
						s/acertos */pts.${tab}/
						s/ *apostas\{0,1\} ganhadoras\{0,1\},/${tab}/
					" | expand -t 5,15,25
				;;
				megasena | duplasena | quina | timemania)
					echo "$dump" |
					zzlimpalixo |
					awk '
						NR==1{print}
						/ sorteio$/{print "";print}
						/^ *Premia/{print}
						$1 ~ /Estimativa/ {printf "\n\n" $0;getline;print}
						$NF ~ /acertados|Cora.*o$/ {printf $0;getline;print}
						/\/[A-Z]/ {getline; if ($0 ~ /^ *[0-9]+ /) {sub(/^ */,"");print "\t" $0} else print "\n\n" $0}
						/^ *Acumulado/
						/^ *Valor acumulado/
						/\* [0-9]/{printf $0}
					' |
					sed "
						s/^ *\([12]-o\)/  \1/
						s/  \* //g
						s/Premia[^0-9]*//
						s/ - [0-9]//
						s/n.meros acertados */pts.${tab}/
						s/ *apostas\{0,1\} ganhadoras\{0,1\},/${tab}/
						s/Time do Cora[^ ]*/ Time:/
						/Time/ i \

					" |
					if test "$tipo" = "duplasena"
					then
						sed '2d;s/^\( *\)\([12]\)\(-o\|º\)/  \2º/;s/a pts./a/;/º [Ss]orteio/ i \
'
					else
						sed 's/\([ao]\) pts./\1/'
					fi |
					expand -t 15,25,35
				;;
				federal)
					echo "$dump" | sed -n '1p;/^ *[1-5]\(-o\|º\)/p;2s/.*//p;/^ *Destino/p' | sed 's/-o/º/;s/\([0-9.,]\{1,\}\) *$/R$ &/'
				;;
				loteca)
					echo "$dump" |
					sed -n '1p;/Coluna 1/,/^ *14/{s/[[:blank:]]*$//;p;}' |
					sed '
						2s/.*//
						3,${
							s/^ *//
							s/  */|/
							s/  */|/
							s/   */|/;
							s/[[:blank:]]\{1,\}\([0-9]\{1,\}\)[[:blank:]]\([^[:blank:]]\{1,\}\)$/|\1|\2/
						}' |
					awk -F "|" '
						NR==1
						NR==2 { printf " Jogo %66s\n", "Resultado" }
						NR>2 {
							printf " %2d  %23s %2d X %-2d %-23s  %8s\n", $1, $3, $2, $5, $4, "Col. " ($2==$5?"Meio":($2>$5?"1":"2"))}
					'
					echo "$dump" |
					awk '
						/Estimativa| acertos\)/ {printf $0;getline;print}
						/^ *Acumulado/
					' |
					sed "
						/^ *Estimativa/ i \

						s/[12].*(//
						s/acertos) */pts.${tab}/
						s/ *apostas\{0,1\} ganhadoras\{0,1\},/${tab}/
					" |
					sed '/^ *14/ i \
'
				;;
			esac
			echo
		else
			# Resultados históricos das loterias selecionadas.
			case "$tipo" in
				lotomania)
					if ! test -e ${cache}.lotomania.htm || ! $(zztool dump ${cache}.lotomania.htm | grep "^ *$num_con " >/dev/null)
					then
						$download "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_lotoma.zip" > "${cache}.lotomania.zip" 2>/dev/null
						$un_zip "${cache}.lotomania.zip" "*.HTM" -d "${ZZTMP%/*}" 2>/dev/null
						mv -f "${ZZTMP%/*}/D_LOTMAN.HTM" ${cache}.lotomania.htm
						rm -f ${cache}.lotomania.zip
					fi
					zztool dump ${cache}.lotomania.htm |
					grep "^ *$num_con " 2>/dev/null |
					awk ' {
						print "Concurso", $1, "(" $2 ")"
						comando="sort -n | paste -d _ - - - - -"
						for (i=3;i<23;i++) {print $i | comando }
						close(comando)
						print ""
						printf "20 pts.\t%s\t%s\n", ($24==0?"Nao houve acertador!":$24), ($24==0?"":"R$ " $(NF-13))
						printf "19 pts.\t%s\t%s\n", $(NF-18), "R$ " $(NF-12)
						printf "18 pts.\t%s\t%s\n", $(NF-17), "R$ " $(NF-11)
						printf "17 pts.\t%s\t%s\n", $(NF-16), "R$ " $(NF-10)
						printf "16 pts.\t%s\t%s\n", $(NF-15), "R$ " $(NF-9)
						printf " 0 pts.\t%s\t%s\n", ($(NF-14)==0?"Nao houve acertador!":$(NF-14)), ($(NF-14)==0?"":"R$ " $(NF-8))
					}' | sed '/^[0-9 ]/s/^/   /;s/_/     /g' | expand -t 5,15,25
				;;
				lotofacil)
					if ! test -e ${cache}.lotofacil.htm || ! $(zztool dump ${cache}.lotofacil.htm | grep "^ *$num_con " >/dev/null)
					then
						$download "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_lotfac.zip" > "${cache}.lotofacil.zip" 2>/dev/null
						$un_zip "${cache}.lotofacil.zip" "*.HTM" -d "${ZZTMP%/*}" 2>/dev/null
						mv -f "${ZZTMP%/*}/D_LOTFAC.HTM" ${cache}.lotofacil.htm
						rm -f ${cache}.lotofacil.zip
					fi
					zztool dump ${cache}.lotofacil.htm |
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
				;;
				megasena)
					if ! test -e ${cache}.mega.htm || ! $(zztool dump ${cache}.megasena.htm | grep "^ *$num_con " >/dev/null)
					then
						$download "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_mgsasc.zip" > "${cache}.megasena.zip" 2>/dev/null
						$un_zip "${cache}.megasena.zip" "*.htm" -d "${ZZTMP%/*}" 2>/dev/null
						mv -f "${ZZTMP%/*}/d_megasc.htm" ${cache}.megasena.htm
						rm -f ${cache}.megasena.zip
					fi
					zztool dump ${cache}.megasena.htm |
					grep "^ *$num_con " 2>/dev/null |
					awk '{
						print "Concurso", $1, "(" $2 ")"
						printf "%4s %4s %4s %4s %4s %4s\n", $3, $4, $5, $6, $7, $8
						print ""
						printf "   Sena  \t%s\t%s\n", ($10==0?"Nao houve acertador!":$10), ($10==0?"":"R$ " $(NF-8))
						printf "   Quina \t%s\t%s\n", $(NF-7), "R$ " $(NF-6)
						printf "   Quadra\t%s\t%s\n", $(NF-5), "R$ " $(NF-4)
					}' | expand -t 15,25,35
				;;
				duplasena)
					if ! test -e ${cache}.duplasena.htm || ! $(zztool dump ${cache}.duplasena.htm | grep "^ *$num_con " >/dev/null)
					then
						$download "http://www1.caixa.gov.br/loterias/_arquivos/loterias/d_dplsen.zip" > "${cache}.duplasena.zip" 2>/dev/null
						$un_zip "${cache}.duplasena.zip" "*.HTM" -d "${ZZTMP%/*}" 2>/dev/null
						mv -f "${ZZTMP%/*}/D_DPLSEN.HTM" ${cache}.duplasena.htm
						rm -f ${cache}.duplasena.zip
					fi
					zztool dump ${cache}.duplasena.htm |
					grep "^ *$num_con " 2>/dev/null |
					awk '{
						print "Concurso", $1, "(" $2 ")"
						printf "\n  1º sorteio\n"
						comando="sort -n | paste -d _ - - - - - -"
						for (i=3;i<9;i++) {print $i | comando }
						close(comando)
						printf "\n  2º sorteio\n"
						for (i=12;i>6;i--) {print $(NF-i) | comando }
						close(comando)
						printf "\n  1º Sorteio\n"
						printf "   Sena  \t%s\t%s\n", ($10==0?"Nao houve acertador":$10), ($10==0?"":"R$ " $(NF-19))
						printf "   Quina \t%s\t%s\n", $(NF-18), "R$ " $(NF-17)
						printf "   Quadra\t%s\t%s\n", $(NF-16), "R$ " $(NF-16)
						printf "\n  2º Sorteio\n"
						printf "   Sena  \t%s\t%s\n", ($(NF-6)==0?"Nao houve acertador":$(NF-6)), ($(NF-6)==0?"":"R$ " $(NF-5))
						printf "   Quina \t%s\t%s\n", $(NF-4), "R$ " $(NF-3)
						printf "   Quadra\t%s\t%s\n", $(NF-2), "R$ " $(NF-1)
					}' | sed '/^[0-9][0-9]/s/^/   /;s/_/   /g'
				;;
				quina)
					if ! test -e ${cache}.quina.htm || ! $(zztool dump ${cache}.quina.htm | grep "^ *$num_con " >/dev/null)
					then
						$download "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_quina.zip" > "${cache}.quina.zip" 2>/dev/null
						$un_zip "${cache}.quina.zip" "*.HTM" -d "${ZZTMP%/*}" 2>/dev/null
						mv -f "${ZZTMP%/*}/D_QUINA.HTM" ${cache}.quina.htm
						rm -f ${cache}.quina.zip
					fi
					zztool dump ${cache}.quina.htm |
					grep "^ *$num_con " 2>/dev/null |
					awk '{
						print "Concurso", $1, "(" $2 ")"
						comando="sort -n | paste -d _ - - - - -"
						for (i=3;i<8;i++) {print $i | comando }
						close(comando)
						print ""
						printf "   Quina \t%s\t%s\n", ($9==0?"Nao houve acertador":$9), ($9==0?"":"R$ " $(NF-8))
						printf "   Quadra\t%s\t%s\n", $(NF-7), "R$ " $(NF-6)
						printf "   Terno \t%s\t%s\n", $(NF-5), "R$ " $(NF-5)
					}' | sed '/^[0-9][0-9]/s/^/   /;s/_/   /g' | expand -t 15,25,35
				;;
				federal)
					if ! test -e ${cache}.federal.htm || ! $(zztool dump ${cache}.federal.htm | grep "^[ 0]*$num_con " >/dev/null)
					then
						$download "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_federa.zip" > "${cache}.federal.zip" 2>/dev/null
						$un_zip "${cache}.federal.zip" "*.HTM" -d "${ZZTMP%/*}" 2>/dev/null
						mv -f "${ZZTMP%/*}/D_LOTFED.HTM" ${cache}.federal.htm
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
						$download "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_timasc.zip" > "${cache}.timemania.zip" 2>/dev/null
						$un_zip "${cache}.timemania.zip" "*.HTM" -d "${ZZTMP%/*}" 2>/dev/null
						mv -f "${ZZTMP%/*}/D_TIMASC.HTM" ${cache}.timemania.htm
						rm -f ${cache}.timemania.zip
					fi
					zztool dump ${cache}.timemania.htm |
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
				;;
				loteca)
					if ! test -e ${cache}.loteca.htm || ! $(zztool dump ${cache}.loteca.htm | grep "^ *$num_con " >/dev/null)
					then
						$download "http://www1.caixa.gov.br/loterias/_arquivos/loterias/d_loteca.zip" > "${cache}.loteca.zip" 2>/dev/null
						$un_zip "${cache}.loteca.zip" "*.HTM" -d "${ZZTMP%/*}" 2>/dev/null
						mv -f "${ZZTMP%/*}/D_LOTECA.HTM" ${cache}.loteca.htm
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

# ----------------------------------------------------------------------------
# http://www1.caixa.gov.br/loterias
# Resultados da quina, megasena, duplasena, lotomania, lotofácil, federal, timemania e loteca.
#
# Se o 2º argumento for um número, pesquisa o resultado filtrando o concurso.
# Se nenhum argumento for passado, todas as loterias são mostradas.
#
# Uso: zzloteria2 [[loteria suportada] concurso]
# Ex.: zzloteria2
#      zzloteria2 quina megasena
#      zzloteria2 loteca 550
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2009-10-04
# Versão: 10
# Licença: GPL
# Requisitos: zzseq zzjuntalinhas zzdatafmt
# ----------------------------------------------------------------------------
zzloteria2 ()
{
	zzzz -h loteria2 "$1" && return

	local dump numero_concurso data resultado acumulado tipo ZZWWWDUMP2
	local resultado_val resultado_num num_con sufixo faixa
	local url='http://www1.caixa.gov.br/loterias/loterias'
	local tipos='quina megasena duplasena lotomania lotofacil federal timemania loteca'
	local cache=$(zztool cache loteria2)
	local tab=$(printf '\t')

	if which links >/dev/null 2>&1
	then
		ZZWWWDUMP2='links -dump'
	else
		zztool erro 'Instale o navegador de modo texto "links", "links2" ou "elinks".'
		return 1
	fi

	# Caso o segundo argumento seja um numero, filtra pelo concurso equivalente
	zztool testa_numero "$2"
	if (test $? -eq 0)
	then
		tipos="$1"
		case $tipos in
			duplasena | federal | timemania | loteca)
				num_con="?submeteu=sim&opcao=concurso&txtConcurso=$2"
			;;
			*) num_con=$2 ;;
		esac
	else
	# Caso contrario mostra todos os tipos, ou alguns selecionados
		unset num_con
		test -n "$1" && tipos="$*"
	fi

	# Para cada tipo de loteria...
	for tipo in $tipos
	do

		# Há várias pegadinhas neste código. Alguns detalhes:
		# - A variável $dump é um cache local do resultado
		# - É usado ZZWWWDUMP2+filtros (e não ZZWWWHTML) para forçar a saída em UTF-8
		# - O resultado é deixado como uma única longa linha
		# - O resultado são vários campos separados por pipe |
		# - Cada tipo de loteria traz os dados em posições (e formatos) diferentes :/

		case "$tipo" in
			duplasena)
				sufixo="_pesquisa_new.asp"
			;;
			*)
				sufixo="_pesquisa.asp"
			;;
		esac

		dump=$($ZZWWWDUMP2 "$url/$tipo/${tipo}${sufixo}$num_con" |
				tr -d \\n |
				sed 's/  */ /g ; s/^ //')

		# O número do concurso é sempre o primeiro campo
		numero_concurso=$(echo "$dump" | cut -d '|' -f 1)

		case "$tipo" in
			lotomania)
			faixa=$(zzseq -f "\t%d ptos\n" 20 1 16)
			printf %b "${faixa}\n\t 0 ptos" > "${cache}"
			if ! zztool testa_numero "$num_con"
			then
				# O resultado vem separado em campos distintos. Exemplo:
				# |01|04|06|12|21|25|27|36|42|44|50|51|53|59|68|69|74|78|87|91|91|

				data=$(     echo "$dump" | cut -d '|' -f 42)
				acumulado=$(echo "$dump" | cut -d '|' -f 70)
				resultado=$(echo "$dump" | cut -d '|' -f 7-26 |
					sed 's/|/@/10 ; s/|/ - /g' |
					tr @ '\n'
				)
				echo "$dump" | cut -d '|' -f 28,30,32,34,36,38 | tr '|' '\n' > "${cache}.num"
				echo "$dump" | cut -d '|' -f 29,31,33,35,37,39 | tr '|' '\n' > "${cache}.val"
			else
				if ! test -e ${ZZTMP}.lotomania.htm || ! $(grep "^$num_com " ${ZZTMP}.lotomania.htm >/dev/null)
				then
					wget -q "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_lotoma.zip" -O "${ZZTMP}.lotomania.zip" 2>/dev/null
					unzip -q -o -d "${ZZTMP%/*}" "${ZZTMP}.lotomania.zip" 2>/dev/null
					mv "${ZZTMP%/*}/D_LOTMAN.HTM" ${ZZTMP}.lotomania.htm
					rm -f ${ZZTMP}.lotomania.zip ${ZZTMP%/*}/*.GIF
				fi
				numero_concurso=$num_con
				dump=$($ZZWWWDUMP2 ${ZZTMP}.lotomania.htm | awk '$1=='$num_con)
				data=$(echo "$dump" | awk '{print $2}')
				acumulado=$(echo "$dump" |
					awk '{
							pos=29
							limite=0
							while (limite<=13){
								if ($pos ~ /[0-9],[0-9]+$/) { limite++ }
								if (limite==13) { print $pos; break }
								pos++
							}
						}')
				resultado=$(echo "$dump" |
					awk '{for (i=3;i<=22;i++) printf $i " " } END { print "" }' |
					while read resultado_val
					do
						echo "$resultado_val" | zztool list2lines | sort -n | zztool lines2list
					done |
					sed 's/ /\
/10' | sed 's/ *$//'
					)
				resultado=$(echo "$resultado" | sed 's/ / - /g')
				echo "$dump" |
					awk '{
							print $24
							pos=25
							limite=1
							while (limite<=5) {
								if ($pos ~ /^[0-9]+$/) { printf $pos " " ; limite++ }
								pos++
							}
						}' | zztool list2lines > "${cache}.num"
				echo "$dump" |
					awk '{
							pos=29
							limite=1
							while (limite<=6) {
								if ($pos ~ /[0-9],[0-9]+$/) { printf $pos " " ; limite++ }
								pos++
							}
						}' | tr ' ' '\n' > "${cache}.val"
			fi
			;;
			lotof[áa]cil)
				# O resultado vem separado em campos distintos. Exemplo:
				# |01|04|07|08|09|10|12|14|15|16|21|22|23|24|25|

				faixa=$(zzseq -f "\t%d ptos\n" 15 1 11)
				echo "$faixa" > "${cache}"
				if ! zztool testa_numero "$num_con"
				then
					resultado=$(echo "$dump" | cut -d '|' -f 4-18 |
						sed 's/|/@/10 ; s/|/@/5 ; s/|/ - /g' |
						tr @ '\n'
					)
					echo "$dump" | cut -d '|' -f 19,21,23,25,27 | tr '|' '\n' > "${cache}.num"
					echo "$dump" | cut -d '|' -f 20,22,24,26,28 | tr '|' '\n' > "${cache}.val"
					dump=$(    echo "$dump" | sed 's/.*Estimativa de Pr//')
					data=$(     echo "$dump" | cut -d '|' -f 6)
					acumulado=$(echo "$dump" | cut -d '|' -f 25,26)
				else
					if ! test -e ${ZZTMP}.lotofacil.htm || ! $(grep "^$num_com " ${ZZTMP}.lotofacil.htm >/dev/null)
					then
						wget -q "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_lotfac.zip" -O "${ZZTMP}.lotofacil.zip" 2>/dev/null
						unzip -q -o -d "${ZZTMP%/*}" "${ZZTMP}.lotofacil.zip" 2>/dev/null
						mv "${ZZTMP%/*}/D_LOTFAC.HTM" ${ZZTMP}.lotofacil.htm
						rm -f ${ZZTMP}.lotofacil.zip ${ZZTMP%/*}/*.GIF
					fi
					numero_concurso=$num_con
					dump=$($ZZWWWDUMP2 ${ZZTMP}.lotofacil.htm | awk '$1=='$num_con)
					data=$(echo "$dump" | awk '{print $2}')
					acumulado=$(echo "$dump" | awk '{print $(NF-2)}')
					resultado=$(echo "$dump" |
						awk '{print $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17}' |
						while read resultado_val
						do
							echo "$resultado_val" | zztool list2lines | sort -n | zztool lines2list
						done |
						sed 's/ /\
/5;s/ /\
/9'
						)
					resultado=$(echo "$resultado" | sed 's/ / - /g')
					echo "$dump" | awk '{print $19;     print $(NF-11); print $(NF-10); print $(NF-9); print $(NF-8)}' > "${cache}.num"
					echo "$dump" | awk '{print $(NF-7); print $(NF-6); print $(NF-5); print $(NF-4); print $(NF-3)}' > "${cache}.val"
				fi
			;;
			megasena)
				# O resultado vem separado por asteriscos. Exemplo:
				# | * 16 * 58 * 43 * 37 * 52 * 59 |

				faixa=$(printf '%b' "\tSena\n\tQuina\n\tQuadra\n")
				echo "$faixa" > "${cache}"
				if ! zztool testa_numero "$num_con"
				then
					data=$(     echo "$dump" | cut -d '|' -f 12)
					acumulado=$(echo "$dump" | cut -d '|' -f 22,23)
					resultado=$(echo "$dump" | cut -d '|' -f 21 |
						tr '*' '-'  |
						tr '|' '\n' |
						sed 's/^ - //'
					)
					echo "$dump" | cut -d '|' -f 4,6,8 | tr '|' '\n' > "${cache}.num"
					echo "$dump" | cut -d '|' -f 5,7,9 | tr '|' '\n' > "${cache}.val"
				else
					if ! test -e ${ZZTMP}.mega.htm || ! $(grep "^$num_com " ${ZZTMP}.mega.htm >/dev/null)
					then
						wget -q "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_mgsasc.zip" -O "${ZZTMP}.mega.zip" 2>/dev/null
						unzip -q -o -d "${ZZTMP%/*}" "${ZZTMP}.mega.zip" 2>/dev/null
						mv "${ZZTMP%/*}/d_megasc.htm" ${ZZTMP}.mega.htm
						rm -f ${ZZTMP}.mega.zip ${ZZTMP%/*}/*.GIF
					fi
					numero_concurso=$num_con
					dump=$($ZZWWWDUMP2 ${ZZTMP}.mega.htm | awk '$1=='$num_con)
					data=$(echo "$dump" | awk '{print $2}')
					acumulado=$(echo "$dump" | awk '{print $(NF-2)}')
					resultado=$(echo "$dump" | awk '{print $3, $4, $5, $6, $7, $8}')
					resultado=$(echo "$resultado" | sed 's/ / - /g')
					echo "$dump" | awk '{print $10;     print $(NF-7); print $(NF-5)}' > "${cache}.num"
					echo "$dump" | awk '{print $(NF-8); print $(NF-6); print $(NF-4)}' > "${cache}.val"
				fi
			;;
			duplasena)
				# O resultado vem separado por asteriscos, tendo dois grupos
				# numéricos: o primeiro e segundo resultado. Exemplo:
				# | * 05 * 07 * 09 * 21 * 38 * 40 | * 05 * 17 * 20 * 22 * 31 * 45 |

				data=$(     echo "$dump" | cut -d '|' -f 18)
				acumulado=$(echo "$dump" | cut -d '|' -f 23,24)
				resultado=$(echo "$dump" | cut -d '|' -f 4,5 |
					tr '*' '-'  |
					tr '|' '\n' |
					sed 's/^ - //'
				)
				faixa=$(printf %b "\t1a Sena\n\t1a Quina\n\t1a Quadra\n\n\t2a Sena\n\t2a Quina\n\t2a Quadra\n")
				echo "$faixa" > "${cache}"
				echo "$dump" | awk 'BEGIN {FS="|";OFS="\n"} {print $7,$26,$28,"",$9,$10,$13}' > "${cache}.num"
				echo "$dump" | awk 'BEGIN {FS="|";OFS="\n"} {print $8,$27,$29,"",$11,$12,$14}' > "${cache}.val"
			;;
			quina)
				# O resultado vem separado por asteriscos. Exemplo:
				# | * 07 * 13 * 42 * 56 * 69 |

				faixa=$(printf %b "\tQuina\n\tQuadra\n\tTerno\n")
				echo "$faixa" > "${cache}"
				if ! zztool testa_numero "$num_con"
				then
					dump=$(     echo "$dump" | zzjuntalinhas)
					data=$(     echo "$dump" | cut -d '|' -f 17)
					acumulado=$(echo "$dump" | cut -d '|' -f 18,19)
					resultado=$(echo "$dump" | cut -d '|' -f 15 |
						tr '*' '-'  |
						sed 's/^ - //'
					)
					echo "$dump" | cut -d '|' -f 7,9,11 | tr '|' '\n' > "${cache}.num"
					echo "$dump" | cut -d '|' -f 8,10,12 | tr '|' '\n' > "${cache}.val"
				else
					if ! test -e ${ZZTMP}.quina.htm || ! $(grep "^$num_com " ${ZZTMP}.quina.htm >/dev/null)
					then
						wget -q "http://www1.caixa.gov.br/loterias/_arquivos/loterias/D_quina.zip" -O "${ZZTMP}.quina.zip" 2>/dev/null
						unzip -q -o -d "${ZZTMP%/*}" "${ZZTMP}.quina.zip" 2>/dev/null
						mv "${ZZTMP%/*}/D_QUINA.HTM" ${ZZTMP}.quina.htm
						rm -f ${ZZTMP}.quina.zip ${ZZTMP%/*}/*.GIF
					fi
					numero_concurso=$num_con
					dump=$($ZZWWWDUMP2 ${ZZTMP}.quina.htm | awk '$1=='$num_con)
					data=$(echo "$dump" | awk '{print $2}')
					acumulado=$(echo "$dump" | awk '{print $(NF-2)}')
					resultado=$(echo "$dump" | awk '{print $3, $4, $5, $6, $7}' | zztool list2lines | sort -n | zztool lines2list)
					resultado=$(echo "$resultado" | sed 's/ / - /g')
					echo "$dump" | awk '{print $9;     print $(NF-7); print $(NF-5)}' > "${cache}.num"
					echo "$dump" | awk '{print $(NF-8); print $(NF-6); print $(NF-4)}' > "${cache}.val"
				fi
			;;
			federal)
				data=$(     echo "$dump" | cut -d '|' -f 17)
				numero_concurso=$(echo "$dump" | cut -d '|' -f 3)
				unset acumulado

				echo "$dump" | cut -d '|' -f 7,9,11,13,15 |
					tr '*' '-'  |
					tr '|' '\n' |
					sed 's/^ - //' > "${cache}.num"

				echo "$dump" | cut -d '|' -f 8,10,12,14,16 |
					tr '*' '-'  |
					tr '|' '\n' |
					sed 's/^ - //' > "${cache}.val"

				zzseq -f "%do Prêmio\n" 1 1 5 > $cache

				resultado=$(paste "$cache" "${cache}.num" "${cache}.val")
				unset faixa resultado_num resultado_val
			;;
			timemania)
				data=$(     echo "$dump" | cut -d '|' -f 2)
				acumulado=$(echo "$dump" | cut -d '|' -f 24)
				acumulado=${acumulado}"|"$(echo "$dump" | cut -d '|' -f 23 | zzdatafmt)
				resultado=$(echo "$dump" | cut -d '|' -f 8 |
					tr '*' '-'  |
					tr '|' '\n' |
					sed 's/^ - //'
				)
				resultado=$(printf %b "${resultado}\nTime: "$(echo "$dump" | cut -d '|' -f 9))
				faixa=$(zzseq -f "\t%d ptos\n" 7 1 3)
				echo "$faixa" > "${cache}"
				echo "$dump" | cut -d '|' -f 10,12,14,16,18 | tr '|' '\n' > "${cache}.num"
				echo "$dump" | cut -d '|' -f 11,13,15,17,19 | tr '|' '\n' > "${cache}.val"
			;;
			loteca)
				dump=$(     echo "$dump" | sed 's/[A-Z]|[A-Z]/-/g')
				data=$(     echo "$dump" | awk -F"|" '{print $(NF-4)}' )
				acumulado=$(echo "$dump" | awk -F"|" '{print $(NF-1) "|" $(NF)}' )
				acumulado="${acumulado}_Acumulado para a 1a faixa "$(echo "$dump" | awk -F"|" '{print $(NF-5)}' )
				acumulado="${acumulado}_"$(echo "$dump" | awk -F"|" '{print $(NF-2)}' )
				acumulado=$(echo "${acumulado}" | sed 's/_/\
   /g;s/ Valor //' )
				resultado=$($ZZWWWDUMP2 "$url/$tipo/${tipo}${sufixo}$num_con" |
				sed -n '3,/|/p' |
				awk '
					NR == 1 { sub("Data","Coluna"); sub(" X ","   ") }
					NR >= 2 {
						if (NF > 5) {
							if ( $2 > $(NF-1) )  { coluna = "Col.  1" }
							if ( $2 == $(NF-1) ) { coluna = "Col. Meio" }
							if ( $2 < $(NF-1) )  { coluna = "Col.  2" }
							sub($NF "  ", coluna)
						}
					}
					{if (NF > 5) print }
				')
				case $(echo "$num_con" | sed 's/.*=//;s/ *//g') in
					[1-9] | [1-8][0-9]) faixa=$(zzseq -f '\t%d\n' 14 12);;
					*) faixa=$(zzseq -f '\t%d\n' 14 13);;
				esac
				echo "$faixa" > "${cache}"
				echo "$dump" | cut -d '|' -f 5 | sed 's/ [123].\{1,2\} (1[234] acertos)/\
/g;' | sed '1d' | sed "s/[0-9] /&${tab}/g" > "${cache}.num"
				echo '' > "${cache}.val"; echo '' >> "${cache}.val"
			;;
		esac

		# Mostra o resultado na tela (caso encontrado algo)
		if test -n "$resultado"
		then
			zztool eco $tipo:
			echo "$resultado" | sed 's/^/   /'
			data=$(echo "$data" | zzdatafmt)
			echo "   Concurso $numero_concurso ($data)"
			test -n "$acumulado" && echo "   Acumulado em R$ $acumulado" | sed 's/|/ para /'
			if test -n "$faixa"
			then
				printf %b "\tFaixa\tQtde.\tPrêmio\n" | expand -t 5,17,32
				paste "${cache}" "${cache}.num" "${cache}.val"| expand -t 5,17,32
			fi
			echo
		fi
	done
}

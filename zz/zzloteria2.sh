# ----------------------------------------------------------------------------
# Resultados da quina, megasena, duplasena, lotomania, lotofácil, federal, timemania e loteca.
# Se o 2º argumento for um número, pesquisa o resultado filtrando o concurso.
# Se nenhum argumento for passado, todas as loterias são mostradas.
#
# Uso: zzloteria2 [[loteria suportada] concurso]
# Ex.: zzloteria2
#      zzloteria2 quina megasena
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2009-10-04
# Versão: 7
# Licença: GPL
# Requisitos: zzseq
# ----------------------------------------------------------------------------
zzloteria2 ()
{
	zzzz -h loteria2 "$1" && return

	local dump numero_concurso data resultado acumulado tipo ZZWWWDUMP2
	local resultado_val resultado_num num_con sufixo faixa
	local url='http://www1.caixa.gov.br/loterias/loterias'
	local tipos='quina megasena duplasena lotomania lotofacil federal timemania loteca'
	local cache="$ZZTMP.loteria2"

	if type links >/dev/null 2>&1
	then
		ZZWWWDUMP2='links -dump'
	else
		ZZWWWDUMP2=$ZZWWWDUMP
	fi

	# Caso o segundo argumento seja um numero, filtra pelo concurso equivalente
	zztool testa_numero "$2"
	if ([ $? -eq 0 ])
	then
		num_con="?submeteu=sim&opcao=concurso&txtConcurso=$2"
		tipos="$1"
	else
	# Caso contrario mostra todos os tipos, ou alguns selecionados
		unset num_con
		[ "$1" ] && tipos="$*"
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
				# O resultado vem separado em campos distintos. Exemplo:
				# |01|04|06|12|21|25|27|36|42|44|50|51|53|59|68|69|74|78|87|91|91|

				data=$(     echo "$dump" | cut -d '|' -f 42)
				acumulado=$(echo "$dump" | cut -d '|' -f 69,70)
				resultado=$(echo "$dump" | cut -d '|' -f 7-26 |
					sed 's/|/@/10 ; s/|/ - /g' |
					tr @ '\n'
				)
				faixa=$(zzseq -f "\t%d ptos\n" 20 1 16)
				printf %b "${faixa}\n\t 0 ptos" > "${cache}"
				echo "$dump" | cut -d '|' -f 28,30,32,34,36,38 | tr '|' '\n' > "${cache}.num"
				echo "$dump" | cut -d '|' -f 29,31,33,35,37,39 | tr '|' '\n' > "${cache}.val"
			;;
			lotof[áa]cil)
				# O resultado vem separado em campos distintos. Exemplo:
				# |01|04|07|08|09|10|12|14|15|16|21|22|23|24|25|
				resultado=$(echo "$dump" | cut -d '|' -f 4-18 |
					sed 's/|/@/10 ; s/|/@/5 ; s/|/ - /g' |
					tr @ '\n'
				)
				faixa=$(zzseq -f "\t%d ptos\n" 15 1 11)
				printf '%b\n' "$faixa" > "${cache}"
				echo "$dump" | cut -d '|' -f 19,21,23,25,27 | tr '|' '\n' > "${cache}.num"
				echo "$dump" | cut -d '|' -f 20,22,24,26,28 | tr '|' '\n' > "${cache}.val"
				dump=$(    echo "$dump" | sed 's/.*Estimativa de Pr//')
				data=$(     echo "$dump" | cut -d '|' -f 6)
				acumulado=$(echo "$dump" | cut -d '|' -f 25,26)
			;;
			megasena)
				# O resultado vem separado por asteriscos. Exemplo:
				# | * 16 * 58 * 43 * 37 * 52 * 59 |

				data=$(     echo "$dump" | cut -d '|' -f 12)
				acumulado=$(echo "$dump" | cut -d '|' -f 22,23)
				resultado=$(echo "$dump" | cut -d '|' -f 21 |
					tr '*' '-'  |
					tr '|' '\n' |
					sed 's/^ - //'
				)
				faixa=$(printf '%b' "\tSena\n\tQuina\n\tQuadra\n")
				printf '%b\n' "$faixa" > "${cache}"
				echo "$dump" | cut -d '|' -f 4,6,8 | tr '|' '\n' > "${cache}.num"
				echo "$dump" | cut -d '|' -f 5,7,9 | tr '|' '\n' > "${cache}.val"
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
				faixa=$(printf %b "\t1ª Sena\n\t1ª Quina\n\t1ª Quadra\n\n\t2ª Sena\n\t2ª Quina\n\t2ª Quadra\n")
				printf '%b\n' "$faixa" > "${cache}"
				echo "$dump" | awk 'BEGIN {FS="|";OFS="\n"} {print $7,$26,$28,"",$9,$10,$13}' > "${cache}.num"
				echo "$dump" | awk 'BEGIN {FS="|";OFS="\n"} {print $8,$27,$29,"",$11,$12,$14}' > "${cache}.val"
			;;
			quina)
				# O resultado vem duplicado em um único campo, sendo a segunda
				# parte o resultado ordenado numericamente. Exemplo:
				# | * 69 * 42 * 13 * 56 * 07 * 07 * 13 * 42 * 56 * 69 |

				data=$(     echo "$dump" | cut -d '|' -f 17)
				acumulado=$(echo "$dump" | cut -d '|' -f 18,19)
				resultado=$(echo "$dump" | cut -d '|' -f 15 |
					sed 's/\* /|/6' |
					tr '*' '-'  |
					tr '|' '\n' |
					sed 's/^ - // ; 1d'
				)
				faixa=$(echo "\tQuina|\tQuadra|\tTerno" | tr '|' '\n')
				printf '%b\n' "$faixa" > "${cache}"
				echo "$dump" | cut -d '|' -f 7,9,11 | tr '|' '\n' > "${cache}.num"
				echo "$dump" | cut -d '|' -f 8,10,12 | tr '|' '\n' > "${cache}.val"
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

				zzseq -f "%dº Prêmio\n" 1 1 5 > $cache

				resultado=$(paste "$cache" "${cache}.num" "${cache}.val")
				unset faixa resultado_num resultado_val
			;;
			timemania)
				data=$(     echo "$dump" | cut -d '|' -f 2)
				acumulado=$(echo "$dump" | cut -d '|' -f 24)
				acumulado=${acumulado}"|"$(echo "$dump" | cut -d '|' -f 23)
				resultado=$(echo "$dump" | cut -d '|' -f 8 |
					tr '*' '-'  |
					tr '|' '\n' |
					sed 's/^ - //'
				)
				resultado=$(printf %b "${resultado}\nTime: "$(echo "$dump" | cut -d '|' -f 9))
				faixa=$(zzseq -f "\t%d ptos\n" 7 1 3)
				printf '%b\n' "$faixa" > "${cache}"
				echo "$dump" | cut -d '|' -f 10,12,14,16,18 | tr '|' '\n' > "${cache}.num"
				echo "$dump" | cut -d '|' -f 11,13,15,17,19 | tr '|' '\n' > "${cache}.val"
			;;
			loteca)
				dump=$(     echo "$dump" | sed 's/[A-Z]|[A-Z]/-/g')
				data=$(     echo "$dump" | awk -F"|" '{print $(NF-4)}' )
				acumulado=$(echo "$dump" | awk -F"|" '{print $(NF-1) "|" $(NF)}' )
				acumulado="${acumulado}_Acumulado para a 1ª faixa "$(echo "$dump" | awk -F"|" '{print $(NF-5)}' )
				acumulado="${acumulado}_"$(echo "$dump" | awk -F"|" '{print $(NF-2)}' )
				acumulado=$(echo "${acumulado}" | sed 's/_/\
   /g;s/ Valor //' )
				resultado=$($ZZWWWDUMP2 "$url/$tipo/${tipo}${sufixo}$num_con" | sed -n '3,17p' |
				awk '
					NR == 1 { sub("Data","Coluna"); sub(" X ","   ") }
					NR >= 2 {
						if ( $2 > $(NF-1) )  { coluna = "Col.  1" }
						if ( $2 == $(NF-1) ) { coluna = "Col. Meio" }
						if ( $2 < $(NF-1) )  { coluna = "Col.  2" }
						sub($NF "  ", coluna)
					}
					{ print }
				')
				case $(echo "$num_con" | sed 's/.*=//;s/ *//g') in
					[1-9] | [1-8][0-9]) faixa=$(zzseq -f '\t%d\n' 14 12);;
					*) faixa=$(zzseq -f '\t%d\n' 14 13);;
				esac
				printf '%b\n' "$faixa" > "${cache}"
				echo "$dump" | cut -d '|' -f 5 | sed 's/ [123].\{1,2\} (1[234] acertos)/\
/g;' | sed '1d' | sed 's/[0-9] /&\t/g' > "${cache}.num"
				echo '' > "${cache}.val"; echo '' >> "${cache}.val"
			;;
		esac

		# Mostra o resultado na tela (caso encontrado algo)
		if [ "$resultado" ]
		then
			zztool eco $tipo:
			echo "$resultado" | sed 's/^/   /'
			echo "   Concurso $numero_concurso ($data)"
			[ "$acumulado" ] && echo "   Acumulado em R$ $acumulado" | sed 's/|/ para /'
			if [ "$faixa" ]
			then
				printf %b "\tFaixa\tQtde.\tPrêmio\n" | expand -t 5,17,32
				paste "${cache}" "${cache}.num" "${cache}.val"| expand -t 5,17,32
			fi
			echo
		fi
	done
}

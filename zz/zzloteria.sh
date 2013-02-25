# ----------------------------------------------------------------------------
# http://www1.caixa.gov.br/loterias
# Consulta os resultados da quina, megasena, duplasena, lotomania e lotofácil.
# Obs.: Se nenhum argumento for passado, todas as loterias são mostradas.
# Uso: zzloteria [quina | megasena | duplasena | lotomania | lotofacil]
# Ex.: zzloteria
#      zzloteria quina megasena
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2004-05-18
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzloteria ()
{
	zzzz -h loteria "$1" && return

	local dump numero_concurso data resultado acumulado tipo sufixo
	local url='http://www1.caixa.gov.br/loterias/loterias'
	local tipos='quina megasena duplasena lotomania lotofacil'

	# O padrão é mostrar todos os tipos, mas o usuário pode informar alguns
	[ "$1" ] && tipos=$*

	# Para cada tipo de loteria...
	for tipo in $tipos
	do
		zztool eco $tipo:

		# Há várias pegadinhas neste código. Alguns detalhes:
		# - A variável $dump é um cache local do resultado
		# - É usado ZZWWWDUMP+filtros (e não ZZWWWHTML) para forçar a saída em UTF-8
		# - O resultado é deixado como uma única longa linha
		# - O resultado são vários campos separados por pipe |
		# - Cada tipo de loteria traz os dados em posições (e formatos) diferentes :/

		if test "$tipo" = 'duplasena'
		then
			sufixo='_pesquisa_new.asp'
		else
			sufixo='_pesquisa.asp'
		fi

		dump=$($ZZWWWDUMP "$url/$tipo/$tipo$sufixo" |
			tr -d \\n |
			sed 's/  */ /g ; s/^ //')

		# O número do concurso é sempre o primeiro campo
		numero_concurso=$(echo "$dump" | cut -d '|' -f 1)

		case "$tipo" in
			lotomania)
				# O resultado vem separado em campos distintos. Exemplo:
				# |01|04|06|12|21|25|27|36|42|44|50|51|53|59|68|69|74|78|87|91|91|

				data=$(     echo "$dump" | cut -d '|' -f 42)
				acumulado=$(echo "$dump" | cut -d '|' -f 70,71)
				resultado=$(echo "$dump" | cut -d '|' -f 7-26 |
					sed 's/|/@/10 ; s/|/ - /g' |
					tr @ '\n'
				)
			;;
			lotofacil)
				# O resultado vem separado em campos distintos. Exemplo:
				# |01|04|07|08|09|10|12|14|15|16|21|22|23|24|25|

				data=$(     echo "$dump" | cut -d '|' -f 39)
				acumulado=$(echo "$dump" | cut -d '|' -f 58,59)
				resultado=$(echo "$dump" | cut -d '|' -f 4-18 |
					sed 's/|/@/10 ; s/|/@/5 ; s/|/ - /g' |
					tr @ '\n'
				)
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
			;;
		esac

		# Mostra o resultado na tela (caso encontrado algo)
		if [ "$resultado" ]
		then
			echo "$resultado" | sed 's/^/   /'
			echo "   Concurso $numero_concurso ($data)"
			[ "$acumulado" ] && echo "   Acumulado em R$ $acumulado" | sed 's/|/ para /'
			echo
		fi
	done
}

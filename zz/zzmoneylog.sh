# ----------------------------------------------------------------------------
# Consulta lançamentos do Moneylog, com pesquisa avançada e saldo total.
# Obs.: Chamado sem argumentos, pesquisa o mês corrente.
# Obs.: Não expande lançamentos recorrentes e parcelados.
#
# Uso: zzmoneylog [-d data] [-v valor] [-t tag] [--total] [texto]
# Ex.: zzmoneylog                       # Todos os lançamentos deste mês
#      zzmoneylog mercado               # Procure por mercado
#      zzmoneylog -t mercado            # Lançamentos com a tag mercado
#      zzmoneylog -t mercado -d 2011    # Tag mercado em 2011
#      zzmoneylog -t mercado --total    # Saldo total da tag mercado
#      zzmoneylog -d 31/01/2011         # Todos os lançamentos desta data
#      zzmoneylog -d 2011               # Todos os lançamentos de 2011
#      zzmoneylog -d ontem              # Todos os lançamentos de ontem
#      zzmoneylog -d mes                # Todos os lançamentos deste mês
#      zzmoneylog -d mes --total        # Saldo total deste mês
#      zzmoneylog -d 2011-0[123]        # Regex: que casa Jan/Fev/Mar de 2011
#      zzmoneylog -v /                  # Todos os pagamentos parcelados
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-25
# Versão: 1
# Licença: GPL
# Requisitos: zzcalcula zzdatafmt zzdos2unix
# ----------------------------------------------------------------------------
zzmoneylog ()
{
	zzzz -h moneylog "$1" && return

	local data valor tag total
	local arquivo=$ZZMONEYLOG

	# Chamado sem argumentos, mostra o mês corrente
	test $# -eq 0 && data=$(zzdatafmt -f AAAA-MM hoje)

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-t | --tag    ) shift; tag="$1";;
			-d | --data   ) shift; data="$1";;
			-v | --valor  ) shift; valor="$1";;
			-a | --arquivo) shift; arquivo="$1";;
			--total) total=1;;
			--) shift; break;;
			-*) echo "Opção inválida $1"; return 1;;
			*) break;;
		esac
		shift
	done

	# O-oh
	if test -z "$arquivo"
	then
		echo 'Ops, não sei onde encontrar seu arquivo de dados do Moneylog.'
		echo 'Use a variável $ZZMONEYLOG para indicar o caminho.'
		echo
		echo 'Se você usa a versão tudo-em-um, indique o arquivo HTML:'
		echo '    export ZZMONEYLOG=/home/fulano/moneylog.html'
		echo
		echo 'Se você usa vários arquivos TXT, indique a pasta:'
		echo '    export ZZMONEYLOG=/home/fulano/moneylog/'
		echo
		echo 'Além da variável, você também pode usar a opção --arquivo.'
		return 1
	fi

	# Consigo ler o arquivo? (Se não for pasta nem STDIN)
	if ! test -d "$arquivo" && test "$arquivo" != '-'
	then
		zztool arquivo_legivel "$arquivo" || return 1
	fi

	### DATA
	# Formata (se necessário) a data informada.
	# A data não é validada, assim o usuário pode fazer pesquisas parciais,
	# ou ainda usar expressões regulares, exemplo: 2011-0[123].
	if test -n "$data"
	then
		# Para facilitar a vida, alguns formatos comuns são mapeados
		# para o formato do moneylog. Assim, para pesquisar o mês
		# de janeiro do 2011, pode-se fazer: 2011-01 ou 1/2011.
		case "$data" in
			# m/aaaa -> aaaa-mm
			[1-9]/[12][0-9][0-9][0-9])
				data=$(zzdatafmt -f "AAAA-MM" 01/$data)
			;;
			# mm/aaaa -> aaaa-mm
			[01][0-9]/[12][0-9][0-9][0-9])
				data=$(zzdatafmt -f "AAAA-MM" 01/$data)
			;;
			# data com barras -> aaaa-mm-dd
			*/*)
				data=$(zzdatafmt -f "AAAA-MM-DD" $data)
			;;
			# apelidos especiais zzmoneylog
			ano)
				data=$(zzdatafmt -f "AAAA" hoje)
			;;
			mes | mês)
				data=$(zzdatafmt -f "AAAA-MM" hoje)
			;;
			dia)
				data=$(zzdatafmt -f "AAAA-MM-DD" hoje)
			;;
			# apelidos comuns: hoje, ontem, anteontem, etc
			[a-z]*)
				data=$(zzdatafmt -f "AAAA-MM-DD" $data)
			;;
		esac

		# Deu pau no case?
		if test $? -ne 0
		then
			echo "$data"  # Mensagem de erro
			return 1
		fi
	fi

	### VALOR
	# É necessário formatar um pouco o texto do usuário para a pesquisa
	# ficar mais poderosa, pois o formato do Moneylog é bem flexível.
	# Assim o usuário não precisa se preocupar com as pequenas diferenças.
	if test -n "$valor"
	then
		valor=$(echo "$valor" | sed '
			# Escapa o símbolo de recorrência: * vira [*]
			s|[*]|[*]|g

			# Remove espaços em branco
			s/ //g

			# Pesquisa vai funcionar com ambos separadores: . e ,
			s/,/[,.]/

			# É possível ter espaços após o sinal
			s/^[+-]/& */

			# O sinal de + é opcional
			s/^+/+*/

			# Busca por ,99 deve funcionar
			# Lembre-se que é possível haver espaços antes do valor
			s/^/[0-9 ,.+-]*/
		')
	fi

	# Começamos mostrando todos os dados, seja do arquivo HTML, do TXT
	# ou de vários TXT. Os IFs seguintes filtrarão estes dados conforme
	# as opções escolhidas pelo usuário.

	if test -d "$arquivo"
	then
		cat "$arquivo"/*.txt
	else
		cat "$arquivo" |
			# Remove código HTML, caso exista
			sed '/^<!DOCTYPE/,/<pre id="data">/ d'
	fi |

	# Remove linhas em branco.
	# Comentários são mantidos, pois podem ser úteis na pesquisa
	zzdos2unix | sed '/^[	 ]*$/ d' |

	# Filtro: data
	if test -n "$data"
	then
		grep "^[^	]*$data"
	else
		cat -
	fi |

	# Filtro: valor
	if test -n "$valor"
	then
		grep -i "^[^	]*	$valor"
	else
		cat -
	fi |

	# Filtro: tag
	if test -n "$tag"
	then
		grep -i "^[^	]*	[^	]*	[^|]*$tag[^|]*|"
	else
		cat -
	fi |

	# Filtro geral, aplicado na linha toda (default=.)
	grep -i "${*:-.}" |

	# Ordena o resultado por data
	sort -n |

	# Devo mostrar somente o total ou o resultado da busca?
	if test -n "$total"
	then
		cut -f 2 | zzcalcula --soma
	else
		cat -
	fi
}

# ----------------------------------------------------------------------------
# Conta o número de vezes que cada palavra aparece em um texto.
#
# Opções: -i       Trata maiúsculas e minúsculas como iguais, FOO = Foo = foo
#         -n NÚM   Mostra apenas as NÚM palavras mais frequentes
#
# Uso: zzcontapalavras [-i] [-n N] [arquivo(s)]
# Ex.: zzcontapalavras arquivo.txt
#      zzcontapalavras -i arquivo.txt
#      zzcontapalavras -i -n 10 /etc/passwd
#      cat arquivo.txt | zzcontapalavras
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-07
# Versão: 1
# Licença: GPL
# Requisitos: zzminusculas
# ----------------------------------------------------------------------------
zzcontapalavras ()
{
	zzzz -h contapalavras "$1" && return

	local ignore_case
	local tab=$(printf '\t')
	local limite='$'

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-i)
				ignore_case=1
				shift
			;;
			-n)
				limite="$2"
				shift
				shift
			;;
			*)
				break
			;;
		esac
	done

	# Arquivos via STDIN ou argumentos
	zztool file_stdin "$@" |

		# Remove caracteres que não são parte de palavras
		sed 's/[^A-Za-z0-9ÀàÁáÂâÃãÉéÊêÍíÓóÔôÕõÚúÇç_-]/ /g' |

		# Deixa uma palavra por linha, formando uma lista
		tr -s ' ' '\n' |

		# Converte tudo pra minúsculas?
		if test -n "$ignore_case"
		then
			zzminusculas
		else
			cat -
		fi |

		# Limpa a lista de palavras
		sed '
			# Remove linhas em branco
			/^$/d

			# Remove linhas somente com números e traços
			/^[0-9_-][0-9_-]*$/d
			' |

		# Faz a contagem com o uniq -c
		sort |
		uniq -c |

		# Ordena o resultado, primeiro vem a de maior contagem
		sort -n -r |

		# Temos limite no número de resultados?
		sed "$limite q" |

		# Formata o resultado para Número-Tab-Palavra
		sed "s/^[ $tab]*\([0-9]\{1,\}\)[ $tab]\{1,\}\(.*\)/\1$tab\2/"
}

# ----------------------------------------------------------------------------
# Parser simples (e limitado) para arquivos XML/HTML.
# Obs.: Este parser é usado pelas Funções ZZ, não serve como parser genérico.
# Obs.: Necessário pois não há ferramenta portável para lidar com XML no Unix.
#
# Opções: --tidy        Reorganiza o código, deixando uma tag por linha
#         --tag NOME    Extrai (grep) todas as tags NOME e seu conteúdo
#         --notag NOME  Exclui (grep -v) todas as tags NOME e seu conteúdo
#         --list        Lista sem repetição as tags existentes no arquivo
#         --indent      Promove a indentação das tags
#         --untag       Remove todas as tags, deixando apenas texto
#         --untag=NOME  Remove apenas a tag NOME, deixando o seu conteúdo
#         --unescape    Converte as entidades &foo; para caracteres normais
# Obs.: --notag tem precedência sobre --tag e --untag.
#       --untag tem precedência sobre --tag.
#
# Uso: zzxml <opções> [arquivo(s)]
# Ex.: zzxml --tidy arquivo.xml
#      zzxml --untag --unescape arq.xml                   # xml -> txt
#      zzxml --untag=item arq.xml                         # Apaga tags "item"
#      zzxml --tag title --untag --unescape arq.xml       # títulos
#      cat arq.xml | zzxml --tag item | zzxml --tag title # aninhado
#      zzxml --tag item --tag title arq.xml               # tags múltiplas
#      zzxml --notag link arq.xml                         # Sem tag e conteúdo
#      zzxml --indent arq.xml                             # tags indentadas
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-03
# Versão: 15
# Licença: GPL
# Requisitos: zzjuntalinhas zzuniq zzunescape
# ----------------------------------------------------------------------------
zzxml ()
{
	zzzz -h xml "$1" && return

	local tag notag semtag ntag sed_notag sep cache_tag cache_notag
	local tidy=0
	local untag=0
	local unescape=0
	local indent=0

	sep=$(echo '&thinsp;' | zzunescape --html)

	# Opções de linha de comando
	while test "${1#-}" != "$1"
	do
		case "$1" in
			--tidy    ) shift; tidy=1;;
			--untag   ) shift; untag=1;;
			--unescape) shift; unescape=1;;
			--notag   )
				tidy=1
				shift
				notag="$notag $1"
				shift
			;;
			--tag     )
				tidy=1
				shift
				tag="$tag $1"
				shift
			;;
			--untag=* )
				semtag="$semtag ${1#*=}"
				shift
			;;
			--indent  )
				shift
				tidy=1
				indent=1
			;;
			--list    )
				shift
				zztool file_stdin "$@" |
				# Eliminando comentários ( não deveria existir em arquivos xml! :-/ )
				zzjuntalinhas -i "<!--" -f "-->" | sed '/<!--/d' |
				# Filtrando apenas as tags válidas
				sed '
					# Eliminando texto entre tags
					s/\(>\)[^><]*\(<\)/\1\2/g
					# Eliminando texto antes das tags
					s/^[^<]*//g
					# Eliminado texto depois das tags
					s/[^>]*$//g
					# Eliminando as tags de fechamento
					s|</[^>]*>||g
					# Colocando uma tag por linha
					s/</\
&/g
					# Eliminando < e >
					s/<[?]*//g
					s|[/]*>||g
					# Eliminando os atributos das tags
					s/ .*//g' |
				sed '/^$/d' |
				zzuniq
				return
			;;
			--        ) shift; break;;
			--*       ) zztool erro "Opção inválida $1"; return 1;;
			*         ) break;;
		esac
	done

	cache_tag=$(zztool mktemp xml.tag)
	cache_notag=$(zztool mktemp xml.notag)

	# Montando script awk para excluir tags
	if test -n "$notag"
	then
		echo 'BEGIN { notag=0 } {' > $cache_notag
		for ntag in $notag
		do
			echo '
				if ($0 ~ /<'$ntag' [^>]*[^\/>]>/) { notag++ }
				if ($0 ~ /<\/'$ntag'  >/) { notag--; if (notag==0) { next } }
			' >> $cache_notag
			sed_notag="$sed_notag /<${ntag} [^>]*\/>/d;"
		done
		echo 'if (notag==0) { nolinha[NR] = $0 } }' >> $cache_notag
	fi

	# Montando script awk para selecionar tags
	if test -n "$tag"
	then
		echo 'BEGIN {' > $cache_tag
		for ntag in $tag
		do
			echo 'tag['$ntag']=0' >> $cache_tag
		done
		echo '} {' >> $cache_tag
		for ntag in $tag
		do
			echo '
				if ($0 ~ /^<'$ntag' [^>]*\/>$/) { linha[NR] = $0 }
				if ($0 ~ /^<'$ntag' [^>]*[^\/>]>/) { tag['$ntag']++ }
				if (tag['$ntag']>=1) { linha[NR] = $0 }
				if ($0 ~ /^<\/'$ntag'  >/) { tag['$ntag']-- }
			' >> $cache_tag
		done
		echo '}' >> $cache_tag
	fi

	# Montando script sed para apagar determinadas tags
	if test -n "$semtag"
	then
		for ntag in $semtag
		do
			sed_notag="$sed_notag s|<[/]\{0,1\}${ntag} [^>]*>||g;"
		done
	fi

	# Caso indent=1 mantém uma tag por linha para possibilitar indentação.
	if test -n "$tag"
	then
		if test $tidy -eq 0
		then
			echo 'END { for (lin=1;lin<=NR;lin++) { if (lin in linha) printf "%s", linha[lin] } print ""}' >> $cache_tag
		else
			echo 'END { for (lin=1;lin<=NR;lin++) { if (lin in linha) print linha[lin] } }' >> $cache_tag
		fi
	fi
	if test -n "$notag"
	then
		if test $tidy -eq 0
		then
			echo 'END { for (lin=1;lin<=NR;lin++) { if (lin in nolinha) printf "%s", nolinha[lin] } print ""}' >> $cache_notag
		else
			echo 'END { for (lin=1;lin<=NR;lin++) { if (lin in nolinha) print nolinha[lin] } }' >> $cache_notag
		fi
	fi

	# O código seguinte é um grande filtro, com diversos blocos de comando
	# IF interligados via pipe (logo após o FI). Cada IF pode aplicar um
	# filtro (sed, grep, etc) ao código XML, ou passá-lo adiante inalterado
	# (cat -). Por esta natureza, a ordem dos filtros importa. O tidy deve
	# ser sempre o primeiro, para organizar. O unescape deve ser o último,
	# pois ele pode fazer surgir < e > no código.
	#
	# Essa estrutura toda de IFs interligados é bizarra e não tenho certeza
	# se funciona em versões bem antigas do bash, mas acredito que sim. Fiz
	# assim para evitar ficar lendo e gravando arquivos temporários para
	# cada filtro. Como está, é tudo um grande fluxo de texto, que não usa
	# arquivos externos. Mas se esta função precisar crescer, todo este
	# esquema precisará ser revisto.

	# Arquivos via STDIN ou argumentos
	zztool file_stdin -- "$@" |

	zzjuntalinhas -i "<!--" -f "-->" |

		# --tidy
		if test $tidy -eq 1
		then
			# Deixa somente uma tag por linha.
			# Tags multilinha ficam em somente uma linha.
			# Várias tags em uma mesma linha ficam multilinha.
			# Isso facilita a extração de dados com grep, sed, awk...
			#
			#   ANTES                    DEPOIS
			#   --------------------------------------------------------
			#   <a                       <a href="foo.html" title="Foo">
			#   href="foo.html"
			#   title="Foo">
			#   --------------------------------------------------------
			#   <p>Foo <b>bar</b></p>    <p>
			#                            Foo 
			#                            <b>
			#                            bar
			#                            </b>
			#                            </p>

			# Usando um tipo especial de espaço com zzjuntalinhas
			zzjuntalinhas -d "$sep" |
			sed '
				:ini
				/>'$sep'*</ {
					s//>\
</
					t ini
				}

				# quebra linha na abertura da tag
				s/</\
</g
				# quebra linha após fechamento da tag
				s/ *>/  >\
/g' |
			# Rejunta o conteúdo do <![CDATA[...]]>, que pode ter tags
			zzjuntalinhas -i '^<!\[CDATA\[' -f ']]>$' -d '' |

			# Remove linhas em branco (as que adicionamos)
			sed "/^[[:blank:]$sep]*$/d"
		else
			# Espaço antes do fechamento da tag (Recurso usado no script para tag não ambígua)
			sed 's/ *>/  >/g'
		fi |

		# Corrigindo espaço de fechamento de tag única  (Recurso usado no script para tag não ambígua)
		sed 's|/  *>|  />|g' |

		# --notag
		# É sempre usada em conjunto com --tidy (automaticamente)
		if test -n "$notag"
		then
			awk -f "$cache_notag"
		else
			cat -
		fi |

		# --notag ou --notag <tag> ou untag=<tag>
		if test -n "$sed_notag"
		then
			sed "$sed_notag"
		else
			cat -
		fi |

		# --tag
		# É sempre usada em conjunto com --tidy (automaticamente)
		if test -n "$tag"
		then
			awk -f "$cache_tag"
		else
			cat -
		fi |

		# Eliminando o espaço adicional colocado antes do fechamento das tags.
		sed 's| *>|>|g;s|  */>| />|g' |

		# Removendo ou trocando um tipo de espaço especial usado com zzjuntalinhas
		sed "
			s/\([[:blank:]]\)$sep/\1/g
			s/$sep\([[:blank:]]\)/\1/g
			s/^$sep//
			s/$sep$//
			s/$sep/ /g
		" |

		# --indent
		# Indentando conforme as tags que aparecem, mantendo alinhamento.
		# É sempre usada em conjunto com --tidy (automaticamente)
		if test $indent -eq 1
		then
			sed '/^<[^/]/s@/@|@g' | sed 's@|>$@/>@g' |
			awk '
				# Para quantificar as tabulações em cada nível.
				function tabs(t,  saida, i) {
					saida = ""
					if (t>0) {
						for (i=1;i<=t;i++) {
							saida="	" saida
						}
					}
					return saida
				}
				BEGIN {
					# Definições iniciais
					ntab = 0
					tag_ini_regex = "^<[^?!/<>]*>$"
					tag_fim_regex = "^</[^/<>]*>$"
				}
				$0 ~ tag_fim_regex { ntab-- }
				{
					# Suprimindo espaços iniciais da linha
					sub(/^[\t ]+/,"")

					# Saindo com a linha formatada
					print tabs(ntab) $0
				}
				$0 ~ tag_ini_regex { ntab++ }
			' |
			sed '/^[[:blank:]]*<[^/]/s@|@/@g'
		else
			cat -
		fi |

		# --untag
		if test $untag -eq 1
		then
			sed '
				# Caso especial: <![CDATA[Foo bar.]]>
				s/<!\[CDATA\[//g
				s/]]>//g

				# Evita linhas vazias inúteis na saída
				/^[[:blank:]]*<[^>]*>[[:blank:]]*$/ d

				# Remove as tags inline
				s/<[^>]*>//g'
		else
			cat -
		fi |

		# --unescape
		if test $unescape -eq 1
		then
			zzunescape --xml
		else
			cat -
		fi

	# Limpeza
	rm -f "$cache_tag" "$cache_notag"
}

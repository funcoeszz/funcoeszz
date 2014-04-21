# ----------------------------------------------------------------------------
# Parser simples (e limitado) para arquivos XML/HTML.
# Obs.: Este parser é usado pelas Funções ZZ, não serve como parser genérico.
# Obs.: Necessário pois não há ferramenta portável para lidar com XML no Unix.
#
# Opções: --tidy        Reorganiza o código, deixando uma tag por linha
#         --tag <tag>   Extrai (grep) as tags
#         --notag <tag> Exclui essas tags (grep -v)
#         --list        Lista sem repetição as tags existentes no arquivo
#         --indent      Promove a indentação das tags
#         --untag       Remove todas as tags, deixando apenas texto
#         --untag=<tag> Remove apenas a tag especificada, deixando o texto
#         --unescape    Converte as entidades &foo; para caracteres normais
# Obs.: --notag tem precedência sobre --tag e --untag.
#       --untag tem precedência sobre --tag.
#
# Uso: zzxml [--tidy] [--tag NOME] [--notag NOME] [--list] [--indent] [--untag [NOME]] [--unescape] [arquivo(s)]
# Ex.: zzxml --tidy arquivo.xml
#      zzxml --untag --unescape arq.xml                    # xml -> txt
#      zzxml --untag=item arq.xml                          # Retira apenas as tags "item"
#      zzxml --tag title --untag --unescape arq.xml        # títulos
#      cat arq.xml | zzxml --tag item | zzxml --tag title  # aninhado
#      zzxml --tag item --tag title arq.xml                # tags múltiplas
#      zzxml --notag link arq.xml                          # Retira a tag link e o conteúdo
#      zzxml --indent arq.xml                              # tags indentadas
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-03
# Versão: 8
# Licença: GPL
# Requisitos: zzjuntalinhas zzuniq
# ----------------------------------------------------------------------------
zzxml ()
{
	zzzz -h xml "$1" && return

	local tag notag semtag ntag sed_notag
	local tidy=0
	local untag=0
	local unescape=0
	local indent=0
	local i=0
	local cache_tag="$ZZTMP.xml.${i}_tag"
	local cache_notag="$ZZTMP.xml.${i}_notag"

	while ! zztool arquivo_vago $cache_tag >/dev/null 2>&1
	do
		i=$((i + 1))
		cache_tag="$ZZTMP.xml.${i}_tag"
	done

	while ! zztool arquivo_vago $cache_notag >/dev/null 2>&1
	do
		i=$((i + 1))
		cache_notag="$ZZTMP.xml.${i}_notag"
	done

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
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
				tag="$tag $1";
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
			--*       ) echo "Opção inválida $1"; return 1;;
			*         ) break;;
		esac
	done

	# Montando script awk para excluir tags
	[ "$notag" ] && echo 'BEGIN { notag=0 } {' >> $cache_notag
	for ntag in $notag
	do
		echo '
			if ($0 ~ /<'$ntag'[^/>]* >/) { notag++}
			if (notag==0) print
			if ($0 ~ /<\/'$ntag' >/) { notag-- }
		' >> $cache_notag
		sed_notag="$sed_notag /<${ntag}[^/>]*\/>/d;"
	done
	[ "$notag" ] && echo '}' >> $cache_notag

	# Montando script awk para selecionar tags
	for ntag in $tag
	do
		echo 'BEGIN { tag['$ntag']=0 }' >> $cache_tag
	done
	[ "$tag" ] && echo '{' >> $cache_tag
	for ntag in $tag
	do
		echo '
			if ($0 ~ /^<'$ntag'[^><]*\/>$/) { linha[NR] = $0 }
			if ($0 ~ /^<'$ntag'[^><]*[^/><]+>/) { tag['$ntag']++ }
			if (tag['$ntag']>=1) { linha[NR] = $0 }
			if ($0 ~ /^<\/'$ntag' >/) { tag['$ntag']-- }
		' >> $cache_tag
	done
	[ "$tag" ] && echo '}' >> $cache_tag

	# Montando script sed para apagar determinadas tags
	for ntag in $semtag
	do
		sed_notag="$sed_notag s|<[/]\{0,1\}${ntag}[^>]*>||g;"
	done

	# Caso indent=1 mantém uma tag por linha para possibilitar indentação.
	[ "$tag" ] && test $tidy -eq 0 && echo ' END { for (lin=1;lin<=NR;lin++) { if (lin in linha) printf "%s", linha[lin] } print ""}' >> $cache_tag
	[ "$tag" ] && test $tidy -eq 1 && echo ' END { for (lin=1;lin<=NR;lin++) { if (lin in linha) print linha[lin] } }' >> $cache_tag

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
	zztool file_stdin "$@" |

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

			zzjuntalinhas -d ' ' |
			sed '
				# quebra linha na abertura da tag
				s/</\
</g
				# quebra linha após fechamento da tag
				s/>/ >\
/g' | sed 's|/ >|/>|g' |
			# Rejunta o conteúdo do <![CDATA[...]]>, que pode ter tags
			zzjuntalinhas -i '^<!\[CDATA\[' -f ']]>$' -d '' |

			# Remove linhas em branco (as que adicionamos)
			sed '/^[[:blank:]]*$/d'
		else
			cat -
		fi |

		# --notag
		# É sempre usada em conjunto com --tidy (automaticamente)
		if test -n "$notag"
		then
			awk-f "$cache_notag"
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

		# --tidy (segunda parte)
		# Eliminando o espaço adicional colocado antes do fechamento da tag.
		if test $tidy -eq 1
		then
			sed 's| >|>|g'
		else
			cat -
		fi |

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
			# Caso especial: <![CDATA[Foo bar.]]>
			sed 's/<!\[CDATA\[//g ; s/]]>//g ; s/<[^>]*>//g'
		else
			cat -
		fi |

		# --unescape
		if test $unescape -eq 1
		then
			sed "
				s/&quot;/\"/g
				s/&amp;/\&/g
				s/&apos;/'/g
				s/&lt;/</g
				s/&gt;/>/g
				"
		else
			cat -
		fi
}

# ----------------------------------------------------------------------------
# Leitor de Feeds RSS, RDF e Atom.
# Se informar a URL de um feed, são mostradas suas últimas notícias.
# Se informar a URL de um site, mostra a URL do(s) Feed(s).
# Obs.: Use a opção -n para limitar o número de resultados (Padrão é 10).
# Para uso via pipe digite dessa forma: "zzfeed -", mesma forma que o cat.
#
# Uso: zzfeed [-n número] URL...
# Ex.: zzfeed http://aurelio.net/feed/
#      zzfeed -n 5 aurelio.net/feed/          # O http:// é opcional
#      zzfeed aurelio.net funcoeszz.net       # Mostra URL dos feeds
#      cat arquivo.rss | zzfeed -             # Para uso via pipe
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-03
# Versão: 2
# Licença: GPL
# Requisitos: zzxml zzunescape
# ----------------------------------------------------------------------------
zzfeed ()
{
	zzzz -h feed "$1" && return

	local url formato tag_mae
	local limite=10
	local tmp="$ZZTMP.feed.$$"

	# Opções de linha de comando
	if test "$1" = '-n'
	then
		limite=$2
		shift
		shift
	fi

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso feed; return 1; }

	# Verificação básica
	if ! zztool testa_numero "$limite"
	then
		echo "Número inválido para a opção -n: $limite"
		return 1
	fi

	#-----------------------------------------------------------------
	# ATOM:
	# <?xml version="1.0" encoding="utf-8"?>
	# <feed xmlns="http://www.w3.org/2005/Atom">
	#     <title>Example Feed</title>
	#     <subtitle>A subtitle.</subtitle>
	#     <link href="http://example.org/" />
	#     ...
	#     <entry>
	#         <title>Atom-Powered Robots Run Amok</title>
	#         <link href="http://example.org/2003/12/13/atom03" />
	#         ...
	#     </entry>
	# </feed>
	#-----------------------------------------------------------------
	# RSS:
	# <?xml version="1.0" encoding="UTF-8" ?>
	# <rss version="2.0">
	# <channel>
	#     <title>RSS Title</title>
	#     <description>This is an example of an RSS feed</description>
	#     <link>http://www.someexamplerssdomain.com/main.html</link>
	#     ...
	#     <item>
	#         <title>Example entry</title>
	#         <link>http://www.wikipedia.org/</link>
	#         ...
	#     </item>
	# </channel>
	# </rss>
	#-----------------------------------------------------------------

	# Para cada URL que o usuário informou...
	for url
	do
		# Só mostra a url se houver mais de uma
		[ $# -gt 1 ] && zztool eco "* $url"

		# Baixa e limpa o conteúdo do feed
		if test "$1" = "-"
		then
			zztool file_stdin "$@"
		else
			$ZZWWWHTML "$url"
		fi |
		zzxml --tidy > "$tmp"

		# Tenta identificar o formato: <feed> é Atom, <rss> é RSS
		formato=$(grep -e '^<feed[ >]' -e '^<rss[ >]' -e '^<rdf[:>]' "$tmp")

		# Afinal, isso é um feed ou não?
		if test -n "$formato"
		then
			### É um feed, vamos mostrar as últimas notícias.
			# Atom ou RSS, as manchetes estão sempre na tag <title>,
			# que por sua vez está dentro de <item> ou <entry>.

			if zztool grep_var '<feed' "$formato"
			then
				tag_mae='entry'
			else
				tag_mae='item'
			fi

			# Extrai as tags <title> e formata o resultado
				zzxml --tag $tag_mae "$tmp" |
				zzxml --tag title |
				zzxml --tidy --untag |
				sed '/^[[:space:]]*$/d' | sed "$limite q" |
				zzunescape --html |
				zztool trim
		else
			### Não é um feed, pode ser um site normal.
			# Vamos tentar descobrir o endereço do(s) Feed(s).
			# <link rel="alternate" type="application/rss+xml" href="http://...">

			cat "$tmp" |
				grep -i \
					-e '^<link .*application/rss+xml' \
					-e '^<link .*application/rdf+xml' \
					-e '^<link .*application/atom+xml' |
				# Se não tiver href= não vale (o site do Terra é um exemplo)
				grep -i 'href=' |
				# Extrai a URL, apagando o que tem ao redor
				sed "
					s/.*[Hh][Rr][Ee][Ff]=//
					s/[ >].*//
					s/['\"]//g"
		fi

		rm -f "$tmp"

		# Linha em branco para separar resultados
		[ $# -gt 1 ] && echo

		# Tem mais de um site pra procurar?
		continue
	done
}

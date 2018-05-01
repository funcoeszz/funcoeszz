# ----------------------------------------------------------------------------
# Leitor de Feeds RSS, RDF e Atom.
# Se informar a URL de um feed, são mostradas suas últimas notícias.
# Se informar a URL de um site, mostra a URL do(s) Feed(s).
#
# Opções:
#  -n para limitar o número de resultados (Padrão é 10).
#  -u para simular navegador Mozilla/Firefox (alguns sites precisam disso).
#
# Para uso via pipe digite dessa forma: "zzfeed -", mesma forma que o cat.
#
# Uso: zzfeed [-n número] URL...
# Ex.: zzfeed http://aurelio.net/feed/
#      zzfeed -n 5 aurelio.net/feed/          # O http:// é opcional
#      zzfeed aurelio.net funcoeszz.net       # Mostra URL dos feeds
#      zzfeed -u funcoeszz.net                # UserAgent do lynx diferente
#      cat arquivo.rss | zzfeed -             # Para uso via pipe
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-03
# Versão: 11
# Licença: GPL
# Requisitos: zzxml zzunescape zztrim zzutf8
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzfeed ()
{
	zzzz -h feed "$1" && return

	local url formato tag_mae tmp useragent cache
	local limite=10

	# Opções de linha de comando
	while test "${1#-}" != "$1"
	do
		case "$1" in
		-n) limite=$2; shift ;;
		-u) useragent='-u "Mozilla/5.0"' ;;
		* ) break ;;
		esac
		shift
	done

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso feed; return 1; }

	# Verificação básica
	if ! zztool testa_numero "$limite"
	then
		zztool erro "Número inválido para a opção -n: $limite"
		return 1
	fi

	# Zero notícias? Tudo bem.
	test $limite -eq 0 && return 0

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

	tmp=$(zztool mktemp feed)
	cache=$(zztool mktemp feed)

	# Para cada URL que o usuário informou...
	for url
	do
		# Só mostra a url se houver mais de uma
		test $# -gt 1 && zztool eco "* $url"

		# Baixa e limpa o conteúdo do feed
		if test '-' = "$1"
		then
			cat - | zzutf8 | zzxml --tidy > "$tmp"
		else
			zztool download $useragent "$url" "$cache"
			zzutf8 "$cache" | zzxml --tidy > "$tmp"
		fi

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
				zzxml --tag title --untag |
				sed "$limite q" |
				zzunescape --html |
				zztrim
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

		# Linha em branco para separar resultados
		[ $# -gt 1 ] && echo
	done
	rm -f "$tmp" "$cache"
}

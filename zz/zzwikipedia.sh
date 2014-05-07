# ----------------------------------------------------------------------------
# http://www.wikipedia.org
# Procura na Wikipédia, a enciclopédia livre.
# Obs.: Se nenhum idioma for especificado, é utilizado o português.
#
# Idiomas: de (alemão)    eo (esperanto)  es (espanhol)  fr (francês)
#          it (italiano)  ja (japonês)    la (latin)     pt (português)
#
# Uso: zzwikipedia [-idioma] palavra(s)
# Ex.: zzwikipedia sed
#      zzwikipedia Linus Torvalds
#      zzwikipedia -pt Linus Torvalds
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2004-10-28
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
zzwikipedia ()
{
	zzzz -h wikipedia "$1" && return

	local url
	local idioma='pt'

	# Se o idioma foi informado, guarda-o, retirando o hífen
	if [ "${1#-}" != "$1" ]
	then
		idioma="${1#-}"
		shift
	fi

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso wikipedia; return 1; }

	# Faz a consulta e filtra o resultado, paginando
	url="http://$idioma.wikipedia.org/wiki/"
	$ZZWWWDUMP "$url$(echo "$*" | sed 's/  */_/g')" |
		sed '
			# Limpeza do conteúdo
			/^Views$/,$ d
			/^Vistas$/,$ d
			/^Ferramentas pessoais$/,$ d
			/^  *#Wikipedia (/d
			/^  *#alternat/d
			/Click here for more information.$/d
			/^  *#Editar Wikip.dia /d
			/^  *From Wikipedia,/d
			/^  *Origem: Wikipédia,/d
			/^  *Jump to: /d
			/^  *Ir para: /d
			/^  *This article does not cite any references/d
			/^  *Este artigo ou se(c)ção/d
			/^  *Please help improve this article/d
			/^  *Por favor, melhore este artigo/d
			/^  *Encontre fontes: /d
			/\.svg$/d
			/^  *Categorias* ocultas*:/,$d
			/^  *Hidden categories:/,$d
			/^  *Wikipedia does not have an article with this exact name./q
			s/\[edit\]//; s/\[edit[^]]*\]//
			s/\[editar\]//; s/\[editar[^]]*\]//

			# Guarda URL da página e mostra no final, após Categorias
			# Também adiciona linha em branco antes de Categorias
			/^   Obtid[ao] de "/ { H; d; }
			/^   Retrieved from "/ { H; d; }
			/^   Categor[a-z]*: / { G; x; s/.*//; G; }' |
		cat -s
}

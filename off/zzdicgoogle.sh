# ----------------------------------------------------------------------------
# http://www.google.com.br/language_tools
# Tradução de textos entre vários idiomas, feita pelo Google.
# As línguas são especificadas por um par de símbolos separados por '|'.
# O padrão é traduzir do Inglês para o Português (ou seja, "en|pt").
# Os pares disponíveis atualmente são:
#
#      en|de en|es en|fr en|it en|ja en|ko en|pt en|zh-CN
#      de|en de|fr es|en fr|en fr|de it|en ja|en ko|en pt|en zh-CN|en
#
# Uso: zzdicgoogle [línguas] texto
# Ex.: zzdicgoogle the book is on the table
#      zzdicgoogle 'fr|en' le livre est sur la table
#
# Autor: Rodrigo Bernardo Pimentel <rbp (a) isnomore net>
# Desde: 2003-12-20
# Versão: 3
# Licença: GPL
# Nota: Colaboração de Humberto Sartini <betinho_pg (a) yahoo com br>
# ----------------------------------------------------------------------------
# DESATIVADA: 2010-12-22 Filtro quebrado. Substituída pela zztradutor.
zzdicgoogle ()
{
	zzzz -h dicgoogle $1 && return

	[ "$1" ] || { zztool uso dicgoogle; return; }

	local URL='http://translate.google.com/translate_t'
	local P='en|pt'
	[ "${#1}" = "5" ] && [ "${1/|/}" != "$1" ] && P="$1" && shift

	local TXT=$(echo "$*"| sed "$ZZSEDURL")
	local INI='^.*<textarea name=q [^>]*>'
	local FIM='<\/textarea>.*$'

	$ZZWWWHTML "$URL?text=$TXT&langpair=$P&ie=UTF-8" |
		sed -n "s/$INI\([^<]*\)$FIM/\1/p"
	echo " ";
}

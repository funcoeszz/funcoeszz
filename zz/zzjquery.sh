# ----------------------------------------------------------------------------
# Exibe a descrição da função JQuery informada.
# Caso não seja passado o nome, serão exibidas informações acerca do $().
# Se usado o argumento -s, será exibida somente a sintaxe.
# Uso: zzjquery [-s] funcao
# Ex.: zzjquery gt
#      zzjquery -s gt
#
# Autor: Felipe Nascimento Silva Pena <felipensp (a) gmail com>
# Desde: 2007-12-04
# Versão: 2
# Licença: GPL
# Requisitos: GNU sed
# ----------------------------------------------------------------------------
zzjquery ()
{
	zzzz -h jquery "$1" && return

	local er
	local cache="$ZZTMP.jquery"
	local er1="s/^ *<h1>\([\$.]*$2(.*\)<\/h1> */- \1/p;"
	local er2="
		/\s*<h1>\([\$.]*$1(.*\)<\/h1>/ {
			s//\1:/p
			n
			s/\s*<p>\|<\/p>/ /g
			p
			n
			:a
			/<\/\?p>\|<h2>/! {
				s/^\s*/  /g
				p
				n
				ba
			}
		}"

	[ "$1" = '-s' ] && er="$er1" || er="$er2"

	# Se o cache está vazio, baixa o conteúdo
	if ! test -s "$cache"
	then
		$ZZWWWHTML "http://visualjquery.com/1.1.2.html" > "$cache"
	fi

	# Faz a pesquisa e filtra o resultado
	sed -n "$er" "$cache"
}

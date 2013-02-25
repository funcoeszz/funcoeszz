# ----------------------------------------------------------------------------
# http://babelfish.altavista.digital.com
# Faz traduções de palavras/frases/textos entre idiomas.
# Basta especificar quais os idiomas de origem e destino e a frase.
# Obs.: Se os idiomas forem omitidos, a tradução será inglês -> português.
#
# Idiomas: pt_en pt_fr es_en es_fr it_en it_fr de_en de_fr
#          fr_en fr_de fr_el fr_it fr_pt fr_nl fr_es
#          ja_en ko_en zh_en zt_en el_en el_fr nl_en nl_fr ru_en
#          en_zh en_zt en_nl en_fr en_de en_el en_it en_ja
#          en_ko en_pt en_ru en_es
#
# Uso: zzdicbabelfish [idiomas] palavra(s)
# Ex.: zzdicbabelfish my dog is green
#      zzdicbabelfish pt_en falcão é massa
#      zzdicbabelfish en_de my hovercraft if full of eels
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-02-22
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2013-02-22 O Babelfish, virou Yahoo, depois Bing. zzdicbing?
zzdicbabelfish ()
{
	zzzz -h dicbabelfish "$1" && return

	local padrao
	local url='http://babelfish.yahoo.com/translate_txt'
	local extra='ei=UTF-8&eo=UTF-8&doit=done&fr=bf-home&intl=1&tt=urltext'
	local lang=en_pt

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso dicbabelfish; return 1; }

	if [ "${1#[a-z][a-z]_[a-z][a-z]}" = '' ]
	then
		lang=$1
		shift
	elif [ "$1" = 'i' ]
	then
		lang=pt_en
		shift
	fi

	padrao=$(echo "$*" | sed "$ZZSEDURL")
	$ZZWWWHTML "$url?$extra&trtext=$padrao&lp=$lang" |
		sed -n '
			/<div id="result">/ {
				s/<[^>]*>//g
				s/^ *//p
			}'
}

# ----------------------------------------------------------------------------
# Da uma desculpa comum de desenvolvedor ( em ingles ).
# Com a opção -t ou --traduzir mostra as desculpas traduzidas.
#
# Uso: zzexcuse [-t|--traduzir]
# Ex.: zzexcuse
#
# Autor: Italo Gonçales, @goncalesi, <italo.goncales (a) gmail com>
# Desde: 2015-09-26
# Versão: 2
# Licença: GPL
# Requisitos: zztrim zztradutor
# Tags: internet, diversão
# ----------------------------------------------------------------------------
zzexcuse ()
{
	zzzz -h excuse "$1" && return

	local url='http://programmingexcuses.com/'

	zztool dump "$url" |
	sed '$d;/Link: /d' |
	zztrim |
	case $1 in
	-t | --traduzir ) zztradutor en-pt ;;
	*) cat - ;;
	esac
}

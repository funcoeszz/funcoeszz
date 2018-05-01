# ----------------------------------------------------------------------------
# Exibe aleatoriamente uma frase do Sheldon, do seriado The Big Bang Theory.
# Com a opção -t ou --traduzir mostra os diálogos traduzidos.
#
# Uso: zzsheldon [-t|--traduzir]
# Ex.: zzsheldon
#
# Autor: Jonas Gentina, <jgentina (a) gmail com>
# Desde: 2015-09-25
# Versão: 2
# Licença: GPL
# Requisitos: zzaleatorio zztrim zzjuntalinhas zzlinha zztradutor zzsqueeze zzxml zzutf8
# Tags: internet, distação
# ----------------------------------------------------------------------------
zzsheldon ()
{
	zzzz -h sheldon "$1" && return

	# Declaracoes locais:
	local url="http://the-big-bang-theory.com/quotes/character/Sheldon/"
	local begin="Quote from the episode"
	local end="Correct this quote"

	zztool source ${url}$(zzaleatorio 211) |
	zzutf8 |
	sed 's/Correct this quote/<p>Correct this quote<\/p>/g' |
	zzxml --tag p |
	zzjuntalinhas -i '<p' -f '<.p>' -d ' ' |
	sed 's/<br \/>/|/g' |
	zzxml --untag |
	zzsqueeze |
	sed -n "/$begin/,/$end/p" |
	zztrim -H |
	zzjuntalinhas -i "$begin" -f "$end" -d "|" |
	zzlinha |
	tr '|' '\n' |
	sed "/$end/d;s/$begin/Episode -/;/^[[:blank:]]*$/d" |
	case $1 in
		-t | --traduzir ) zztradutor en-pt ;;
		*) cat - ;;
		esac |
	zztrim -H |
	sed "2,$ { /:/!s/^/	/; s/: /:	/; }" |
	expand -t 10
}

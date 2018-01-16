# ----------------------------------------------------------------------------
# Mostra a programação da Rede Globo do dia.
# Uso: zzglobo
# Ex.: zzglobo
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2017-11-29
# Versão: 8
# Licença: GPL
# Requisitos: zztrim
# ----------------------------------------------------------------------------
zzglobo ()
{
		zzzz -h globo "$1" && return

		local url="http://redeglobo.globo.com/programacao.html"

		zztool dump -i utf-8 "$url" |
				sed '/^$/d' |
				sed -n '/\(Seg\|Ter\|Qua\|Qui\|Sex\|Sab\|Dom\),/p' |
				zztrim
		echo
		zztool dump -i utf-8 "$url" |
				sed '/^$/d' |
				sed 'H;/[0-9][0-9]:[0-9][0-9]/{g;N;s/^\n//p;}; x;s/.*\(\(\n[^\n]*\)\{1\}\)/\1/;x ;d' |
				sed '/No ar/d' |
				sed 's/ *\([0-9][0-9]:[0-9][0-9]\)/\1\:/' |
				sed 'N;s/:\n/: /' |
				zztrim
}

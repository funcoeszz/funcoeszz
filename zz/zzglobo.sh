# ----------------------------------------------------------------------------
# Mostra a programação Rede Globo do dia.
# Uso: zzglobo
# Ex.: zzglobo
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2007-11-30
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
zzglobo ()
{
	zzzz -h globo "$1" && return

	local DATA=`date +%d | sed 's/^0//'`
	local URL="http://diversao.terra.com.br/tv/noticias/0,,OI3512347-EI13439,00-Programacao+da+TV+Globo.html"

	$ZZWWWDUMP "$URL" |
		sed -n "/[Segunda|Terça|Quarta|Quinta|Sexta|Sábado|Domingo], $DATA de /,/[Segunda|Terça|Quarta|Quinta|Sexta|Sábado|Domingo], .*/p" | sed '$d' |
		uniq
}

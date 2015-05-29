# ----------------------------------------------------------------------------
# Mostra a programação da Rede Globo do dia.
# Uso: zzglobo
# Ex.: zzglobo
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2007-11-30
# Versão: 4
# Licença: GPL
# ----------------------------------------------------------------------------
zzglobo ()
{
	zzzz -h globo "$1" && return
	
	local DATA=`date +%d | sed 's/^0//'`
	local URL="http://vejonatv.com.br/programacao/globo-rede.html"
	
	$ZZWWWDUMP "$URL" |
		sed -n "/Hoje \[[0-9]*\-[0-9]*\-[0-9]*\]/,/Amanhã .*/p" | sed '$d' |
		uniq
}

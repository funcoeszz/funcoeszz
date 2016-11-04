# ----------------------------------------------------------------------------
# Mostra a programação da Rede Globo do dia.
# Uso: zzglobo
# Ex.: zzglobo
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2007-11-30
# Versão: 7
# Licença: GPL
# Requisitos: zztrim
# ----------------------------------------------------------------------------
zzglobo ()
{
	zzzz -h globo "$1" && return

	local url="http://vejonatv.com.br/programacao/globo-rede.html"

	zztool dump -i utf-8 "$url" |
		sed -n '/Hoje \[[0-9]*[\/-][0-9]*[\/-][0-9]*\]/,/Amanhã .*/p' |
		sed '$d ; 3,$ { /^ *$/ d; }; /Carregando\.\.\./d; /loading\.\.\./d; /\[IMG\]/d' |
		uniq |
		zztrim
}

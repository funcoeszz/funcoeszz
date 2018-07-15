# ----------------------------------------------------------------------------
# http://pt.wikipedia.org/wiki/Lista_de_portas_de_protocolos
# Mostra uma lista das portas de protocolos usados na internet.
# Se houver um número como argumento, a listagem é filtrada pelo mesmo.
#
# Uso: zzporta [porta]
# Ex.: zzporta
#      zzporta 513
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2014-11-15
# Versão: 2
# Licença: GPL
# Requisitos: zzjuntalinhas
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzporta ()
{
	zzzz -h porta "$1" && return

	local url="https://pt.wikipedia.org/wiki/Lista_de_portas_de_protocolos"
	local port=$1
	zztool testa_numero $port || port='.'

	zztool source "$url" |
	awk '/"wikitable"/,/<\/table>/ { sub (/ bgcolor.*>/,">");sub(/<.?tbody>/,""); print }' |
	zzjuntalinhas -d '' -i '<tr>' -f '</tr>' |
	awk -F '</?t[^>]+>' 'BEGIN {OFS="\t"}{ print $3, $5 }' |
	expand -t 18 |
	sed '
		1d
		# Retira os links
		s/<[^>]*>//g
		3,${
			/^Porta/d
			/^[[:blank:]]*$/d
			/\/IP /d
		}' |
	awk 'NR==1;NR>1 && /'$port'/'
}

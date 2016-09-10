# ----------------------------------------------------------------------------
# http://www.ucicinemas.com.br
# Exibe a programação dos cinemas UCI de sua cidade.
# Se não for passado nenhum parâmetro, são listadas as cidades e cinemas.
# Uso: zzcineuci [cidade | codigo_cinema]
# Ex.: zzcineuci recife
#      zzcineuci 14
#
# Autor: Rodrigo Pereira da Cunha <rodrigopc (a) gmail.com>
# Desde: 2009-05-04
# Versão: 9
# Licença: GPL
# Requisitos: zzunescape zztrim zzcolunar
# Tags: cinema
# ----------------------------------------------------------------------------
zzcineuci ()
{
	zzzz -h cineuci "$1" && return

	local cache=$(zztool cache cineuci)
	local cinema codigo
	local url="http://www.ucicinemas.com.br"

	if test "$1" = '--atualiza'
	then
		zztool atualiza cineuci
		shift
	fi

	# Cidades e código cinemas e cinemas
	if ! test -s "$cache"
	then
		zztool source "${url}/cinemas" |
		sed -n '
			1,/<content>/d
			/class="cinemas / { s/.*_//;s/".*//;n; p; }
			/Avatar/ { s|.*Avatar/||; s|/Avatar\..*||; p; }
			/strong/,/strong/ { /strong/d; p; }
			/<\/content>/q
		' |
		zzunescape --html |
		zztrim |
		awk '{ if ($0 ~/^[0-9]+$/) {cod=sprintf("%02d",$0);getline; print " " cod " - " $0} else print "\n" $0}' |
		zztrim -V > "$cache"
	fi

	if test $# = 0
	then
		# mostra opções
		printf "       Cidades e cinemas disponíveis\n============================================\n"
		cat "$cache"
	elif zztool testa_numero "$1"
	then
		codigo=$(sed 's/^[ 0]*//' "$cache" | grep -o --color=never "^$1 " | tr -d ' ')
		cinema=$(sed 's/^[ 0]*//' "$cache" | grep --color=never "^$1 " | sed 's/.* - //' | zztrim)
		if test -n "$codigo"
		then
			zztool eco "$cinema"
			zztool source "${url}/api/Filmes/ListarFilmes/cinemas/${codigo}" |
			tr '[{}],' '\n\n\n\n\n' |
			sed -n '/"NomeDestaque":/p; /"Duracao":/,/"Censura":/p' |
			sed 's/.*":"//;s/"//' |
			awk 'BEGIN { printf "Filme\nDuração(min)\nGênero\nCensura\n" }; 1' |
			zzcolunar -z 4 |
			zztrim
		fi
	fi
}

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
# Versão: 8
# Licença: GPL
# Requisitos: zzminusculas zzsemacento zzxml zzcapitalize zzjuntalinhas zztrim
# Tags: cinema
# ----------------------------------------------------------------------------
zzcineuci ()
{
	zzzz -h cineuci "$1" && return

	local cache=$(zztool cache cineuci)
	local cidade codigo codigos
	local url="http://www.ucicinemas.com.br/controles/listaFilmeCinemaHome.aspx?cinemaID="

	if test "$1" = '--atualiza'
	then
		zztool atualiza cineuci
		shift
	fi

	if ! test -s "$cache"
	then
		$ZZWWWHTML "http://www.ucicinemas.com.br/localizacao+e+precos" |
		zzxml --tidy |
		sed -n "/\(class=.heading-bg.\|class=.btn-holder.\)/{n;p;}" |
		sed '
			s/.*cinema-/ /
			s/uci/UCI/
			s/-/) /
			s/.>//
			s/+/ /g
			s/ \([1-9]\))/ 0\1)/
			s/^\([A-Z]\)\(.*\)$/\
\1\2:/' |
		zzcapitalize > "$cache"
	fi

	if test $# = 0; then
		# mostra opções
		printf "Cidades e cinemas disponíveis\n=============================\n"
		cat "$cache"
		return 0
	fi

	cidade=$(echo "$*" | zzsemacento | zzminusculas | zztrim | sed 's/ 0/ /g;s/  */_/g')

	codigo=$(
		cat "$cache" |
		while read linha
		do
			echo "$linha" | grep ':$' >/dev/null &&
			echo "$linha" | zzminusculas | zzsemacento | tr ' ' '_' ||
			echo "$linha" | sed 's/).*//'
		done
		)

	# passou código
	if zztool testa_numero ${cidade}; then
		# testa se código é válido
		cidade=$(printf "%02d" $cidade)
		echo "$codigo" | grep "$cidade" >/dev/null && codigos="$cidade"
	else
		# passou nome da cidade
		codigos=$(
			echo "$codigo" |
			sed -n "/${cidade}:/,/^$/{/:/d;p;}" |
			zzjuntalinhas
			)
	fi

	# se não recebeu cidade ou código válido, sai
	test -z "$codigos" && return 1

	for codigo in $codigos
	do
		$ZZWWWDUMP "$url$codigo" | sed '

			# Faxina
			s/^  *//
			/^$/ d
			/^Horários para/ d

			# Destaque ao redor do nome do cinema, quebra linha após
			1 i\
=================================================
			1 a\
=================================================\


			# Quebra linha após o horário
			/^Sala / G
		'
	done
}

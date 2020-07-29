# ----------------------------------------------------------------------------
# http://www.cinepolis.com.br/
# Exibe a programação dos cinemas Cinepólis de sua cidade.
# Se não for passado nenhum parâmetro, são listadas as cidades e cinemas.
# Uso: zzcinepolis [cidade | codigo_cinema]
# Ex.: zzcinepolis barueri
#      zzcinepolis 36
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2015-02-22
# Versão: 3
# Licença: GPL
# Requisitos: zzdatafmt zzjuntalinhas zzlimpalixo zzminusculas zzpad zzsemacento zzsqueeze zztrim zzunescape zzutf8 zzxml
# Tags: cinema
# ----------------------------------------------------------------------------
# DESATIVADA: 2018-01-09 Site usando AJAX.
zzcinepolis ()
{
	zzzz -h cinepolis "$1" && return

	local cache=$(zztool cache cinepolis)
	local url='http://www.cinepolis.com.br/programacao'
	local hoje=$(zzdatafmt --iso hoje)
	local cidade codigo codigos linha sala filme censura horario

	if test "$1" = '--atualiza'
	then
		zztool atualiza cinepolis
		shift
	fi

	# Especificando User Agent na opçãp -u "Mozilla/5.0"
	if ! test -s "$cache"
	then
		zztool source -u "Mozilla/5.0" "$url" 2>/dev/null |
		awk '/class="amarelo"/;/\?cc=/' |
		zzutf8 |
		sed '/img /d;/>Estreias</d;s/.*"amarelo">//;s/.*cc=/ /;s/".*">/) /' |
		sed 's/<[^>]*>//' |
		sed 's/^\([A-Z]\)\(.*\)$/\
\1\2:/' > $cache
	fi

	if test $# = 0; then
		# mostra opções
		zztool eco "Cidades e cinemas disponíveis:"
		cat $cache |
		tr -s ' ' |
		sed '/^[A-Z]/ h; /^ [0-9]/ { G; s/\(.*\)\n\(.*\)/\2\1/; }' |
		grep ': ' |
		sed 's/Cinépolis // ; s/: \([0-9][0-9]*\)) \(.*\)/ - \2 - \1/'
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
	if zztool testa_numero ${cidade}
	then
		# testa se código é válido
		echo "$codigo" | grep -w "$cidade" >/dev/null && codigos="$cidade"
	else
		# passou nome da cidade
		codigos=$(
			echo "$codigo" |
			sed -n "/${cidade}.*:$/,/^$/{/:/d;p;}" |
			zzjuntalinhas
			)
	fi

	# se não recebeu cidade ou código válido, sai
	test -z "$codigos" && { zztool -e uso cinepolis; return 1; }

	for codigo in $codigos
	do
		zztool eco $(grep " ${codigo})" $cache | sed 's/.*) //')
		zzdatafmt -f 'DD/MM' hoje
		claquete=$(zztool source "${url}/cinema.php?cc=$codigo" | sed -n "/cod_claquete/{s/.* '//;s/'.*//;p;q;}")
		zztool post links "${url}/ajax/ajax.conteudo_horarios.php" "cod_horario=${hoje}&cod_cinema=${codigo}&cod_claquete=${claquete}" |
		zzutf8 |
		sed -n '/"myTable1"/,/<\/table>/p' |
		zztrim |
		zzxml --tidy |
		zzlimpalixo --html |
		zzjuntalinhas -i '<tr' -f '</tr>' -d '' |
		zzunescape --html |
		sed '
			s/<t[dh][^>]*>/|/g
			s/<span [^>]*aria-label="Livre">/Livre /
			s/<span [^>]*aria-label="Legendado">/Legendado /
			s/<span [^>]*aria-label="Dublado">/Dublado /
			s/<span [^>]*aria-label="\([0-9]\{1,\} anos\)">/\1 /
			s/:[0-5][0-9]/& /g
		' |
		zzxml --untag |
		zztrim |
		zzsqueeze |
		sed -n '
			/^ *[|] *$/d
			s/^ *[|] *//
			s/ *[|] *$//
			s/ *[|] */ | /g
			p
		' |
		while read linha
		do
			if zztool grep_var '|' "$linha"
			then
				sala=$(   echo "$linha" | cut -f 1 -d '|')
				filme=$(  echo "$linha" | cut -f 2 -d '|')
				censura=$(echo "$linha" | cut -f 3 -d '|')
				censura=$(echo "$censura" | sed 's/^ *$/ NC/')
				horario=$(echo "$linha" | cut -f 4,5 -d '|' | sed 's/ [|] //')
				echo "$(zzpad -b 5 "$sala") $(zzpad 50 "$filme") $(zzpad 10 "$censura") $horario"
			else
				echo "$linha"
			fi
		done
	done
}

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
# Versão: 2
# Licença: GPL
# Requisitos: zzcolunar zzjuntalinhas zzlimpalixo zzminusculas zzpad zzsemacento zzsqueeze zztrim zzunescape zzutf8 zzxml
# Tags: cinema
# ----------------------------------------------------------------------------
zzcinepolis ()
{
	zzzz -h cinepolis "$1" && return

	local cache=$(zztool cache cinepolis)
	local url='http://www.cinepolis.com.br/programacao'
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
		zzcolunar 2 $cache
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
		echo "$codigo" | grep "$cidade" >/dev/null && codigos="$cidade"
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
		zztool source -o "ISO-8859-1" -u "Mozilla/5.0" "${url}/cinema.php?cc=$codigo" 2>/dev/null  |
		zztool texto_em_iso |
		sed -n '/tabNavigation/,/<\/ul>/p;/tabelahorario/,/<\/table>/p' |
		zztrim |
		zzxml --tidy |
		zzlimpalixo --html |
		zzxml --tag tr --tag span |
		zzjuntalinhas -i '<tr' -f '</tr>' -d ' ' |
		zzjuntalinhas -i '<span' -f '</span>' -d ' ' |
		zzunescape --html |
		sed '
			s/<td[^>]*>/|/g
			s/<span [^>]*aria-label="Livre">/Livre/
			s/<span [^>]*aria-label="Legendado">/Legendado/
			s/<span [^>]*aria-label="Dublado">/Dublado/
			s/<span [^>]*aria-label="\([0-9]\{1,\} anos\)">/\1/
		' |
		zzxml --untag |
		zztrim |
		zzsqueeze |
		sed -n '
			/ *[|] *Tweet  */,$d
			2,/sala / {
				/sala /!d
				s/  */|/g
			}
			s/^ *[|] *//
			s/ *[|] *$//
			s/ *[|] */|/g
			p
		' |
		zztool nl_eof |
		while read linha
		do
			if zztool grep_var '|' "$linha"
			then
				sala=$(   echo "$linha" | cut -f 1 -d '|')
				filme=$(  echo "$linha" | cut -f 2 -d '|')
				censura=$(echo "$linha" | cut -f 3 -d '|')
				horario=$(echo "$linha" | zzcut -f 4,5 -d '|')
				echo "$(zzpad -b 5 "$sala") $(zzpad 50 "$filme") $(zzpad 10 "$censura") $horario"
			else
				echo "$linha"
			fi
		done
	done
}

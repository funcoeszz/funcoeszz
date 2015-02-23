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
# Versão: 1
# Licença: GPL
# Requisitos: zzminusculas zzsemacento zzjuntalinhas zzcolunar
# ----------------------------------------------------------------------------
zzcinepolis ()
{
	zzzz -h cinepolis "$1" && return

	local cache=$(zztool cache cinepolis)
	local url='http://www.cinepolis.com.br/programacao'
	local cidade codigo codigos

	if test "$1" = '--atualiza'
	then
		zztool atualiza cinepolis
		shift
	fi

	# Necessário fazer uso do argumento -useragent="Mozilla/5.0", pois o site se recusa a funcionar com lynx, links, curl e w3m.
	# Uma ridícula implementação do site :( ( Desculpe pelo protesto, de novo! )
	if ! test -s "$cache"
	then
		$ZZWWWHTML -useragent="Mozilla/5.0" "$url" 2>/dev/null |
		grep -E '(class="amarelo"|\?cc=)' |
		if test $ZZUTF -eq 1
		then
			zztool texto_em_iso
		else
			cat -
		fi |
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

	cidade=$(zzsemacento "$*" | zzminusculas | zztool trim | sed 's/ 0/ /g;s/  */_/g')

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
	test -z "$codigos" && { zztool uso cinepolis; return 1; }

	for codigo in $codigos
	do
		zzecho -N -l ciano $(grep " ${codigo})" $cache | sed 's/.*) //')
		$ZZWWWDUMP -useragent="Mozilla/5.0" "${url}/cinema.php?cc=${codigo}" 2>/dev/null |
		sed -n '/  [0-9]\{1,2\}  /p;/[0-9]h[0-9]/p' |
		sed 's/\(.*h[0-9][0-9]\).*/\1/;/OBS\.: /d' |
		sed 's/^ *[0-9 ]* *   //' |
		awk '{print}; NR%2==0 {print ""}'
	done  | sed '$d'
}

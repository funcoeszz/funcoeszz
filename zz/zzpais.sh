# ----------------------------------------------------------------------------
# Lista os países.
# Opções:
#  -a: Todos os países
#  -i: Informa o(s) idioma(s)
#  -o: Exibe o nome do país e capital no idioma nativo
# Outra opção qualquer é usado como filtro para pesquisar entre os países.
# Obs.: Sem argumentos, mostra um país qualquer.
#
# Uso: zzpais [palavra|regex]
# Ex.: zzpais              # mostra um pais qualquer
#      zzpais unidos       # mostra os países com "unidos" no nome
#      zzpais -o nova      # mostra o nome original de países com "nova".
#      zzpais ^Z           # mostra os países que começam com Z
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-29
# Versão: 4
# Licença: GPL
# Requisitos: zzlinha zzpad
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzpais ()
{
	zzzz -h pais "$1" && return

	local url='https://pt.wikipedia.org/wiki/Lista_de_países_e_capitais_em_línguas_locais'
	local cache=$(zztool cache pais)
	local original=0
	local idioma=0
	local padrao linha field1 field2

	# Se o cache está vazio, baixa-o da Internet
	if ! test -s "$cache"
	then
		zztool source "$url" |
		sed -n '/class="wikitable"/,/<\/table>/p' |
		sed '/<th/d;s|</td>|:|g;s|</tr>|--n--|g;s|<br */*>|, |g;s/<[^>]*>//g;s/([^)]*)//g;s/\[.\]//g' |
		awk '{
			gsub(/--n--/,"\n")
			printf "%s", $0
		}' |
		sed '
			s/, *:/:/g
			s/^ *//g
			s/ *, *,/,/g
			s/ *$//g
			s/[,:] *$//g
			s/ ,/,/g
			/Taiuã:/d
			/^ *$/d
		' > "$cache"
	fi

	while test "${1#-}" != "$1"
	do
		case "$1" in
			# Mostra idioma
			-i) idioma=1; shift;;
			# Mostra nome e capital do país no idioma nativo
			-o) original=1; shift;;
			# Lista todos os países
			-a) padrao='.'; shift;;
			*) break;;
		esac
	done

	test "${#padrao}" -eq 0 && padrao="$*"
	if test -z "$padrao"
	then
		# Mostra um país qualquer
		zzlinha -t . "$cache" |
		awk -v idioma_awk="$idioma" -v original_awk="$original" '
			BEGIN {
				FS=":"
				if (original_awk == 0) {
					printf "%s|%s\n", "País", "Capital"
					print "------------------------------------------|----------------------------------"
				}
			}
			{
			if (original_awk == 0) { printf "%s|%s\n", $1, $2 }
			else {
				print "País     : " $3
				print "Capital  : " $4
			}
			if (idioma_awk == 1) { print "Idioma(s):", $5 }
			}'
	else
		# Faz uma busca nos países
		padrao=$(echo $padrao | sed 's/\$$/:.*:.*:.*:.*\$/')
		padrao=$(echo $padrao | sed 's/[^$]$/&.*:.*:.*:.*:.*/')
		grep -h -i -- "$padrao" "$cache" |
		awk -v idioma_awk="$idioma" -v original_awk="$original" '
			BEGIN {FS=":"}
			{	if (NR==1 && original_awk == 0) {
					printf "%s|%s\n", "País", "Capital"
					print "------------------------------------------|----------------------------------"
				}
				if (original_awk == 0) { printf "%s|%s\n", $1, $2 }
				else {
					print "País     : " $3
					print "Capital  : " $4
				}
				if (idioma_awk == 1) { print "Idioma(s):", $5 }
				if (idioma_awk == 1 || original_awk == 1) print ""
			}'
	fi |
	sed 's/ *| */|/g' |
	while read linha
	do
		if zztool grep_var "|" "$linha"
		then
			field1=$(echo "$linha" | cut -f1 -d '|')
			field2=$(echo "$linha" | cut -f2 -d '|')
			echo "$(zzpad 42 $field1) $field2"
		else
			echo "$linha"
			unset field1
			unset field2
		fi
	done |
	sed 's/  *$//; s/\([:,]\)  */\1 /g'
}

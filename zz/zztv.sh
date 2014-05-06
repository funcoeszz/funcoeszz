# ----------------------------------------------------------------------------
# Mostra a programação da TV, diária ou semanal, com escolha de emissora.
#
# Opções:
#  canais - lista os canais com seus códigos para consulta.
#
#  <código canal> - Programação do canal escolhido.
#  Obs.: Se for seguido de "semana" ou "s" mostra toda programação semanal.
#
#  cod <número> - mostra um resumo do programa.
#   Obs: número obtido pelas listagens da programação do canal consultado.
#
# Programação corrente:
#  doc ou documentario, esportes ou futebol, filmes, infantil, variedades
#  series ou seriados, aberta, todos ou agora (padrão).
#
# Uso: zztv <codigo canal> [semana|s]  ou  zztv cod <numero>
# Ex.: zztv CUL          # Programação da TV Cultura
#      zztv cod 3235238
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2002-02-19
# Versão: 11
# Licença: GPL
# Requisitos: zzunescape zzdos2unix zzcolunar
# ----------------------------------------------------------------------------
zztv ()
{
	zzzz -h tv "$1" && return

	local DATA=$(date +%d\\/%m)
	local URL="http://meuguia.tv/programacao"
	local cache="$ZZTMP.tv"
	local codigo desc linhas largura

	# 0 = lista canal especifico
	# 1 = lista programas de vários canais no horário
	local flag=0

	if ! test -s "$cache"
	then
		$ZZWWWHTML ${URL}/categoria/Todos |
		sed -n '/programacao\/canal/p;/^ *|/p' |
		awk -F '("| [|] )' '{print $2, $6 }' |
		sed 's/<[^>]*>//g;s|^.*/||' |
		zzdos2unix |
		sort >> $cache
	fi
	linhas=$(echo "scale=0; ($(zztool num_linhas $cache) + 1)/ 4 " | bc)
	largura=$(awk '{print length}' $cache | sort -n | sed -n '$p')

	if [ "$1" ] && grep -i "^$1" $cache >/dev/null 2>/dev/null
	then
		codigo=$(grep -i "^$1" $cache | sed "s/ .*//")
		desc=$(grep -i "^$1" $cache | sed "s/^[A-Z0-9]\{3\} *//")

		zztool eco $desc
		$ZZWWWHTML "${URL}/canal/$codigo" |
		sed -n '/<li class/{N;p;}' |
		sed '/^[[:space:]]*$/d;/.*<\/*li/s/<[^>]*>//g' |
		sed 's/^.*programa\///g;s/".*title="/_/g;s/">//g;s/<span .*//g;s/<[^>]*>/ /g;s/amp;//g' |
		sed 's/^[[:space:]]*/ /g' |
		sed '/^[[:space:]]*$/d' |
		if [ "$2" = "semana" -o "$2" = "s" ]
		then
			sed "/^ \([STQD].*[0-9][0-9]\/[0-9][0-9]\)/ { x; p ; x; s//\1/; }" |
			sed 's/^ \(.*\)_\(.*\)\([0-9][0-9]h[0-9][0-9]\)/ \3 \2 Cod: \1/g'
		else
			sed -n "/, $DATA/,/^ [STQD].*[0-9][0-9]\/[0-9][0-9]/p" |
			sed '$d;1s/^ *//;2,$s/^ \(.*\)_\(.*\)\([0-9][0-9]h[0-9][0-9]\)/ \3 \2 Cod: \1/g'
		fi |
		zzunescape --html |
		awk -F " Cod: " '{ if (NF==2) { printf "%-64s Cod: %s\n", substr($1,1,63), substr($2, 1, index($2, "-")-1) } else print }'
		return
	fi

	case "$1" in
	canais) zzcolunar 4 $cache;;
	aberta)                        URL="${URL}/categoria/Aberta"; flag=1; desc="Aberta";;
	doc | documentario)            URL="${URL}/categoria/Documentarios"; flag=1; desc="Documentários";;
	esporte | esportes | futebol)  URL="${URL}/categoria/Esportes"; flag=1; desc="Esportes";;
	filmes)                        URL="${URL}/categoria/Filmes"; flag=1; desc="Filmes";;
	infantil)                      URL="${URL}/categoria/Infantil"; flag=1; desc="Infantil";;
	noticias)                      URL="${URL}/categoria/Noticias"; flag=1; desc="Notícias";;
	series | seriados)             URL="${URL}/categoria/Series"; flag=1; desc="Séries";;
	variedades)                    URL="${URL}/categoria/Variedades"; flag=1; desc="Variedades";;
	cod)                           URL="${URL}/programa/$2"; flag=2;;
	todos | agora | *)             URL="${URL}/categoria/Todos"; flag=1; desc="Agora";;
	esac

	if [ $flag -eq 1 ]
	then
		zztool eco $desc
		$ZZWWWHTML "$URL" | sed -n '/<li style/{N;p;}' |
		sed '/^[[:space:]]*$/d;/.*<\/*li/s/<[^>]*>//g' |
		sed 's/.*title="//g;s/">.*<br \/>/ | /g;s/<[^>]*>/ /g' |
		sed 's/[[:space:]]\{1,\}/ /g' |
		sed '/^[[:space:]]*$/d' |
		zzunescape --html |
		awk -F "|" '{ printf "%5s%-57s%s\n", $2, substr($1,1,56), $3 }'
	elif [ "$1" = "cod" ]
	then
		zztool eco "Código: $2"
		$ZZWWWHTML "$URL" | sed -n '/<span class="tit">/,/Compartilhe:/p' |
		sed 's/<span class="tit">/Título: /;s/<span class="tit_orig">/Título Original: /' |
		sed 's/<[^>]*>/ /g;s/amp;//g;s/\&ccedil;/ç/g;s/\&atilde;/ã/g;s/.*str="//;s/";//;s/[\|] //g' |
		sed 's/^[[:space:]]*/ /g' |
		sed '/^[[:space:]]*$/d;/document.write/d;/str == ""/d;$d' |
		zzunescape --html
	fi
}

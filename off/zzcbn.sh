# ----------------------------------------------------------------------------
# http://cbn.globoradio.com.br
# Busca e toca os últimos comentários dos comentaristas da radio CBN.
# Uso: zzcbn [--audio] [num_audio] -c COMENTARISTA [-d data] ou  zzcbn --lista
# Ex.: zzcbn -c max-gehringer -d ontem
#      zzcbn -c juca-kfouri -d 13/05/09
#      zzcbn -c miriam
#      zzcbn --audio 2 -c  mario-sergio-cortella
#
# Autor: Rafael Machado Casali <rmcasali (a) gmail com>
# Desde: 2009-04-16
# Versão: 8
# Licença: GPL
# Requisitos: zzecho zzplay zzcapitalize zzdatafmt zzxml zzutf8
# ----------------------------------------------------------------------------
# DESATIVADA: 2018-01-27 Site usando técnicas AJAX.
zzcbn ()
{
	zzzz -h cbn "$1" && return

	local cache=$(zztool cache cbn)
	local url='http://cbn.globoradio.globo.com'
	local audio=0
	local num_audio=1
	local nome comentarista link fonte rss podcast ordem data_coment data_audio

	#Verificacao dos parâmetros
	test -n "$1" || { zztool -e uso cbn; return 1; }

	# Cache com parametros para nomes e links
	if ! test -s "$cache" || test $(tail -n 1 "$cache") != $(date +%F)
	then
		zztool source "$url" |
		sed -n '/<ul class="lvl3 /p' |
		zzxml --tag a |
		sed -n '/http:..cbn.globoradio.globo.com.comentaristas./{s/.*="//;s/">//;p;}' |
		awk -F "/" 'BEGIN {OFS=";"};{url = $0;gsub(/-/," ", $6); gsub(/\.htm/,"", $6);print $6, $5, url }'|
		sort | uniq |
		while read linha
		do
			nome=$(echo "$linha" | cut -d ";" -f 1 | zzcapitalize )
			comentarista=$(echo "$linha" | cut -d ";" -f 2 )
			link=$(echo "$linha" | cut -d ";" -f 3 )
			fonte=$(zztool source "$link")
			rss=$(
				echo "$fonte" |
				sed -n '/\<RSS\>/{s/.*href="//;s/".*//;p;}'
			)
			podcast=$(
				echo "$fonte" |
				sed -n '/>Podcast</{s/Podcast<.*//;s/.*?q=//;s/".*//;p;}'
			)
			test -n "$rss$podcast" && echo "$nome | $comentarista | $rss | $podcast | $link"
		done > "$cache"
		zzdatafmt --iso hoje >> "$cache"
	fi

	# Listagem dos comentaristas
	if test "$1" = "--lista"
	then
		sed '$d' "$cache" | awk -F " [|] " '{print $2 "\t => " $1}' | expand -t 44
		return
	fi

# Opções de linha de comando
	while test "${1#-}" != "$1"
	do
		case "$1" in
			-c)
				comentarista="$2"
				shift
				shift
			;;
			-d)
				data_coment=$(zzdatafmt --en -f "SSS, DD MMM AAAA" "$2")
				data_audio=$(zzdatafmt -f "_AAMMDD" "$2")
				shift
				shift
			;;
			--audio)
				audio=1
				shift
				if test -n "$1"
				then
					if zztool testa_numero "$1"
					then
						num_audio="$1"
						shift
					fi
				fi
			;;
			*)
				zztool erro "Opção inválida!!"
				return 1
			;;
		esac
	done

	# Audio ou comentários feitos pelo comentarista selecionado
	if test "$audio" -eq 1
	then
		podcast=$( awk -F ' [|] ' '$2 ~ /'$comentarista'/ {print $4}' "$cache" )
		if test -n "$podcast"
		then
			podcast=$(zztool source "$podcast" | sed -n '/media:content/p')
			zztool eco "Áudios diponíveis:"
			echo "$podcast" |
			sed 's/.*_//; s/\.mp3.*//; s/\(..\)\(..\)\(..\)/\3\/\2\/20\1/' |
			awk '{ print NR ".", $0}'

			podcast=$(
				echo "$podcast" |
				sed -n "${num_audio}p" |
				sed 's|.*audio=|http://download.sgr.globo.com/sgr-mp3/cbn/|' |
				sed 's/\.mp3.*/.mp3/'
			)

			test -n "$podcast" && zzplay "$podcast" mplayer || zzecho -l vermelho "Sem comentários em áudio."
		else
			zzecho -l vermelho "Sem comentários em áudio."
		fi

	else
		rss=$( awk -F ' [|] ' '$2 ~ /'$comentarista'/ {print $3}' "$cache" )

		if test -n "$rss"
		then
			zztool source "$rss" |
			zzutf8 |
			zzxml --tag item |
			zzxml --tag titleApp --tag descriptionApp --tag pubDate |
			sed 's/<titleApp>/-----/' |
			zzxml --untag |
			sed '/^$/d; s/ [0-2][0-9]:.*//' |
			if test -n "$data_coment"
			then
				grep -B 3 "$data_coment"
			else
				cat -
			fi
		else
			zzecho -l vermelho "Sem comentários."
		fi
	fi
}

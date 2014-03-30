# ----------------------------------------------------------------------------
# Toca o arquivo de áudio, escolhendo o player mais adequado instalado.
# Também pode tocar lista de reprodução (playlist).
# Pode-se escolher o player principal passando-o como segundo argumento.
# - Os players possíveis para cada tipo são:
#	wav, au, aiff		afplay, play, mplayer, cvlc
#	mp2, mp3		afplay, mpg321, mpg123, mplayer, cvlc
#	ogg			ogg123, mplayer, cvlc
#	aac, wma, mka		mplayer, cvlc
#	pls, m3u, xspf, asx	mplayer, cvlc
#
# Uso: zzplay <arquivo-de-áudio> [player]
# Ex.: zzplay os_seminovos_escolha_ja_seu_nerd.mp3
#      zzplay os_seminovos_eu_nao_tenho_iphone.mp3 cvlc   # priorizando o cvlc
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-13
# Versão: 5
# Licença: GPL
# Requisitos: zzextensao zzminusculas zzunescape zzxml
# ----------------------------------------------------------------------------
zzplay ()
{
	zzzz -h play "$1" && return

	local tipo play_cmd player play_lista
	local lista=0
	local cache="zzplay.pls"

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso play; return 1; }

	tipo=$(zzextensao "$1" | zzminusculas)

	# Para cada tipo de arquivo de audio ou playlist, seleciona o player disponivel
	case "$tipo" in
		wav | au | aiff ) play_lista="afplay play mplayer cvlc";;
		mp2 | mp3 )       play_lista="afplay mpg321 mpg123 mplayer cvlc" ;;
		ogg )             play_lista="ogg123 mplayer cvlc";;
		aac | wma | mka ) play_lista="mplayer cvlc";;
		pls | m3u | xspf | asx ) play_lista="mplayer cvlc"; lista=1;;
		*) zzplay -h && return;;
	esac

	# Coloca player selecionado como prioritário.
	if [ "$2" ] && zztool grep_var "$2" "$play_lista"
	then
		play_lista=$(echo "$play_lista" | sed "s/$2//")
		play_lista="$2 $play_lista"
	fi

	# Testa sequencialmente até encontrar o player disponível
	for play_cmd in $play_lista
	do
		if type $play_cmd >/dev/null 2>&1
		then
			player="$play_cmd"
			break
		fi
	done

	if [ "$player" ]
	then
		# Mensagens de ajuda se estiver usando uma lista de reprodução
		if [ "$player" = "mplayer" -a $lista -eq 1 ]
		then
			zztool eco "Tecla 'q' para sair."
			zztool eco "Tecla '<' para música anterior na playlist."
			zztool eco "Tecla '>' para próxima música na playlist."
			player="$player -playlist"
		elif [ "$player" = "cvlc" -a $lista -eq 1 ]
		then
			zztool eco "Digitar Crtl+C para sair."
			zztool eco "Tecla '1' para música anterior na playlist."
			zztool eco "Tecla '2' para próxima música na playlist."
			player="$player --global-key-next 2 --global-key-prev 1"
		fi

		# Transforma os vários formatos de lista de reprodução numa versão simples de pls
		case "$tipo" in
			m3u)
				sed '/^[[:blank:]]*$/d;/^#/d;s/^[[:blank:]]*//g' "$1" |
				awk 'BEGIN { print "[playlist]" } { print "File" NR "=" $0 }' |
				sed 's/%\([0-9A-F][0-9A-F]\)/\\\\x\1/g' |
				while read linha
				do
					printf "%b\n" "$linha"
				done >> $cache
			;;
			xspf)
				zzxml --indent --tag location "$1" | zzxml --untag | zzunescape --html |
				sed '/^[[:blank:]]*$/d;s/^[[:blank:]]*//g' | sed 's|file://||g' |
				awk 'BEGIN { print "[playlist]" } { print "File" NR "=" $0 }' |
				sed 's/%\([0-9A-F][0-9A-F]\)/\\\\x\1/g' |
				while read linha
				do
					printf "%b\n" "$linha"
				done >> $cache
			;;
			asx)
				zzxml --indent --tag ref "$1" | zzunescape --html | sed '/^[[:blank:]]*$/d' |
				awk -F'""' 'BEGIN { print "[playlist]" } { print "File" NR "=" $2 }' |
				sed 's/%\([0-9A-F][0-9A-F]\)/\\\\x\1/g' |
				while read linha
				do
					printf "%b\n" "$linha"
				done >> $cache
			;;
		esac

		test -s "$cache" && $player "$cache" >/dev/null 2>&1 || $player "$1" >/dev/null 2>&1
	fi

	rm -f "$cache"
}

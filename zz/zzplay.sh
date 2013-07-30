# ----------------------------------------------------------------------------
# Toca o arquivo de áudio, escolhendo o player mais adequado instalado.
# Pode-se escolher o player principal passando-o como segundo argumento.
# - Os players possíveis para cada tipo são:
#	wav, au, aiff	afplay, play, mplayer, cvlc
#	mp2, mp3	afplay, mpg321, mpg123, mplayer, cvlc
#	ogg		ogg123, mplayer, cvlc
#	aac, wma, mka	mplayer, cvlc
#
# Uso: zzplay <arquivo-de-áudio> [player]
# Ex.: zzplay os_seminovos_escolha_ja_seu_nerd.mp3
#      zzplay os_seminovos_eu_nao_tenho_iphone.mp3 cvlc   # priorizando o cvlc
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-13
# Versão: 4
# Licença: GPL
# Requisitos: zzextensao zzminusculas
# ----------------------------------------------------------------------------
zzplay ()
{
	zzzz -h play "$1" && return

	local tipo play_cmd player play_lista

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso play; return 1; }

	tipo=$(zzextensao "$1" | zzminusculas)

	# Para cada tipo de arquivo de audio, seleciona o player disponivel
	case "$tipo" in
		wav | au | aiff ) play_lista="afplay play mplayer cvlc";;
		mp2 | mp3 )       play_lista="afplay mpg321 mpg123 mplayer cvlc" ;;
		ogg )             play_lista="ogg123 mplayer cvlc";;
		aac | wma | mka ) play_lista="mplayer cvlc";;
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

	[ "$player" ] && $player "$1" >/dev/null 2>&1
}

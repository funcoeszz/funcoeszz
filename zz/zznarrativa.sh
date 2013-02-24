# ----------------------------------------------------------------------------
# http://translate.google.com
# Narra frases em português usando o Google Tradutor.
#
# Uso: zznarrativa palavras
# Ex.: zznarrativa regex é legal
#
# Autor: Kl0nEz <kl0nez (a) wifi org br>
# Desde: 2011-08-23
# Versão: 2
# Licença: GPLv2
# Requisitos: mpg123 ou afplay
# ----------------------------------------------------------------------------
zznarrativa ()
{
	zzzz -h narrativa "$1" && return

	[ "$1" ] || { zztool uso narrativa; return 1; }

	# Variaveis locais
	local padrao play_cmd
	local url='http://translate.google.com.br'
	local charset_para='UTF-8'
	local audio_file="/tmp/$$.WAV"

	if test -f /usr/bin/afplay
	then
		play_cmd='afplay'     # mac
	else
		play_cmd='mpg123 -q'  # linux
	fi

	# Narrativa
	padrao=$(echo "$*" | sed "$ZZSEDURL")
	local audio="translate_tts?ie=$charset_para&q=$padrao&tl=pt&prev=input"
	$ZZWWWHTML "$url/$audio" > $audio_file && $play_cmd $audio_file && rm -rf $audio_file
}

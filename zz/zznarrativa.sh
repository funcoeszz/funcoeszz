# ----------------------------------------------------------------------------
# http://translate.google.com
# Narra frases em português usando o Google Tradutor.
#
# Uso: zznarrativa palavras
# Ex.: zznarrativa regex é legal
#
# Autor: Kl0nEz <kl0nez (a) wifi org br>
# Desde: 2011-08-23
# Versão: 4
# Licença: GPLv2
# Requisitos: zzplay
# ----------------------------------------------------------------------------
zznarrativa ()
{
	zzzz -h narrativa "$1" && return

	[ "$1" ] || { zztool uso narrativa; return 1; }

	# Variaveis locais
	local padrao
	local url='http://translate.google.com.br'
	local charset_para='UTF-8'
	local audio_file="$ZZTMP.narrativa.$$.wav"

	# Narrativa
	padrao=$(echo "$*" | sed "$ZZSEDURL")
	local audio="translate_tts?ie=$charset_para&q=$padrao&tl=pt"
	$ZZWWWHTML "$url/$audio" > $audio_file && zzplay $audio_file mplayer
	rm -f $audio_file
}

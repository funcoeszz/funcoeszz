# ----------------------------------------------------------------------------
# Converte o texto para UTF-8, se necessário.
# Obs.: Caso o texto já seja UTF-8, não há conversão.
#
# Uso: zzutf8 [arquivo]
# Ex.: zzutf8 /etc/passwd
#      zzutf8 index-iso.html
#      echo Bênção | zzutf8        # Bênção
#      printf '\341\n' | zzutf8    # á
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2015-03-21
# Versão: 1
# Licença: GPL
# Requisitos: zzencoding
# ----------------------------------------------------------------------------
zzutf8 ()
{
	zzzz -h utf8 "$1" && return

	local encoding
	local cache=$(zztool cache utf8 $$)

	# Guarda o texto de entrada
	zztool file_stdin "$@" > "$cache"

	# Qual a sua codificação atual?
	encoding=$(zzencoding "$cache")

	case "$encoding" in

		# Encoding já compatível com UTF-8, nada a fazer
		utf-8 | us-ascii)
			cat "$cache"
		;;

		# Arquivo vazio ou encoding desconhecido, não mexe
		'')
			cat "$cache"
		;;

		# Encoding detectado, converte pra UTF-8
		*)
			iconv -f "$encoding" -t utf-8 "$cache"
		;;
	esac

	rm -f "$cache"
}

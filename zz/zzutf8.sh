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
# Versão: 2
# Licença: GPL
# Requisitos: zzencoding
# Tags: texto, conversão
# ----------------------------------------------------------------------------
zzutf8 ()
{
	zzzz -h utf8 "$1" && return

	local encoding
	local tmp=$(zztool mktemp utf8)

	# Guarda o texto de entrada
	zztool file_stdin "$@" > "$tmp"

	# Qual a sua codificação atual?
	encoding=$(zzencoding "$tmp")

	case "$encoding" in

		# Encoding já compatível com UTF-8, nada a fazer
		utf-8 | us-ascii)
			cat "$tmp"
		;;

		# Arquivo vazio ou encoding desconhecido, não mexe
		'' | unknown* | binary )
			cat "$tmp"
		;;

		# Encoding detectado, converte pra UTF-8
		*)
			iconv -f "$encoding" -t utf-8 "$tmp"
		;;
	esac

	rm -f "$tmp"
}

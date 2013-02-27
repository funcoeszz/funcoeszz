# ----------------------------------------------------------------------------
# http://translate.google.com
# Google Tradutor, para traduzir frases para vários idiomas.
# Caso não especificado o idioma, a tradução será português -> inglês.
# Use a opção -l ou --lista para ver todos os idiomas disponíveis.
# Use a opção -a ou --audio para ouvir a frase na voz feminina do google.
#
# Alguns idiomas populares são:
#      pt = português         fr = francês
#      en = inglês            it = italiano
#      es = espanhol          de = alemão
#
# Uso: zztradutor [de-para] palavras
# Ex.: zztradutor o livro está na mesa    # the book is on the table
#      zztradutor pt-en livro             # book
#      zztradutor pt-es livro             # libro
#      zztradutor pt-de livro             # Buch
#      zztradutor de-pt Buch              # livro
#      zztradutor de-es Buch              # Libro
#      zztradutor --lista                 # Lista todos os idiomas
#      zztradutor --lista eslo            # Procura por "eslo" nos idiomas
#      zztradutor --audio                 # Gera um arquivo OUT.WAV
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2008-09-02
# Versão: 6
# Licença: GPLv2
# Requisitos: iconv
# ----------------------------------------------------------------------------
zztradutor ()
{
	zzzz -h tradutor "$1" && return

	[ "$1" ] || { zztool uso tradutor; return 1; }

	# Variaveis locais
	local padrao
	local url='http://translate.google.com.br'
	local lang_de='pt'
	local lang_para='en'
	local charset_de='ISO-8859-1'
	local charset_para='UTF-8'
	local audio_file="/tmp/$$.WAV"
	local play_cmd='mpg123 -q'

	case "$1" in
		# O usuário informou um par de idiomas, como pt-en
		[a-z][a-z]-[a-z][a-z])
			lang_de=${1%-??}
			lang_para=${1#??-}
			shift

			# Pega exceção: zztradutor pt-en  (sem mais argumentos)
			[ "$1" ] || { zztool uso tradutor; return 1; }
		;;
		-l | --lista)
			# Uma tag por linha, então extrai e formata as opções do <SELECT>
			$ZZWWWHTML "$url" |
			sed 's/</\n&/g'  |
			sed -n '/<option value=af>/,/<option value=yi>/p' |
			sed -n '1p;2,/value=af/p' | sed -n '$d;1~2p' |
			sed 's/<option .*value=/ /g;s/>/: /g;s/zh-CN/cn/g'|
			iconv -f $charset_de -t $charset_para |
			grep ${2:-:}
			return
		;;
		-a | --audio)
			# Narrativa
				shift
				padrao=$(echo "$*" | sed "$ZZSEDURL")
				local audio="translate_tts?ie=$charset_para&q=$padrao&tl=pt&prev=input"
				$ZZWWWHTML "$url/$audio" > $audio_file && $play_cmd $audio_file && rm -rf $audio_file
				return
		;;
	esac

	padrao=$(echo "$*" | sed "$ZZSEDURL")

	# Exceção para o chinês, que usa um código diferente
	test $lang_para = 'cn' && lang_para='zh-CN'

	# Baixa a URL, coloca cada tag em uma linha, pega a linha desejada
	# e limpa essa linha para estar somente o texto desejado.
	$ZZWWWHTML "$url?tr=$lang_de&hl=$lang_para&text=$padrao" |
		iconv --from-code=$charset_de --to-code=$charset_para |
		awk 'gsub("<[^/]", "\n&")' |
		grep '<span title' |
		sed 's/<[^>]*>//g'
}

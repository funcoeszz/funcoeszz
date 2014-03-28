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
#      cat arquivo | zztradutor           # Traduz o conteúdo do arquivo
#      zztradutor --lista                 # Lista todos os idiomas
#      zztradutor --lista eslo            # Procura por "eslo" nos idiomas
#      zztradutor --audio                 # Gera um arquivo OUT.WAV
#      echo "teste" | zztradutor          # test
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2008-09-02
# Versão: 12
# Licença: GPLv2
# Requisitos: zzxml zzplay zzunescape
# ----------------------------------------------------------------------------
zztradutor ()
{
	zzzz -h tradutor "$1" && return

	# Variaveis locais
	local padrao
	local url='http://translate.google.com.br'
	local lang_de='pt'
	local lang_para='en'
	local charset_para='UTF-8'
	local audio_file="$ZZTMP.tradutor.$$.wav"

	case "$1" in
		# O usuário informou um par de idiomas, como pt-en
		[a-z][a-z]-[a-z][a-z])
			lang_de=${1%-??}
			lang_para=${1#??-}
			shift
		;;
		-l | --lista)
			# Uma tag por linha, então extrai e formata as opções do <SELECT>
			$ZZWWWHTML "$url" |
			zzxml --tag option |
			sed -n '/<option value=af>/,/<option value=yi>/p' |
			zztool texto_em_iso | sort -u |
			sed 's/.*value=\([^>]*\)>\([^<]*\)<.*/\1: \2/g;s/zh-CN/cn/g' |
			grep ${2:-:}
			return
		;;
		-a | --audio)
			# Narrativa
				shift
				padrao=$(echo "$*" | sed "$ZZSEDURL")
				local audio="translate_tts?ie=$charset_para&q=$padrao&tl=pt&prev=input"
				$ZZWWWHTML "$url/$audio" > $audio_file && zzplay $audio_file mplayer
				rm -f $audio_file
				return
		;;
	esac

	padrao=$(zztool multi_stdin "$@" | awk '{ if (NR==1) { printf $0 } else { printf "%0a" $0 } }' | sed "$ZZSEDURL")

	# Exceção para o chinês, que usa um código diferente
	test $lang_para = 'cn' && lang_para='zh-CN'

	# Baixa a URL, coloca cada tag em uma linha, pega a linha desejada
	# e limpa essa linha para estar somente o texto desejado.
	$ZZWWWHTML "$url?tr=$lang_de&hl=$lang_para&text=$padrao" |
		zztool texto_em_iso |
		zzxml --tidy |
		sed -n '/id=result_box/,/<\/div>/p' |
		zzxml --untag |
		sed '/span title=/d;/onmouseout=/d;/^ *$/d' |
		zzunescape --html
}

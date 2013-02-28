# ----------------------------------------------------------------------------
# http://google.com
# Pesquisa no Google diretamente pela linha de comando.
# Uso: zzgoogle [-n <número>] palavra(s)
# Ex.: zzgoogle receita de bolo de abacaxi
#      zzgoogle -n 5 ramones papel higiênico cachorro
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2003-04-03
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
# FIXME: zzgoogle rato roeu roupa rei roma [PPS], [PDF]
zzgoogle ()
{
	zzzz -h google "$1" && return

	local padrao
	local limite=10
	local url='http://www.google.com.br/search'

	# Opções de linha de comando
	if [ "$1" = '-n' ]
	then
		limite="$2"
		shift
		shift

		zztool -e testa_numero "$limite" || return 1
	fi

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso google; return 1; }

	# Prepara o texto a ser pesquisado
	padrao=$(echo "$*" | sed "$ZZSEDURL")
	[ "$padrao" ] || return 0

	# Pesquisa, baixa os resultados e filtra
	#
	# O Google condensa tudo em um única longa linha, então primeiro é preciso
	# inserir quebras de linha antes de cada resultado. Identificadas as linhas
	# corretas, o filtro limpa os lixos e formata o resultado.

	$ZZWWWHTML -cookies "$url?q=$padrao&num=$limite&ie=UTF-8&oe=UTF-8&hl=pt-BR" |
		sed 's/<p>/\
@/g' |
		sed '
			/^@<a href="\([^"]*\)">/!d
			s|^@<a href="/url?q=||
			s/<\/a>.*//

			s/<table.*//
			/^http/!d
			s/&amp;sa.*">/ /

			# Remove tags HTML
			s/<[^>]*>//g

			# Restaura os caracteres especiais
			s/&gt;/>/g
			s/&lt;/</g
			s/&quot;/"/g
			s/&nbsp;/ /g
			s/&amp;/\&/g

			# Restaura caracteres url encoded
			s/%3F/?/g
			s/%3D/\=/g
			s/%26/\&/g

			s/\([^ ]*\) \(.*\)/\2\
  \1\
/'
}

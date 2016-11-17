# ----------------------------------------------------------------------------
# http://google.com
# Pesquisa no Google diretamente pela linha de comando.
# Uso: zzgoogle [-n <número>] palavra(s)
# Ex.: zzgoogle receita de bolo de abacaxi
#      zzgoogle -n 5 ramones papel higiênico cachorro
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2003-04-03
# Versão: 3
# Licença: GPL
# Requisitos: zztrim
# ----------------------------------------------------------------------------
# DESATIVADA: 2016-11-17 Google bloqueia robôs (issue #390)
zzgoogle ()
{
	zzzz -h google "$1" && return

	local padrao url
	local limite=10

	# Opções de linha de comando
	if test "$1" = '-n'
	then
		limite="$2"
		shift
		shift

		zztool -e testa_numero "$limite" || return 1
	fi

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso google; return 1; }

	# Prepara o texto a ser pesquisado
	padrao=$(echo "$*" | sed "$ZZSEDURL")
	test -n "$padrao" || return 0

	# Pesquisa, baixa os resultados e filtra
	case $ZZBROWSER in
	lynx)
	# O Google condensa tudo em um única longa linha, então primeiro é preciso
	# inserir quebras de linha antes de cada resultado. Identificadas as linhas
	# corretas, o filtro limpa os lixos e formata o resultado.
		url='http://www.google.com.br/search'
		zztool source "$url?q=$padrao&num=$limite&ie=UTF-8&oe=UTF-8&hl=pt-BR" |
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
	;;
	*)
	# Com outros navegadores o google tem problemas
	# Então usa-se outro site de busca: o duckduckgo.com
	# Que perminte usar normalmente com o dump.
		limite=$((limite+1))
		url='https://duckduckgo.com'
		zztool dump "${url}/?q=$padrao" |
		sed -n '/ [ []\{0,2\}Search[] ]\{0,2\}$/,/ [ []\{0,2\}Search[] ]\{0,2\}$/ {
			//d
			/Next Page >/d
			/^ *$/d
			/No results.$/d
			p
		}' |
		zztrim -r |
		sed -n "/^ *1\. /,/^ *${limite}\. /{ /^ *${limite}\. /d; p; } "
	;;
	esac
}

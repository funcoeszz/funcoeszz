# ----------------------------------------------------------------------------
# http://visualjquery.com/1.1.2.html
# Exibe a descrição da função jQuery informada.
# Caso não seja passado o nome, serão exibidas informações acerca do $().
# Se usado o argumento -s, será exibida somente a sintaxe.
# Uso: zzjquery [-s] funcao
# Ex.: zzjquery gt
#      zzjquery -s gt
#
# Autor: Felipe Nascimento Silva Pena <felipensp (a) gmail com>
# Desde: 2007-12-04
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
zzjquery ()
{
	zzzz -h jquery "$1" && return

	local er
	local cache="$ZZTMP.jquery"
	local er1="s/^ *<h1>\([\$.]*$2(.*\)<\/h1> *$/- \1/p;"  # <h1>gt(pos)</h1>
	local er2="
	/^ *<h1>\([\$.]*$1(.*\)<\/h1> *$/ {

		# Mostra o nome da função e vai pra próxima linha
		s//\1:/p
		n

		### A descrição está numa única linha.
		#
		# <h1>$.get(url, params, callback)</h1>
		# <p>Load a remote page using an HTTP GET request.</p>
		#
		# O comando G adiciona uma linha após a descrição.
		# O comando b pula pro final, já terminamos com esse.
		#
		/^ *<p>\(.*\)<\/p> *$/ {
			s//  \1/
			G
			p
			b
		}

		### A descrição está em várias linhas.
		#
		# <h1>gt(pos)</h1>
		# <p>Reduce the set of matched elements to all elements after a given position.
		#    The position of the element in the set of matched elements
		#    starts at 0 and goes to length - 1.
		# </p>
		#
		# Esse é mais chato, temos que pegar todo o texto até o </p>.
		# É feito um loop que termina quando achar o </p>.
		#
		:multi
		/<\/p>/ {
			s///p
			b
		}
		s/^ *<p>//
		s/^ */  /p
		n
		b multi
	}
	"

	[ "$1" = '-s' ] && er="$er1" || er="$er2"

	# Se o cache está vazio, baixa o conteúdo
	if ! test -s "$cache"
	then
		$ZZWWWHTML "https://raw.githubusercontent.com/funcoeszz/funcoeszz/master/local/zzjquery.html" > "$cache"
	fi

	# Faz a pesquisa e filtra o resultado
	sed -n "$er" "$cache"
}

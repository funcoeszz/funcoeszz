# ----------------------------------------------------------------------------
# http://www.dicio.com.br
# Dicionário de português.
# Fornecendo uma "palavra" como argumento retorna seu significado e sinônimo.
# Se for seguida do termo "def", retorna suas definições.
#
# Uso: zzdicportugues palavra [def]
# Ex.: zzdicportugues bolacha
#      zzdicportugues comer def
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2003-02-26
# Versão: 11
# Licença: GPL
# Requisitos: zzsemacento zzminusculas zztrim
# Tags: internet, dicionário
# ----------------------------------------------------------------------------
zzdicportugues ()
{
	zzzz -h dicportugues "$1" && return

	local url='http://dicio.com.br'
	local ini='^Significado de '
	local fim='^Definição de '
	local palavra=$(echo "$1" | zzminusculas)
	local padrao=$(echo "$palavra" | zzsemacento)
	local contador=1
	local resultado conteudo

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso dicportugues; return 1; }

	# Verificando se a palavra confere na pesquisa
	until test "$resultado" = "$palavra"
	do
		conteudo=$(zztool dump "$url/$padrao")
		resultado=$(
		echo "$conteudo" |
			sed -n "
			/^Significado de /{
				s/^Significado de //
				s/ *$//
				p
				}" |
			zzminusculas
			)
		test -n "$resultado" || { zztool erro "Palavra não encontrada"; return 1; }

		# Incrementando o contador no padrão
		padrao=$(echo "$padrao" | sed 's/_[0-9]*$//')
		contador=$((contador + 1))
		padrao=${padrao}_${contador}
	done

	if test 'def' = "$2"
	then
		ini='^Definição de '; fim=' escrit[ao] ao contrário: '
	fi

	echo "$conteudo" |
		sed -n "
			/$ini/,/$fim/ {
				/$ini/d
				/^Definição de /d
				/^ *Exemplos com .*${palavra}$/,/^ *Outras informações sobre /d
				/^Sinônimos de /{N;d;}
				/Mais sinônimos /d
				/^Antônimos de /{N;d;}
				/Mais antônimos /d
				p
			}" |
		zztrim
}

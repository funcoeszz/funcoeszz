# ----------------------------------------------------------------------------
# http://www.dicio.com.br
# Dicionário de português.
# Definição de palavras e conjugação verbal
# Fornecendo uma "palavra" como argumento retorna seu significado e sinônimo.
# Se for seguida do termo "def", retorna suas definições.
# Se for seguida do termo "conj", retorna todas as formas de conjugação.
# Pode-se filtrar pelos modos de conjugação, fornecendo após o "conj" o modo
# desejado:
# ind (indicativo), sub (subjuntivo), imp (imperativo), inf (infinitivo)
#
# Uso: zzdicportugues palavra [def|conj [ind|sub|conj|imp|inf]]
# Ex.: zzdicportugues bolacha
#      zzdicportugues verbo conj sub
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2003-02-26
# Versão: 10
# Licença: GPL
# Requisitos: zzsemacento zzminusculas zztrim
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

	case "$2" in
	def) ini='^Definição de '; fim=' escrit[ao] ao contrário: ' ;;
	conj)
		ini='^ *Infinitivo:';  fim='(Rimas com |Anagramas de )'
		case "$3" in
			ind)        ini='^ *Indicativo'; fim='^ *Subjuntivo' ;;
			sub | conj) ini='^ *Subjuntivo'; fim='^ *Imperativo' ;;
			imp)        ini='^ *Imperativo'; fim='^ *Infinitivo' ;;
			inf)        ini='^ *Infinitivo *$' ;;
		esac
	;;
	esac

	case "$2" in
	conj)
		echo "$conteudo" |
		awk '/'"$ini"'/, /'"$fim"'/ ' |
			sed '
				{
				/^ *INDICATIVO *$/d;
				/^ *Indicativo *$/d;
				/^ *SUBJUNTIVO *$/d;
				/^ *Subjuntivo *$/d;
				#/^ *CONJUNTIVO *$/d
				#/^ *Conjuntivo *$/d
				/^ *IMPERATIVO *$/d;
				/^ *Imperativo *$/d;
				/^ *INFINITIVO *$/d;
				/^ *Infinitivo *$/d;
				/Rimas com /d;
				/Anagramas de /d;
				/^ *$/d;
				s/^ *//;
				s/^\*/\
&/;
				#s/ do Indicativo/&\
#/;
				#s/ do Subjuntivo/&\
#/;
				#s/ do Conjuntivo/&\
#/;
				#s/\* Imperativo Afirmativo/&\
#/;
				#s/\* Imperativo Negativo/&\
#/;
				#s/\* Imperativo/&\
#/;
				#s/\* Infinitivo Pessoal/&\
#/;
				s/^[a-z]/ &/g;
				#p
				}' |
				zztrim
	;;
	*)
		echo "$conteudo" |
		awk '/'"$ini"'/, /'"$fim"'/ ' |
			sed "
				1d
				/^Definição de /d
				/^Sinônimos de /{N;d;}
				/Mais sinônimos /d
				/^Antônimos de /{N;d;}
				/Mais antônimos /d" |
			zztrim
	;;
	esac
}

# ----------------------------------------------------------------------------
# Conjuga verbo em todos os modos.
# E pode-se filtrar pelo modo no segundo argumento:
#  ind => Indicativo
#  sub => Subjuntivo
#  imp => Imperativo
#  inf => Infinitivo
#
# Ou apenas a definição do verbo se o segundo argumento for: def
#
# Uso: zzconjugar verbo [ ind | sub | imp | inf | def ]
# Ex.: zzconjugar correr
#      zzconjugar comer sub
#
# Autor: Leslie Harlley Watter <leslie (a) watter org>
# Desde: 2003-08-05
# Versão: 5
# Licença: GPL
# Requisitos: zzalinhar zzcolunar zzjuntalinhas zzlblank zzminusculas zzsemacento zzsqueeze zztrim zzutf8 zzxml
# Tags: internet, consulta
# Nota: Colaboração de José Inácio Coelho <jinacio (a) yahoo com>
# ----------------------------------------------------------------------------
zzconjugar ()
{
	zzzz -h conjugar "$1" && return

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso conjugar; return 1; }

	local url='http://www.conjugacao.com.br'
	local contador=1
	local modos='def ind sub imp inf'
	local palavra padrao resultado conteudo modo modos

	if test -n "$1"
	then
		palavra=$(echo "$1" | zzminusculas)
		padrao=$(echo "$palavra" | zzsemacento)
		shift
	else
		zztool -e uso conjugar
		return 1
	fi

	test -n "$1" && modos="$*"

	# Verificando se a palavra confere na pesquisa
	until test "$resultado" = "$palavra"
	do
		conteudo=$(zztool source "$url/verbo-$padrao" | zzutf8 | zzxml --tidy --notag script | sed -n '/<h1/,/ relacionados com /p')
		resultado=$(echo "$conteudo" | sed -n '2 { s/.* //; p; }' | zzminusculas)
		test -n "$resultado" || { zztool erro "Palavra não encontrada"; return 1; }

		# Incrementando o contador no padrão
		padrao=$(echo "$padrao" | sed 's/-[0-9]*$//')
		contador=$((contador + 1))
		test $contador -gt 9 && return 1
		padrao=${padrao}-${contador}
	done

	conteudo=$(
		echo "$conteudo" |
		zzjuntalinhas -i '<h2'                    -f '</h2>'      -d ' ' |
		zzjuntalinhas -i '<h3'                    -f '</h3>'      -d ' ' |
		zzjuntalinhas -i '<h4'                    -f '</h4>'      -d ' ' |
		zzjuntalinhas -i '<strong'                -f '</strong>'  -d ' ' |
		zzjuntalinhas -i '^<span>'                 -f '^</span>$' -d ' ' |
		zzjuntalinhas -i '> Gerúndio <'           -f '^</span>'   -d ' ' |
		zzjuntalinhas -i '> Particípio passado <' -f '^</span>'   -d ' ' |
		zzjuntalinhas -i '> Infinitivo <'         -f ": $palavra" -d ' ' |
		zzjuntalinhas -i '<u'                     -f '</u>'       -d ' ' |
		zzjuntalinhas -i 'Separação silábica:'    -f '</u>'       -d ''
	)

	for modo in $modos
	do
		echo
		case "$modo" in
		def)
			zztool eco $(echo "$conteudo" | sed -n '2 { s/<[^>]*>//g; s/^ *//; s/ *$//; p; }')
			echo "$conteudo" |
			sed '/intro-v/,/div>/d;/id="conjugacao"/q' |
			zzxml --untag |
			sed '1d; s/- /-/; s/ *:/:/;' |
			zzsqueeze |
			zztrim
		;;
		ind)
			zztool eco Indicativo
			echo "$conteudo" |
			sed -n '/"modoconjuga"> Indicativo </,/> Subjuntivo </ { /^<h3/d; /^<p/d; /p>$/d; /^<div/d; /div>$/d; p; }' |
			awk '/tempo-conjugacao-titulo/ { printf "\n\n"; print; next }
				/> tu <|> eles? <|> [nv]ós </ { print "" }
				/<br / { print ""; next }
				{ printf $0 }
			' |
			zzxml --untag |
			zztrim -H |
			zzsqueeze |
			zzcolunar -w 30 3 |
			zztrim -H
		;;
		sub)
			zztool eco Subjuntivo
			echo "$conteudo" |
			sed -n '/"modoconjuga"> Subjuntivo </,/> Imperativo </ {/^<h3/d; /^<p/d; /p>$/d; /^<div/d; /div>$/d; p; }' |
			awk '/tempo-conjugacao-titulo/ { printf "\n\n"; printf $0; next }
				/> que |> se |> quando / { print "" }
				/<br / { print ""; next }
				{ printf $0 }
			' |
			zzxml --untag |
			zztrim -H |
			zzsqueeze |
			zzcolunar -w 30 3 |
			zztrim -H
		;;
		imp)
			zztool eco Imperativo
			echo "$conteudo" |
			sed -n '/"modoconjuga"> Imperativo </,/> Infinitivo </ {/^<h3/d; /^<p/d; /p>$/d; /^<div/d; /div>$/d; p; }' |
			awk '/tempo-conjugacao-titulo/ { printf "\n\n"; print; next }
				/--|> tu <|> eles? <|> vocês? <|> [nv]ós </ { print; next }
				/<br / { print ""; next }
				{ printf $0 }
			' |
			zzxml --untag |
			zzsqueeze |
			zzcolunar -r -w 30 2 |
			zzlblank
		;;
		inf)
			zztool eco Infinitivo
			echo "$conteudo" |
			sed -n '/"modoconjuga"> Infinitivo </,/\/p>$/ {/^<h[23]/d; /^<p/d; /p>$/d; /^<div/d; /div>$/d; p; }' |
			awk '/> [et]u <|> eles? <|> [nv]ós <|tempo-conjugacao-titulo/ { print; next }
				/<br / { print ""; next }
				$0 !~ /^  *$/ { printf $0 }
			' |
			zzxml --untag |
			zzsqueeze |
			zzalinhar -r -w 30 |
			zzlblank |
			zztrim -r
		;;
		esac
	done
}

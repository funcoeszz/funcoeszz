# ----------------------------------------------------------------------------
# Exibe a descrição da função jQuery informada.
#
# Opções:
#   --categoria[s]: Lista as Categorias da funções.
#   --lista: Lista todas as funções.
#   --lista <categoria>: Listas as funções dentro da categoria informada.
#
# Caso não seja passado o nome, serão exibidas informações acerca do $().
# Se usado o argumento -s, será exibida somente a sintaxe.
# Uso: zzjquery [-s] funcao
# Ex.: zzjquery gt
#      zzjquery -s gt
#
# Autor: Felipe Nascimento Silva Pena <felipensp (a) gmail com>
# Desde: 2007-12-04
# Versão: 4
# Licença: GPL
# Requisitos: zzlimpalixo zzunescape zzxml
# ----------------------------------------------------------------------------
zzjquery ()
{
	zzzz -h jquery "$1" && return

	local url="http://api.jquery.com/"
	local url_aux
	local sintaxe=0

	case "$1" in
	--lista)

		if test -n "$2"
		then
			url_aux=$(
				$ZZWWWHTML http://api.jquery.com |
				awk '/<aside/,/aside>/{print}' |
				sed "/<ul class='children'>/,/<\/ul>/d" |
				zzxml --untag=aside --tag a |
				awk -F '"' '/href/ {printf $2 " "; getline; print}' |
				awk '$2 ~ /'$2'/ { print $1 }'
			)
			test -n "$url_aux" && url="$url_aux" || url=''
		fi

		if test -n "$url"
		then
			$ZZWWWHTML "$url" |
			sed -n '/title="Permalink to /{s/^[[:blank:]]*//;s/<[^>]*>//g;s/()//;p;}' |
			zzunescape --html
		fi

	;;
	--categoria | --categorias)

		$ZZWWWHTML "$url" |
		awk '/<aside/,/aside>/{print}' |
		sed "/<ul class='children'>/,/<\/ul>/d" |
		zzxml --tag li --untag  | zzlimpalixo | zzunescape --html

	;;
	*)
		test "$1" = "-s" && { sintaxe=1; shift; }

		if [ "$1" ]
		then
			url_aux=$(
				$ZZWWWHTML "$url" |
				sed -n '/title="Permalink to /{s/^[[:blank:]]*//;s/()//g;p;}' |
				zzunescape --html |
				awk -F '[<>"]' '{print $3, $9 }' |
				awk '$2 ~ /^[.:]{0,1}'$1'[^a-z]*$/ { print $1 }'
			)
			test -n "$url_aux" && url="$url_aux" || url=''
		else
			url=${url}jQuery
		fi

		if [ "$url" ]
		then
			for url_aux in $url
			do
				zztool eco ${url_aux#*com/} | tr -d '/'
				$ZZWWWHTML "$url_aux" |
				zzxml --tag article |
				awk '/class="entry(-content| method)"/,/<\/article>/{ print }' |
				if test "$sintaxe" = "1"
				then
					awk '/<ul class="signatures">/,/<div class="longdesc"/ { print }' | awk '/<span class="name">/,/<\/span>/ { print }; /<h4 class="name">/,/<\/h4>/ { print };'
				else
					awk '
							/<ul class="signatures">/,/(<div class="longdesc"|<section class="entry-examples")/ { if ($0 ~ /<\/h4>/ || $0 ~ /<\/span>/ || $0 ~ /<\/div>/) { print } else { printf $0 }}
							/<span class="name">/,/<\/span>/ { if ($0 ~ /<span class="name">/) { printf "--\n\n" }; print $0 }
							/<p class="desc"/,/<\/p>/ { if ($0 ~ /<\/p>/) { print } else { printf $0 }}
						'
				fi|
				zzxml --untag | zzlimpalixo |
				awk '{if ($0 ~ /: *$/) { printf $0; getline; print} else print }' |
				sed 's/version added: .*//;s/^--//g;/Type: /d'
				echo
			done
		fi

	;;
	esac
}

# ----------------------------------------------------------------------------
# Uma forma de ler o site Inovação Tecnológica.
# Sem opção mostra o resumo da página principal.
#
# Opções podem ser (ano)sub-temas e/ou número:
#
# Sub-temas podem ser:
#   eletronica, energia, espaco, informatica, materiais,
#   mecanica, meioambiente, nanotecnologia, robotica, plantao.
#  Que podem ser precedido do ano ao qual se quer listar
#
# Se a opção for um número mostra a matéria selecionada,
# seja da página principal ou de um sub-tema.
#
# Uso: zzit [[ano] sub-tema] [número]
# Ex.: zzit                 # Um resumo da página principal
#      zzit espaco          # Um resumo do sub-tem espaço
#      zzit 3               # Exibe a terceira matéria da página principal
#      zzit mecanica 7      # Exibe a sétima matéria do sub-tema mecânica
#      zzit 2003 energia    # Um resumo do sub-tema energia em 2003
#      zzit 2012 plantao 2  # Exibe a 2ª matéria de 2012 no sub-tema plantao
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2016-02-28
# Versão: 3
# Licença: GPL
# Requisitos: zzsemacento zzutf8 zzxml zzsqueeze zzdatafmt zzlinha
# ----------------------------------------------------------------------------
zzit ()
{

	zzzz -h it "$1" && return

	local url='http://www.inovacaotecnologica.com.br'
	local ano url2 opcao num

	if test -n "$1" && zztool testa_numero $1
	then
		if test "$1" -ge 2001 -a "$1" -le $(zzdatafmt -f AAAA hoje)
		then
			ano=$1
			shift
		fi
	fi

	opcao=$(echo "$1" | zzsemacento)
	case "$opcao" in
		eletronica | energia | espaco | informatica | materiais | mecanica | meioambiente | nanotecnologia | robotica | plantao )
			if test -n "$ano"
			then
				if test "$opcao" = "meioambiente" -a "$ano" -eq 2001
				then
					return
				fi
				url2="$url/noticias/${opcao}_${ano}.html"
			else
				url2="$url/noticias/assuntos.php?assunto=$opcao"
			fi
			shift ;;
		* )	url2="$url/index.php" ;;
	esac

	zztool testa_numero $1 && num=$1

	if test -n "$ano"
	then
		if test -z "$num"
		then
			zztool dump "$url2" |
			if test "$opcao" = "plantao"
			then
				sed -n '/^ *Plantão /,/- Arquivo/{ /^ *\*/!d; s/^ *\* *//; p; }'
			else
				sed -n '/^ *Notícias /,/- Arquivo/{ /^ *\*/!d; s/^ *\* *//; p; }'
			fi |
			awk '{ printf "%02d - %s\n", NR, $0 }'
		else
			url2=$(
			zztool source "$url2" | zzutf8 |
			sed -n '/Notícias /,/- Arquivo/{ /^<li>/!d; s/.*="//; s/".*//; p; }' |
			zzlinha $num
			)
			zztool eco "$url2"
			zztool dump "$url2" |
			sed '1,/^ *\* *Plantão$/d; s/ *\(Bibliografia:\)/\
\1/' |
			sed 's/\[INS: *:INS\]//g; /Outras notícias sobre:/{s///;q;}' |
			zzsqueeze | fmt -w 120
		fi
	else
		zztool source "$url2" |
		zzutf8 |
		awk '/<div id="manchete">/,/Leia mais/' |
		zzxml --untag=i --untag=u --untag=b --untag=img |
		zzxml --tag a |
		sed '/^<\/a>$/,/^<\/a>$/d;/^ *$/d;/assunto=/{N;d;}' |
		if test -z "$num"
		then
			awk 'NR % 2 == 0 { printf "%02d - %s\n", NR / 2 , $0 }'
		else
			url2=$(awk -v linha=$num 'NR == linha * 2 -1' | sed 's/">//;s/.*"//;s|\.\./||' | sed "s|^|${url}/|")
			zztool eco "$url2"
			zztool dump "$url2" |
			sed '1,/^ *\* *Plantão$/d; s/ *\(Bibliografia:\)/\
\1/' |
			sed 's/\[INS: *:INS\]//g; /Outras notícias sobre:/{s///;q;}' |
			zzsqueeze | fmt -w 120
		fi
	fi
}

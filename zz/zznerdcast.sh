# ----------------------------------------------------------------------------
# Lista os episódios do podcast NerdCast.
#
# Opções para a listagem:
#   -n <número> - Quantidade de resultados retornados (padrão = 15)
#   -d <data>   - Filtra por uma data específica.
#   -m <mês>    - Filtra por um mês específico. Sem o ano seleciona atual.
#   -a <ano>    - Filtra por um ano em específico.
#
#   Obs.: No lugar de -d, -m, -a pode usar --data, --mês ou --mes, --ano.
#         Na opção -d, <data> pode ser "hoje", "ontem" e "anteontem".
#         Na opção -n, <número> se for igual a 0, não limita a quantidade.
#
#   Opções adicionais são consideradas termos a serem filtrados na consulta.
#
# Uso: zznerdcast [-n <número>| -d <data> | -m <mês>| -a <ano>] [texto]
# Ex.: zznerdcast
#      zznerdcast -n 30
#      zznerdcast -d 28.10.16
#      zznerdcast -m 5/2014
#      zznerdcast -a 2014 Empreendedor
#      zznerdcast Terra
#
# Autor: Diogo Alexsander Cavilha <diogocavilha (a) gmail com>
# Desde: 2016-09-19
# Versão: 2
# Licença: GPL
# Requisitos: zzdatafmt zzunescape zzxml
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zznerdcast ()
{
	zzzz -h nerdcast "$1" && return

	local cache=$(zztool cache nerdcast)
	local limite='15'
	local filtro='.'
	local data

	# Opções de linha de comando
	while  test "${1#-}" != "$1"
	do
		case "$1" in
		-n)
			if zztool testa_numero "$2"
			then
				limite="$2"
				test "$limite" -eq 0 && limite='$'
				shift
			fi
			shift
		;;
		-d | --data)
			data=$(zzdatafmt --en -f "DD MMM AAAA" "$2" 2>/dev/null)
			if test -n "$data"
			then
				unset limite
				shift
			fi
			shift
		;;
		-m | --m[eê]s)
			data=$(zzdatafmt --en -f "MMM AAAA" "1/$2" 2>/dev/null)
			if test -n "$data"
			then
				unset limite
				shift
			fi
			shift
		;;
		-a | --ano)
			data=$(zzdatafmt --en -f "AAAA" "1/1/$2" 2>/dev/null)
			if test -n "$data"
			then
				unset limite
				shift
			fi
			shift
		;;
		--) shift; break ;;
		-*) zztool -e uso nerdcast; return 1 ;;
		esac
	done

	# Grepando os resultados
	test $# -gt 0 && filtro="$*"
	filtro=$(zztool endereco_sed "$filtro")

	# Usa o cache se existir e estiver atualizado, senão baixa um novo.
	if ! test -s "$cache" || test $(head -n 1 "$cache") != $(zzdatafmt --iso hoje)
	then
		zzdatafmt --iso hoje > "$cache"

		zztool source "https://jovemnerd.com.br/feed-nerdcast/" |
		zzxml --tag title --tag enclosure --tag pubDate |
		awk '
			/<title>/{ getline; if ($0 ~ /[0-9a-z] - /) printf $0 " | "}
			/\.mp3"/{ printf $2 " | " }
			/<pubDate>/{ getline; print $2,$3,$4 }
			' |
		sed '/url="/ { s///;s/"//; }' |
		zzunescape --html >> "$cache"
	fi

	# Filtra pelo assunto
	# Filtra por data ou quantidade
	# E formata  saída
	sed -n "1d;${filtro}p" "$cache" |
	if test -n "$data"
	then
		grep "${data}$"
	else
		sed "${limite}q"
	fi |
	awk -F ' [|] ' '/[|]/ { print $1,"|",$3; print $2; print "" }'
}

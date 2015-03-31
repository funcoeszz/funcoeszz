# ----------------------------------------------------------------------------
# Busca as mensagens mais recentes de um usuário do Twitter.
# Use a opção -n para informar o número de mensagens (padrão é 5, máx 20).
# Com a opção -r após o nome do usuário, lista também tweets respostas.
#
# Uso: zztweets [-n N] username [-r]
# Ex.: zztweets oreio
#      zztweets -n 10 oreio
#      zztweets oreio -r
#
# Autor: Eri Ramos Bastos <bastos.eri (a) gmail.com>
# Desde: 2009-07-30
# Versão: 8
# Licença: GPL
# ----------------------------------------------------------------------------
zztweets ()
{
	zzzz -h tweets "$1" && return

	test -n "$1" || { zztool -e uso tweets; return 1; }

	local name
	local limite=5
	local url="https://twitter.com"

	# Opções de linha de comando
	if test "$1" = '-n'
	then
		limite="$2"
		shift
		shift

		zztool -e testa_numero "$limite" || return 1
	fi

	# Informar o @ é opcional
	name=$(echo "$1" | tr -d @)
	url="${url}/${name}"
	test "$2" = '-r' && url="${url}/with_replies"

	$ZZWWWDUMP $url |
		sed '1,70 d' |
		sed '1,/ View Tweets$/d;/(BUTTON) Try again/,$d' |
		awk '
			/ @'$name'/, /\* \(BUTTON\)/ { if(NF>1) print }
			/Retweeted by /, /\* \(BUTTON\)/ { if(NF>1) print }
			/retweeted$/, /\* \(BUTTON\)/ { if(NF>1) print }' |
		sed "
			/Retweeted by /d
			/retweeted$/d
			/  ·  /{s/  ·  .*$/>:/;s/^.*@/@/}
			/@$name/d
			/(BUTTON)/d
			/View summary/d
			/View conversation/d
			/^ *YouTube$/d
			/^ *Play$/d
			/^ *View more photos and videos$/d
			/^ *Embedded image permalink$/d
			/[0-9,]\{1,\} retweets\{0,1\} [0-9,]\{1,\} favorite/d
			/Twitter may be over capacity or experiencing a momentary hiccup/d
			s/\[DEL: \(.\) :DEL\] /\1/g
			s/^ *//g
		" |
		awk '{ if (/>:$/){ sub(/>:$/,": "); printf $0; getline;print } else print }' |
		sed "$limite q" |
		sed G

	# Apagando as 70 primeiras linhas usando apenas números,
	# pois o sed do BSD capota se tentar ler o conteúdo destas
	# linhas. Leia mais no issue #28.
}

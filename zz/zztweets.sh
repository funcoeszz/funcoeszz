# ----------------------------------------------------------------------------
# Busca as mensagens mais recentes de um usuário do Twitter.
# Use a opção -n para informar o número de mensagens (padrão é 5, máx 20).
#
# Uso: zztweets [-n N] username
# Ex.: zztweets oreio
#      zztweets -n 10 oreio
#
# Autor: Eri Ramos Bastos <bastos.eri (a) gmail.com>
# Desde: 2009-07-30
# Versão: 7
# Licença: GPL
# ----------------------------------------------------------------------------
zztweets ()
{
	zzzz -h tweets "$1" && return

	[ "$1" ] || { zztool uso tweets; return 1; }

	local name
	local limite=5
	local url="https://twitter.com"

	# Opções de linha de comando
	if [ "$1" = '-n' ]
	then
		limite="$2"
		shift
		shift

		zztool -e testa_numero "$limite" || return 1
	fi

	# Informar o @ é opcional
	name=$(echo "$1" | tr -d @)

	$ZZWWWDUMP $url/$name |
		sed '1,70 d' |
		sed '1,/^Tweets/d;/^Sign in to Twitter/,$d' |
		awk '
			/@'$name'/, /\* \(BUTTON\)/ {print}
			/Retweeted by /, /\* \(BUTTON\)/ {print}' |
		sed "
			/Retweeted by /{N;d;}
			/@$name/d
			/(BUTTON)/d
			/View summary/d
			/View conversation/d
			/^[[:blank:]]*$/d
			/^ *YouTube$/d
			/^ *Play$/d
			/^ *View more photos and videos$/d
			/^ *Embedded image permalink$/d
			s/\[DEL: \(.\) :DEL\] /\1/g
			s/^ *//g
		" |
		sed "$limite q" |
		sed G

	# Apagando as 50 primeiras linhas usando apenas números,
	# pois o sed do BSD capota se tentar ler o conteúdo destas
	# linhas. Leia mais no issue #28.
}

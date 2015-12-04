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
# Versão: 9
# Licença: GPL
# Requisitos: zzsqueeze
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
		sed -n '/View Tweets/,/Back to top/p' |
		sed '1d
			/ followed *$/d
			s/ *(BUTTON) View translation *//
			/^ *(BUTTON) /d
			/ · Details *$/d
			/ tweeted yet\. *$/d
			/^   [1-9 ][0-9]\./i \

			/\. Pinned Tweet *$/{N;d;}
			/ Retweeted *$/{N;d;}
			/. Retweeted ./d
			/^    *[1-9 ][0-9]\./d
			/^ *Translated from /d
			/^ *View media/d
			/^ *View summary/d
			/^ *View conversation/d
			/^ *View more photos and videos$/d
			/^ *Embedded image permalink$/d
			/[0-9,]\{1,\} retweets\{0,1\} [0-9,]\{1,\} like/,/[o+] (BUTTON) Embed Tweet/d
			/[o+] (BUTTON) /d
			s/\[DEL: \(.\) :DEL\] /\1/g
			s/^ *//g
		' |
		zzsqueeze -l |
		sed '/. added,$/{N;d;}' |
		awk -v lim=$limite '$0 ~ /^[[:blank:]]*$/ {blanks++};{if(blanks>lim) exit; print}'

	# Apagando as 70 primeiras linhas usando apenas números,
	# pois o sed do BSD capota se tentar ler o conteúdo destas
	# linhas. Leia mais no issue #28.

	# O último sed está destacado, pois seu funcionamento no sed anterior
	# estava irregular, aplicando o comando apenas em alguns momentos.
	# Não tenho explicação para isso!
}

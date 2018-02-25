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
# Versão: 10
# Licença: GPL
# Requisitos: zzsqueeze zztrim
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

	LANG=en zztool dump $url |
		awk '/^ *@/{imp=1;next};imp' |
		sed -n '/^ *Tweets *$/,/Back to top/p' |
		sed '1,/^ *More *$/ d
			/Copy link to Tweet/d;
			/Embed Tweet/d;
			/ followed *$/d
			s/ *(BUTTON) View translation *//
			/^ *(BUTTON) */d
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
			/[0-9,]\{1,\} retweets\{0,1\} [0-9,]\{1,\} like/d #,/[o+] (BUTTON) Embed Tweet/d
			/^ *Reply *$/,/^ *More */d
			/[o+] (BUTTON) /d
			s/\[DEL: \(.\) :DEL\] /\1/g
			s/^[[:blank:]]*//g
		' |
		sed '/. added,$/{N;d;}' |
		zzsqueeze -l |
		zztrim |
		awk -v lim=$limite '
			BEGIN { print "" }
			$0 ~ /^[[:blank:]]*$/ {blanks++};{if (blanks>=lim) exit; print}
			END { print "" }
			'
}

# ----------------------------------------------------------------------------
# Envia mensagens para o twitter direto do console.
#
# Função recuperada baseada no script:
# http://360percents.com/posts/..
# ..command-line-twitter-status-update-for-linux-and-mac/
# Author: Luka Pusic <pusic93@gmail.com>
# Sugerido por Edson Ramiro Lucas Filho ( http://www.inf.ufpr.br/erlfilho/ )
#
# Uso: zztwitter [mensagem]
# Ex.: zztwitter Enviar mensagens direto do console é mais fácil.
#      zztwitter bla bla bla ...
#
# Autor: Edson Ramiro <erlfilho (a) gmail com>
# Desde: 2009-09-24
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------

zztwitter ()
{
	zzzz -h twitter "$1" && return

	local USUARIO=''
	local SENHA=''
	local cache="$ZZTMP.twitter"
	local url='https://mobile.twitter.com'
	local tweet uagent initpage token loginpage composepage tweettoken update logoutpage logouttoken logout com_curl

	if [ $( echo $* | wc -m ) -gt 140 ]
	then
		echo "Mensagem muito grande."
		echo "Com $(echo $* | wc -m) caracteres para máximo de 140."
		return 1
	elif [ $(echo $* | wc -m) -lt 2 ]
	then
		echo "Cadê a mensagem?"
		return 1
	else
		[ -z $USUARIO ] && printf %b "Usuário: " && read USUARIO
		[ -z $SENHA ] && printf '%b\n' "Senha: " && read -s SENHA

		tweet="$*"

		# EXTRA OPTIONS
		# user agent (fake a browser)
		uagent="Mozilla/5.0"

		# create a temp. cookie file
		touch $cache

		com_curl="curl -s -b $cache -c $cache -L --sslv3 -A $uagent"

		# GRAB LOGIN TOKENS
		initpage=$($com_curl "${url}/session/new")
		token=$(echo "$initpage" | grep "authenticity_token" | sed -e 's/.*value="//' | sed -e 's/" \/>.*//')

		# LOGIN
		loginpage=$($com_curl -d "authenticity_token=$token&username=$USUARIO&password=$SENHA" "${url}/session")

		# GRAB COMPOSE TWEET TOKENS
		composepage=$($com_curl "${url}/compose/tweet")

		# TWEET
		tweettoken=$(echo "$composepage" | grep "authenticity_token" | sed -e 's/.*value="//' | sed -e 's/" \/>.*//' | tail -n 1)
		update=$($com_curl -d "authenticity_token=$tweettoken&tweet[text]=$tweet&tweet[display_coordinates]=false" "${url}/")

		# GRAB LOGOUT TOKENS
		logoutpage=$($com_curl "${url}/account")

		# LOGOUT
		logouttoken=$(echo "$logoutpage" | grep "authenticity_token" | sed -e 's/.*value="//' | sed -e 's/" \/>.*//' | tail -n 1)
		logout=$($com_curl -d "authenticity_token=$logouttoken" "${url}/session/destroy")

		rm $cache
	fi
}

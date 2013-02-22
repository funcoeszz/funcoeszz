# ----------------------------------------------------------------------------
# Busca os últimos 5 tweets de um usuário.
# Uso: zztweets @username
# Ex.: zztweets @oreio
#
# Autor: Eri Ramos Bastos <bastos.eri (a) gmail.com>
# Desde: 2009-07-30
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zztweets ()
{
	zzzz -h tweets "$1" && return

	[ "$1" ] || { zztool uso tweets; return 1; }

	local url="http://twitter.com"
	local name=$(echo $1 | tr -d "@")
	local result_raw result_show

	result_raw=$($ZZWWWDUMP $url/$name)

	result_show=$(echo "$result_raw"| grep "^ *[1-5]\. ")
	test -n "$result_show" && echo "$result_show" && return

	result_show=$(echo "$result_raw"| grep "That page doesn't exist!")
	test -n "$result_show" && echo "Usuário @$name não encontrado!" && return 1

	echo "O Twitter não pôde responder essa requisição"
	return 1
}

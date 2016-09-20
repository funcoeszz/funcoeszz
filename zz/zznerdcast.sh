# ----------------------------------------------------------------------------
# Esse é pra quem é fã do nerdcast =D
# Um script simples pra listar todos os nerdcasts e facilitar o link de download.
#
# Uso: zznerdcast
# Ex.: zznerdcast
#
# Autor: Diogo Alexsander Cavilha <diogocavilha (a) gmail com>
# Desde: 2016-09-19
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zznerdcast ()
{
	zzzz -h nerdcast "$1" && return

	echo "Carregando lista de nerdcasts..."

	local feed=$(curl -s https://jovemnerd.com.br/feed-nerdcast/)

	echo $feed |
		grep -ioP "https://nerdcast.jovemnerd.com.br/\w+.mp3" |
		less
}

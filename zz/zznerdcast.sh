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
	
	curl -s https://jovemnerd.com.br/feed-nerdcast/ |
	zzxml --tag title --tag enclosure --tag pubDate |
	awk '
		/<title>/{getline;if ($0 ~ /[0-9] - /) printf $0 " | "};
		/\.mp3"/{printf $2 " | " };
		/<pubDate>/{getline; print $2,$3,$4}
	    ' |
	zzunescape --html
}

# ----------------------------------------------------------------------------
# http://vidadeprogramador.com.br
# Mostra o texto das últimas tirinhas de Vida de Programador.
# Se fornecer uma data, mostra a tirinha do dia escolhido.
# Você pode informar a data dd/mm/aaaa ou usar palavras: hoje, (ante)ontem.
# Usando a mesma sintaxe do zzdata
#
# Uso: zzvdp [data [+|- data|número<d|m|a>]]
# Ex.: zzvdp
#      zzvdp anteontem
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-25
# Versão: 5
# Licença: GPL
# Requisitos: zzunescape zzdatafmt
# ----------------------------------------------------------------------------
zzvdp ()
{
	zzzz -h vdp "$1" && return

	local url="http://vidadeprogramador.com.br"

	if [ "$1" ] && zztool testa_data $(zzdatafmt "$1")
	then
		url="${url}/"$(zzdatafmt -f 'AAAA/MM/DD' $1)
	fi

	$ZZWWWHTML $url | sed -n '/category-tirinhas/,/<\/article>/p' |
	sed -n '/<!-- post title -->/,/<!-- \/post title -->/p;/class="transcription"/,/<\/article>/p' |
	sed 's/<[^>]*>//g;s/^[[:blank:]]*//g' |
	sed '/^ *Camiseta .*/ a \
----------------------------------------------------------------------------' |
	zzunescape --html | uniq
}

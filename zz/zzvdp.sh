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
# Versão: 2
# Licença: GPL
# Requisitos: zzunescape zzdatafmt
# ----------------------------------------------------------------------------
zzvdp ()
{
	zzzz -h vdp "$1" && return

	local url="http://vidadeprogramador.com.br"
	local ano mes dia

	if [ "$1" ] && zztool testa_data $(zzdatafmt "$1")
	then
		ano=$(zzdatafmt "$1" | awk -F'/' '{print $3}')
		mes=$(zzdatafmt "$1" | awk -F'/' '{print $2}')
		dia=$(zzdatafmt "$1" | awk -F'/' '{print $1}')
		url="${url}/${ano}/${mes}/${dia}"
	fi

	$ZZWWWHTML $url |
	sed -n '/title="Link permanente para /,/title="Comentário para /p' |
	sed 's/<[^>]*>//g;/[0-9]\{1,\} resposta/d;/Tweet/d;s/^[[:blank:]]*/ /g' |
	sed 's/^ *Camiseta: .*/&\n----------------------------------------------------------------------------/g' |
	zzunescape --html | uniq
}

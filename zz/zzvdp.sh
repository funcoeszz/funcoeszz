# ----------------------------------------------------------------------------
# http://vidadeprogramador.com.br
# Mostra o texto das últimas tirinhas de Vida de Programador.
#
# Uso: zzvdp
# Ex.: zzvdp
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-25
# Versão: 1
# Licença: GPL
# Requisitos: zzunescape
# ----------------------------------------------------------------------------
zzvdp ()
{
	zzzz -h vdp "$1" && return

	$ZZWWWHTML "http://vidadeprogramador.com.br" |
	sed -n '/title="Link permanente para /,/title="Comentário para /p' |
	sed 's/<[^>]*>//g;/[0-9]\{1,\} resposta/d;/Tweet/d;s/^[[:blank:]]*/ /g' |
	sed 's/^ *Camiseta: .*/&\n----------------------------------------------------------------------------/g' |
	zzunescape --html | uniq
}

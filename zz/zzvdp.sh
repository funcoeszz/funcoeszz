# ----------------------------------------------------------------------------
# https://vidadeprogramador.com.br
# Mostra o texto das últimas tirinhas de Vida de Programador.
# Sem opção mostra a tirinha mais recente.
# Se a opção for um número, mostra a tirinha que ocupa essa ordem
# Se a opção for 0, mostra todas mais recentes
#
# Uso: zzvdp [número]
# Ex.: zzvdp    # Mostra a tirinha mais recente
#      zzvdp 5  # Mostra a quinta tirinha mais recente
#      zzvdp 0  # Mostra todas as tirinhas mais recentes
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-25
# Versão: 7
# Licença: GPL
# Requisitos: zzunescape zzxml
# ----------------------------------------------------------------------------
zzvdp ()
{
	zzzz -h vdp "$1" && return

	local url="https://vidadeprogramador.com.br"
	local sep='------------------------------------------------------------------------------'
	local ord=1

	zztool testa_numero "$1" && ord=$1

	zztool source "$url" |
	awk '
		/^ *<div.*data-title="/{titulo=$0}
		/<div class="transcription">/ {print titulo}
		/<div class="transcription">/,/<\/div>/
	' |
	sed '
		/^ *<div.*data-title="/{s/.*data-title="//;s/".*//;}
		/"transcription"/s/.*//
		s/<\/div>/----/
		' |
	zzunescape --html |
	zzxml --untag |
	if test $ord -eq 0
	then
		sed "/----/{s//$sep/;}"
	else
		awk -v ord=$ord '
			/----/{i++;next}
			{ if (i==ord-1) print; if (i==ord) {exit} }
		'
	fi

}

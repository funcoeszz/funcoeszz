# ----------------------------------------------------------------------------
# https://vidadesuporte.com.br
# Mostra o texto das últimas tirinhas de Vida de Suporte.
# Sem opção mostra a tirinha mais recente.
# Se a opção for um número, mostra a tirinha que ocupa essa ordem
# Se a opção for 0, mostra todas mais recentes
#
# Uso: zzvds [número]
# Ex.: zzvds    # Mostra a tirinha mais recente
#      zzvds 5  # Mostra a quinta tirinha mais recente
#      zzvds 0  # Mostra todas as tirinhas mais recentes
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2018-05-07
# Versão: 1
# Licença: GPL
# Requisitos: zzjuntalinhas zztrim zzunescape zzxml
# Tags: internet, distração
# ----------------------------------------------------------------------------
zzvds ()
{
	zzzz -h vds "$1" && return

	local url="https://vidadesuporte.com.br/'"
	local sep='------------------------------------------------------------------------------'
	local ord=1

	if test -n "$1"
	then
		zztool testa_numero "$1" && ord=$1 || { zztool -e uso vds; return 1; }
	fi

	zztool source "$url" |
	awk '
		/titulopost/,/<\/h2>/
		/Transcrição:/,/hidden/{print;if ($0 ~ /hidden/) printf "----\n\n"}
	' |
	zzjuntalinhas -i '<h2' -f 'h2>'|
	zzxml --untag |
	zzunescape --html |
	zztrim |
	sed 's/Transcrição://;/Flagras de Atendimento/d;/Mais tirinhas sobre/d ' |
	if test $ord -eq 0
	then
		sed "/----/{s//$sep/;}"
	else
		awk -v ord=$ord '
			/----/{i++;next}
			{ if (i==ord-1) print; if (i==ord) {exit} }
		' |
		zztrim
	fi
}

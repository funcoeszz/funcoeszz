# ----------------------------------------------------------------------------
# http://vidadeprogramador.com.br
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
# ----------------------------------------------------------------------------
zzvdp ()
{
	zzzz -h vdp "$1" && return

	local url="http://vidadeprogramador.com.br"
	local sep='------------------------------------------------------------------------------'
	local ord=1

	zztool testa_numero "$1" && ord=$1

	zztool dump  "$url" |
	sed -n "
		/^\[Vídeo\]/d
		/[0-3][0-9]\/[01][0-9]\/20[0-3][0-9] [0-2][0-9]:[0-5][0-9]$/p
		/^ *Transcrição/,/^ *tags:/{/^ *Transcrição/d;s/^ *tags:.*/$sep/;p;}
	" |
	awk '{
		if ($0 ~ / [0-3][0-9]\/[01][0-9]\/20[0-3][0-9] [0-2][0-9]:[0-5][0-9]/) {
			titulo=$0
			next
		}
		if (length(titulo)>0) { print titulo; titulo="" }
		print
	}' |
	if test $ord -eq 0
	then
		sed 's/^\[.*\] //; s/ [0-3][0-9]\/[01][0-9]\/20[0-3][0-9] [0-2][0-9]:[0-5][0-9]//;'
	else
		awk -v ord=$ord '/---/{i++;next};{if (i==ord-1) print; if (i==ord) {print;exit} }' |
		sed '1s/^\[.*\] //; 1s/ [0-3][0-9]\/[01][0-9]\/20[0-3][0-9] [0-2][0-9]:[0-5][0-9]//;' |
		sed '2,${/ [0-3][0-9]\/[01][0-9]\/20[0-3][0-9] [0-2][0-9]:[0-5][0-9]/d;}'
	fi

}

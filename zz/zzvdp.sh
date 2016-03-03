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
# Versão: 6
# Licença: GPL
# ----------------------------------------------------------------------------
zzvdp ()
{
	zzzz -h vdp "$1" && return

	local url="http://vidadeprogramador.com.br"
	local sep='------------------------------------------------------------------------------'
	local ord=1

	zztool testa_numero "$1" && ord=$1

	$ZZWWWDUMP  "$url" |
	sed -n "/^ *Transcrição/,/^ *tags:/{/^ *Transcrição/d;s/^ *tags:.*/$sep/;p;}" |
	if test $ord -eq 0
	then
		cat -
	else
		awk -v ord=$ord '/---/{i++;next};{if(i==ord-1) print; if (i==ord) {print;exit} }'
	fi

}

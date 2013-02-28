# ----------------------------------------------------------------------------
# Lista as URLs de uma dada tag de um determinado usuário.
# Obs.: Se não informada a tag, serão listadas as últimas URLs.
# Uso: zzdelicious usuario [tag]
# Ex.: zzdelicious felipensp
#      zzdelicious felipensp php
#
# Autor: Felipe Nascimento Silva Pena <felipensp (a) gmail com>
# Desde: 2007-12-04
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2013-02-28 Parou de funcionar (issue #60)
zzdelicious ()
{
	zzzz -h delicious "$1" && return

	[ "$1" ] || { zztool uso delicious; return 1; }

	$ZZWWWHTML "http://www.delicious.com/$1/$2" |
		grep 'taggedlink' |
		sed '
			# Deixa como: http://... Nome do link
			s/.*href="//
			s/" >/ /
			s|</a>||

			# Inverte a ordem e quebra a linha
			s/^\([^ ]*\) \(.*\)/\2\
\1\
/'
}

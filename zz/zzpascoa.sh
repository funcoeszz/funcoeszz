# ----------------------------------------------------------------------------
# Mostra a data do domingo de Páscoa para qualquer ano.
# Obs.: Se o ano não for informado, usa o atual.
# Regra: Primeiro domingo após a primeira lua cheia a partir de 21 de março.
# Uso: zzpascoa [ano]
# Ex.: zzpascoa
#      zzpascoa 1999
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2008-10-23
# Versão: 1
# Licença: GPL
# Tags: data
# ----------------------------------------------------------------------------
zzpascoa ()
{
	zzzz -h pascoa "$1" && return

	local dia mes a b c d e f g h i k l m p q
	local ano="$1"

	# Se o ano não for informado, usa o atual
	test -z "$ano" && ano=$(date +%Y)

	# Validação
	zztool -e testa_ano $ano || return 1

	# Algoritmo de Jean Baptiste Joseph Delambre (1749-1822)
	# conforme citado em http://www.ghiorzi.org/portug2.htm
	#
	if [ $ano -lt 1583 ]
	then
		a=$(( ano % 4 ))
		b=$(( ano % 7 ))
		c=$(( ano % 19 ))
		d=$(( (19*c + 15) % 30 ))
		e=$(( (2*a + 4*b - d + 34) % 7 ))
		f=$(( (d + e + 114) / 31 ))
		g=$(( (d + e + 114) % 31 ))

		dia=$(( g+1 ))
		mes=$f
	else
		a=$(( ano % 19 ))
		b=$(( ano / 100 ))
		c=$(( ano % 100 ))
		d=$(( b / 4 ))
		e=$(( b % 4 ))
		f=$(( (b + 8) / 25 ))
		g=$(( (b - f + 1) / 3 ))
		h=$(( (19*a + b - d - g + 15) % 30 ))
		i=$(( c / 4 ))
		k=$(( c % 4 ))
		l=$(( (32 + 2*e + 2*i - h - k) % 7 ))
		m=$(( (a + 11*h + 22*l) / 451 ))
		p=$(( (h + l - 7*m + 114) / 31 ))
		q=$(( (h + l - 7*m + 114) % 31 ))

		dia=$(( q+1 ))
		mes=$p
	fi

	# Adiciona zeros à esquerda, se necessário
	[ $dia -lt 10 ] && dia="0$dia"
	[ $mes -lt 10 ] && mes="0$mes"

	echo "$dia/$mes/$ano"
}

# ----------------------------------------------------------------------------
# http://www.babylon.com
# Tradução de uma palavra em inglês para vários idiomas.
# Francês, alemão, japonês, italiano, hebreu, espanhol, holandês e português.
# Se nenhum idioma for informado, o padrão é o português.
# Uso: zzdicbabylon [idioma] palavra   #idioma:dut fre ger heb ita jap ptg spa
# Ex.: zzdicbabylon hardcore
#      zzdicbabylon jap tree
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-02-22
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzdicbabylon ()
{
	zzzz -h dicbabylon "$1" && return

	local idioma='ptg'
	local idiomas=' dut fre ger heb ita jap ptg spa '
	local tab=$(echo -e \\t)

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso dicbabylon; return 1; }

	# O primeiro argumento é um idioma?
	if [ "${idiomas% $1 *}" != "$idiomas" ]
	then
		idioma=$1
		shift
	fi

	$ZZWWWHTML "http://online.babylon.com/cgi-bin/trans.cgi?lang=$idioma&word=$1" |
		sed "
			/OT_CopyrightStyle/,$ d
			/definition/,/<\/div>/!d
			/GA_google/d
			s/^[$tab ]*//
			s/<[^>]*>//g
			/^$/d
			N;s/\n/ /
			s/      / /
			" |
		zztool texto_em_utf8
}

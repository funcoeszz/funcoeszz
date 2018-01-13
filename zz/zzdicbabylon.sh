# ----------------------------------------------------------------------------
# http://www.babylon.com
# Tradução de uma palavra em inglês para vários idiomas.
# Francês, alemão, italiano, hebreu, espanhol, holandês e português.
# Se nenhum idioma for informado, o padrão é o português.
# Uso: zzdicbabylon [idioma] palavra   #idiomas: nl fr de he it pt es
# Ex.: zzdicbabylon hardcore
#      zzdicbabylon he tree
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-02-22
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzdicbabylon ()
{
	zzzz -h dicbabylon "$1" && return

	local idioma='pt'
	local idiomas=' nl fr de he it pt es '
	local tab=$(printf %b '\t')

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso dicbabylon; return 1; }

	# O primeiro argumento é um idioma?
	if test "${idiomas% $1 *}" != "$idiomas"
	then
		idioma=$1
		shift
	fi

	zztool source "http://bis.babylon.com/?rt=ol&tid=pop&mr=2&term=$1&tl=$idioma" |
		sed '
			/OT_CopyrightStyle/,$ d
			/div class="definition"/,/<\/div>/!d
			s/^[$tab ]*//
			s/<[^>]*>//g
			/^$/d
			N;s/\n/ /
			s/<[^>]*>//g
			s/^ *//
			s/ *$//
			s/      / /
			' |
		zztool texto_em_utf8
}

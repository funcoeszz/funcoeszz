# ----------------------------------------------------------------------------
# Informa a extensão de um arquivo.
# Obs.: Caso o arquivo não possua extensão, retorna vazio "".
# Uso: zzextensao arquivo
# Ex.: zzextensao /tmp/arquivo.txt       # resulta em "txt"
#      zzextensao /tmp/arquivo           # resulta em ""
#
# Autor: Lauro Cavalcanti de Sa <lauro (a) ecdesa com>
# Desde: 2009-09-21
# Versão: 3
# Licença: GPLv2
# Tags: arquivo, consulta
# ----------------------------------------------------------------------------
zzextensao ()
{
	zzzz -h extensao "$1" && return

	# Declara variaveis.
	local nome_arquivo extensao arquivo

	test -n "$1" || { zztool -e uso extensao; return 1; }


	arquivo="$1"

	# Extrai a extensao.
	nome_arquivo=`echo "$arquivo" | awk 'BEGIN { FS = "/" } END { print $NF }'`
	extensao=`echo "$nome_arquivo" | awk 'BEGIN { FS = "." } END { print $NF }'`
	if test "$extensao" = "$nome_arquivo" -o ".$extensao" = "$nome_arquivo" ; then
		extensao=""
	fi

	test -n "$extensao" && echo "$extensao"
}

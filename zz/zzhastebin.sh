# ----------------------------------------------------------------------------
# http://hastebin.com/
# Gera link para arquivos de texto em geral.
#
# Uso: zzhastebin [arquivo]
# Ex.: zzhastebin helloworld.sh
#
# Autor: Jones Dias <diasjones07 (a) gmail.com>
# Desde: 2015-02-12
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzhastebin ()
{

	zzzz -h hastebin "$1" && return

	test -n "$1" || { zztool -e uso hastebin; return 1; }

	# Verifica o parametro da função
	zztool arquivo_legivel "$1" || { zztool -e uso hastebin; return 1; }

	local hst="http://hastebin.com/"
	local uri
	local ext=$(basename $1 | cut -d\. -f2)

	# Retorna o ID
	uri="$(curl -s --data-binary @$1 ${hst}documents | cut -d\" -f 4)"

	# Imprime link
	echo "$hst$uri.$ext"
}

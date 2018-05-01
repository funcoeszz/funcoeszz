# ----------------------------------------------------------------------------
# Troca o conteúdo de dois arquivos, mantendo suas permissões originais.
# Uso: zztrocaarquivos arquivo1 arquivo2
# Ex.: zztrocaarquivos /etc/fstab.bak /etc/fstab
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-06-12
# Versão: 2
# Licença: GPL
# Tags: arquivo, manipulação
# ----------------------------------------------------------------------------
zztrocaarquivos ()
{
	zzzz -h trocaarquivos "$1" && return

	# Um terceiro arquivo é usado para fazer a troca
	local tmp=$(zztool mktemp trocaarquivos)

	# Verificação dos parâmetros
	test $# -eq 2 || { zztool -e uso trocaarquivos; return 1; }

	# Verifica se os arquivos existem
	zztool -e arquivo_legivel "$1" || return
	zztool -e arquivo_legivel "$2" || return

	# Tiro no pé? Não, obrigado
	test "$1" = "$2" && return

	# A dança das cadeiras
	cat "$2"   > "$tmp"
	cat "$1"   > "$2"
	cat "$tmp" > "$1"

	# E foi
	rm -f "$tmp"
	echo "Feito: $1 <-> $2"
}

# ----------------------------------------------------------------------------
# Troca o conteúdo de dois arquivos, mantendo suas permissões originais.
# Uso: zztrocaarquivos arquivo1 arquivo2
# Ex.: zztrocaarquivos /etc/fstab.bak /etc/fstab
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-06-12
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zztrocaarquivos ()
{
	zzzz -h trocaarquivos "$1" && return

	# Um terceiro arquivo é usado para fazer a troca
	local tmp="$ZZTMP.trocaarquivos.$$"

	# Verificação dos parâmetros
	[ $# -eq 2 ] || { zztool uso trocaarquivos; return 1; }

	# Verifica se os arquivos existem
	zztool arquivo_legivel "$1" || return
	zztool arquivo_legivel "$2" || return

	# Tiro no pé? Não, obrigado
	[ "$1" = "$2" ] && return

	# A dança das cadeiras
	cat "$2"   > "$tmp"
	cat "$1"   > "$2"
	cat "$tmp" > "$1"

	# E foi
	rm -f "$tmp"
	echo "Feito: $1 <-> $2"
}

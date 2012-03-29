# ----------------------------------------------------------------------------
# Retira as linhas repetidas, consecutivas ou não.
# Obs.: Não altera a ordem original das linhas, diferente do sort|uniq.
#
# Uso: zzuniq [arquivo(s)]
# Ex.: zzuniq /etc/inittab
#      cat /etc/inittab | zzuniq
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2002-06-22
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzuniq ()
{
	zzzz -h uniq "$1" && return

	# Nota: as linhas do arquivo são numeradas para guardar a ordem original

	# Arquivos via STDIN ou argumentos
	zztool file_stdin "$@" |
		cat -n  |      # Numera as linhas do arquivo
		sort -k2 -u |  # Ordena e remove duplos, ignorando a numeração
		sort -n |      # Restaura a ordem original
		cut -f 2-      # Remove a numeração

	# Versão SED, mais lenta para arquivos grandes, mas só precisa do SED
	# PATT: LINHA ATUAL \n LINHA-1 \n LINHA-2 \n ... \n LINHA #1 \n
	# sed "G ; /^\([^\n]*\)\n\([^\n]*\n\)*\1\n/d ; h ; s/\n.*//" $1
}

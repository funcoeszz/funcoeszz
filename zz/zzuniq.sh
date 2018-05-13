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
# Versão: 3
# Licença: GPL
# Tags: uniq, emulação
# ----------------------------------------------------------------------------
zzuniq ()
{
	zzzz -h uniq "$1" && return

	# Arquivos via STDIN ou argumentos
	# Dica retirada do twitter de @augustohp
	# awk '!0' imprime a linha e
	# awk '!1' ou qq número diferente de 0 não imprime a linha
	# usando arrays pós-incrementados, colocando a linha como índice,
	# apenas a primeira ocorrência de uma linha é impressa.
	# Essa versão fica de 30 a 50% mais veloz que o formato anterior
	zztool file_stdin "$@" |
		awk '!line[$0]++'

	# Versão SED, mais lenta para arquivos grandes, e só precisa do SED
	# PATT: LINHA ATUAL \n LINHA-1 \n LINHA-2 \n ... \n LINHA #1 \n
	# sed "G ; /^\([^\n]*\)\n\([^\n]*\n\)*\1\n/d ; h ; s/\n.*//" $1
}

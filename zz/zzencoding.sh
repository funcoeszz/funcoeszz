# ----------------------------------------------------------------------------
# Informa qual a codificação de um arquivo (ou texto via STDIN).
#
# Uso: zzencoding [arquivo]
# Ex.: zzencoding /etc/passwd          # us-ascii
#      zzencoding index-iso.html       # iso-8859-1
#      echo FooBar | zzencoding        # us-ascii
#      echo Bênção | zzencoding        # utf-8
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2015-03-21
# Versão: 1
# Licença: GPL
# Tags: arquivo, consulta
# ----------------------------------------------------------------------------
zzencoding ()
{
	zzzz -h encoding "$1" && return

	zztool file_stdin "$@" |
		# A opção --mime é portável, -i/-I não
		# O - pode não ser portável, mas /dev/stdin não funciona
		file -b --mime - |
		sed -n 's/.*charset=//p'
}

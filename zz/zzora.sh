# ----------------------------------------------------------------------------
# http://ora-code.com
# Retorna a descrição do erro Oracle (AAA-99999).
# Uso: zzora numero_erro
# Ex.: zzora 1234
#
# Autor: Rodrigo Pereira da Cunha <rodrigopc (a) gmail.com>
# Desde: 2005-11-03
# Versão: 6
# Licença: GPL
# Requisitos: zzurldecode
# ----------------------------------------------------------------------------
zzora ()
{
	zzzz -h ora "$1" && return

	test $# -ne 1 && { zztool -e uso ora; return 1; } # deve receber apenas um argumento
	zztool -e testa_numero "$1" || return 1 # e este argumento deve ser numérico

	local link
	local url='http://www.oracle.com/pls/db92/error_search?search'
	local cod=$(printf "%05d" $1)

	zztool source "${url}=${cod}" |
	sed -n "/to_URL.*-${cod}/{s/.*name=//;s/\">.*//;p;}" |
	zzurldecode |
	while read link
	do
		zztool dump "$link" |
		sed -n "/^ *[A-Z0-9]\{1,\}-$cod/,/-[0-9]\{5\}[^0-9]/p" |
		sed '/___/,$d; 2,${ /-[0-9]\{5\}[^0-9]/d; }' |
		sed '1s/^ *//; 2,$s/^  */  /'
		echo
	done | awk '
			/^[ 	]*$/{ branco++ }

			! /^[ 	]*$/ {
				if (branco==1) { print ""; branco=0 }
				else if (branco>1)  {
					print "===================================================================================================="
					print ""; branco=0
				}
				print
			}
		'
}

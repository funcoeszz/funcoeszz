# ----------------------------------------------------------------------------
# http://ora-code.com
# Retorna a descrição do erro Oracle (ORA-NNNNN).
# Uso: zzora numero_erro
# Ex.: zzora 1234
#
# Autor: Rodrigo Pereira da Cunha <rodrigopc (a) gmail.com>
# Desde: 2005-11-03
# Versão: 5
# Licença: GPL
# ----------------------------------------------------------------------------
zzora ()
{
	zzzz -h ora "$1" && return

	test $# -ne 1 && { zztool -e uso ora; return 1; } # deve receber apenas um argumento
	zztool -e testa_numero "$1" || return 1 # e este argumento deve ser numérico

	local url="http://ora-$1.ora-code.com"

	zztool dump "$url" | sed '
		s/  //g
		s/^ //
		/^$/ d
		/Subject Replies/,$d
		1,5d
		s/^Cause:/\
Cause:/
		s/^Action:/\
Action:/
		/Google Search/,$d
		/^o /d
		/\[1\.gif\]/,$d
		'
}

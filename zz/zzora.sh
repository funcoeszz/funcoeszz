# ----------------------------------------------------------------------------
# http://ora-code.com
# Retorna a descrição do erro Oracle (ORA-NNNNN).
# Uso: zzora numero_erro
# Ex.: zzora 1234
#
# Autor: Rodrigo Pereira da Cunha <rodrigopc (a) gmail.com>
# Desde: 2005-11-03
# Versão: 4
# Licença: GPL
# ----------------------------------------------------------------------------
zzora ()
{
	zzzz -h ora "$1" && return

	[ $# -ne 1 ] && { zztool uso ora; return 1; } # deve receber apenas um argumento
	zztool -e testa_numero "$1" || return 1 # e este argumento deve ser numérico

	local url="http://ora-$1.ora-code.com"

	$ZZWWWDUMP "$url" | sed '
		s/  //g
		s/^ //
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
	return 0
}

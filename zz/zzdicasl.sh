# ----------------------------------------------------------------------------
# http://www.dicas-l.unicamp.br
# Procura por dicas sobre determinado assunto na lista Dicas-L.
# Obs.: As opções do grep podem ser usadas (-i já é padrão).
# Uso: zzdicasl [opção-grep] palavra(s)
# Ex.: zzdicasl ssh
#      zzdicasl -w vi
#      zzdicasl -vEw 'windows|unix|emacs'
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2001-08-08
# Versão: 2
# Licença: GPL
# Requisitos: zzutf8
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzdicasl ()
{
	zzzz -h dicasl "$1" && return

	local opcao_grep
	local url='http://www.dicas-l.com.br/arquivo/'

	# Guarda as opções para o grep (caso informadas)
	test -n "${1##-*}" || {
		opcao_grep=$1
		shift
	}

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso dicasl; return 1; }

	# Faz a consulta e filtra o resultado
	zztool eco "$url"
	zztool source "$url" |
		zzutf8 |
		grep -i $opcao_grep "$*" |
		sed -n 's@^<LI><A HREF=/arquivo/\([^>]*\)> *\([^ ].*\)</A>@\1@p'
}

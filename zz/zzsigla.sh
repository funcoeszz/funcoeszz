# ----------------------------------------------------------------------------
# http://www.acronymfinder.com
# Dicionário de siglas, sobre qualquer assunto (como DVD, IMHO, WYSIWYG).
# Obs.: Há um limite diário de consultas por IP, pode parar temporariamente.
# Uso: zzsigla sigla
# Ex.: zzsigla RTFM
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2002-02-21
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzsigla ()
{
	zzzz -h sigla "$1" && return

	local url=http://www.acronymfinder.com/af-query.asp

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso sigla; return 1; }

	# Pesquisa, baixa os resultados e filtra
	$ZZWWWDUMP "$url?String=exact&Acronym=$1&Find=Find" |
		grep '\*\*\*\*' |
		sed '
			s/more info from.*//
			s/\[[a-z0-9]*\.gif\]//
			s/  *$//
			s/^ *\*\** *//'
}

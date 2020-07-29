# ----------------------------------------------------------------------------
# http://www.acronymfinder.com
# Dicionário de siglas, sobre qualquer assunto (como DVD, IMHO, WYSIWYG).
# Obs.: Há um limite diário de consultas por IP, pode parar temporariamente.
# Uso: zzsigla sigla
# Ex.: zzsigla RTFM
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2002-02-21
# Versão: 3
# Licença: GPL
# Requisitos: zztrim
# Tags: internet, dicionário
# ----------------------------------------------------------------------------
zzsigla ()
{
	zzzz -h sigla "$1" && return

	local url='http://www.acronymfinder.com/af-query.asp'

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso sigla; return 1; }

	local sigla=$1
	# Pesquisa, baixa os resultados e filtra
	# O novo retorno do site retorna todas as opções com três espaços
	#  antes da sigla, e vários ou um espaço depois dependendo do
	#  tamanho da sigla. Assim, o grep utiliza aspas duplas para entender
	#  a filtragem
	zztool dump "$url?acronym=$sigla" |
		grep -i "   $sigla " |
		zztrim -l |
		sed 's/  */   /; s/ *$//'
}

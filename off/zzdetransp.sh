# ----------------------------------------------------------------------------
# http://www.detran.sp.gov.br
# Consulta débitos do veículo, como licenciamento, IPVA e multas (Detran-SP).
# Uso: zzdetransp número-renavam
# Ex.: zzdetransp 123456789
#
# Autor: Elton Simões Baptista <elton (a) inso com br>
# Desde: 2001-12-06
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2013-02-24 URL não encontrada (404)
zzdetransp ()
{
	zzzz -h detransp "$1" && return

	local url='http://www.detran.sp.gov.br/multas-site/detran/resultMultas.asp'

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso detransp; return 1; }

	# Faz a consulta e filtra o resultado
	echo "renavam=$1&submit=Pesquisar" |
		$ZZWWWPOST "$url" |
		sed '
			1d
			s/^  *//
			/^\[/d
			/^Esta pesquisa tem /, $ d'
}

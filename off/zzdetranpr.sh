# ----------------------------------------------------------------------------
# http://www.pr.gov.br/detran
# Consulta débitos do veículo, como licenciamento, IPVA e multas (Detran-PR).
# Uso: zzdetranpr número-renavam
# Ex.: zzdetranpr 123456789
#
# Autor: Aurélio Marinho Jargas, www.aurelio.net
# Desde: 2001-02-14
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2008-03-01 Agora a consulta é travada com CAPTCHA
zzdetranpr ()
{
	zzzz -h detranpr $1 && return

	local url='http://celepar7.pr.gov.br/detran_novo/consultas/veiculos/deb_novo.asp'

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso detranpr; return; }

	# Faz a consulta e filtra o resultado (usando magia negra)
	$ZZWWWDUMP "$url?ren=$1" |
		sed 's/^  *//' |
		sed '
			# Remove linhas em branco
			/^$/ d

			# Transforma barra horizontal em linha em branco
			s/___*//

			# Apaga a lixarada
			1,/^Data: / d
			/^Informa..es do Ve.culo/ d
			/^Discrimina..o dos D.bitos/ d
			/\[BUTTON\]/,$ d
			/^Discrimina..o das Multas/,/^Resumo das Multas/ d

			# Quebra a linha para dados da segunda coluna da tabela
			s/Renavam:/@&/
			s/Ano de Fab/@&/
			s/Combust.vel:/@&/
			s/Cor:/@&/
			' |
		tr @ '\n'
}

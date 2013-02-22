# ----------------------------------------------------------------------------
# http://economia.terra.com.br
# Busca a cotação do dia do dólar (comercial, turismo e PTAX).
# Uso: zzdolar
# Ex.: zzdolar
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-02-22
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
zzdolar ()
{
	zzzz -h dolar "$1" && return

	# Faz a consulta e filtra o resultado
	$ZZWWWDUMP 'http://economia.terra.com.br/stock/divisas.aspx' |
		egrep  'Dólar (Comercial|Turismo|PTAX)»' |
		sed 3q |
		sed '
			# Linha original:
			# Dólar Comercial» DOLCM   1,9733 1,9738 0,00 -0,03 %  03h09

			# faxina
			s/^  *Dólar //
			s/»/ /

			# espaçamento dos valores
			s/ [0-9],[0-9][0-9][0-9][0-9]/  &/g

			# remove variação percentual 
			s/ -\{0,1\}[0-9],[0-9][0-9] .*%  */   /
		'
	echo '                     compra   venda'
}

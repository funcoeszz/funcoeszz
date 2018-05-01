# ----------------------------------------------------------------------------
# http://economia.uol.com.br/cotacoes
# Busca a cotação do dia do dólar (comercial, turismo).
# Uso: zzdolar
# Ex.: zzdolar
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-02-22
# Versão: 8
# Licença: GPL
# Requisitos: zzjuntalinhas zzsqueeze zztrim zzxml
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzdolar ()
{
	zzzz -h dolar "$1" && return

	# Faz a consulta e filtra o resultado
	zztool source 'http://economia.uol.com.br/cotacoes' |
	zzxml --tidy |
	sed -n '/<table class="borda mod-grafico-wide quatro-colunas">/,/table>/p' |
	zzjuntalinhas -i '<tr>' -f '</tr>' |
	zzjuntalinhas -i '<caption' -f 'caption>' |
	zzxml --untag |
	zzsqueeze |
	zztrim |
	sed -n '/Dólar /{s///;s/comercial - //;s/com\./Comercial/;s/tur\./Turismo/;s/ /	/g;p;}' |
	sed '$s/	/		/;1a \		Compra	Venda	Variação'
}

# ----------------------------------------------------------------------------
# http://cotacoes.agronegocios-e.com.br/
# Busca a cotação atual do EURO com relação ao Dólar e ao Real.
# Uso: zzeuro
# Ex.: zzeuro
#
# Autor: Kyller Costa Gorgônio <kyllercg (a) gmail com>
# Desde: 2006-01-10
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2013-02-28 Parou de funcionar (issue #64)
zzeuro ()
{
	zzzz -h euro "$1" && return

	$ZZWWWDUMP 'http://cotacoes.agronegocios-e.com.br/investimentos/conteudoi.asp?option=dolar&title=%20Euro' |
		tee /tmp/z |
		sed '
			s/^ *//
			/Compra/,/Euro x D/!d
			/^D.*/d
			s/Compra/                 Compra/g'
}

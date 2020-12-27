# ----------------------------------------------------------------------------
# http://economia.uol.com.br/cotacoes
# Busca a cotação do dia do dólar (comercial, turismo).
# Uso: zzdolar
# Ex.: zzdolar
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-02-22
# Versão: 9
# Licença: GPL
# Requisitos: zzcotacao
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzdolar()
{
	zzzz -h dolar "$1" && return

	zzcotacao |
		sed -n '2{s/      //;p;};s/Dólar //;/Comercial/p;/Turismo/p'
}

#!/bin/bash
source /usr/local/bin/funcoeszz
ZZPATH=$PWD/zzeuro.sh

# ----------------------------------------------------------------------------
# http://economia.uol.com.br/cotacoes
# Busca a cotação do Euro do dia.
# Uso: zzeuro
# Ex.: zzeuro
#
# Autor:  Kemel Zaidan, kemelzaidan.com.br
# Desde: 2016-11-11
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzeuro ()
{
	zzzz -h euro "$1" && return

	# Faz a consulta e filtra o resultado
	lynx --dump 'http://economia.uol.com.br/cotacoes' |
		tr -s ' ' |
		egrep  -E 'Euro |Dólar comercial' |
		sed '
			# Linha original:
			# CAPTION: [71]Dólar comercial - 11/11/2016 15h09
 			# [75]Euro 3,7092 3,7129 +0,57%

			# faxina
			s/\[[0-9][0-9]\]//
			s/\sCAPTION: Dólar comercial -/  Compra Venda Variação/
			s/\s//' |
		tr ' ' '\t '
}

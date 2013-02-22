# ----------------------------------------------------------------------------
# Consulta débitos do veículo, como licenciamento, IPVA e multas (Detran-ES).
# Uso: zzdetranes número-renavam
# Ex.: zzdetranes 123456789
#
# Autor: Kl0nEz <kl0nez (a) wifi org br>
# Desde: 2005-02-23
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2010-12-22 O endereço está retornando um IFRAME.
zzdetranes ()
{
	zzzz -h detranes $1 && return

	local URL='http://www2.detran.es.gov.br:8080'
	local request="ANO=2005&RENAVAM=$1&SALVO_InfoRule=DetranES_Licenciamento(ANO,RENAVAM,PLACA)"

	[ "$1" ] || { zztool uso detranes; return; }

	echo "$request" | $ZZWWWPOST "$URL"
}

# ----------------------------------------------------------------------------
# http://sistemas.anatel.gov.br/SIPT/Atualizacao/N_ConsultaTarifas/tela.asp
# Busca as tarifas das operadoras no plano básico para ligações DDD.
# Uso: zzanatel DDD_Origem Prefixo_Origem DDD_Destino Prefixo_Destino
# Ex.: zzanatel 48 3224 12 3943
#
# Autor: Rafael Machado Casali <rmcasali (a) gmail com>
# Desde: 2005-04-14
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2013-02-28 Parou de funcionar (issue #48)
zzanatel ()
{
	zzzz -h anatel "$1" && return

	[ "$1" ] || { zztool uso anatel; return 1; }

	local URL='http://sistemas.anatel.gov.br/SIPT/Atualizacao/N_ConsultaTarifas/tela.asp'

	case "`date +%u`" in
		0)
			PERIODO='d';;
		6)
			PERIODO='b';;
		*)
			PERIODO='s';;
	esac
	echo "acao=c&pCNOrigem=$1&pPrefixoOrigem=$2&pCNDestino=$3&pPrefixoDestino=$4&pPeriodo=$PERIODO&pConsulta=2&LDN=true" |
	$ZZWWWPOST $URL |
	sed 's/[ ]*\([0-9][0-9]:\)/\1/g' |
	sed '/^[0-9]/!d'
}

# ----------------------------------------------------------------------------
# http://www.receita.fazenda.gov.br
# Consulta os lotes de restituição do imposto de renda.
# Obs.: Funciona para os anos de 2001, 2002 e 2003.
# Uso: zzirpf ano número-cpf
# Ex.: zzirpf 2003 123.456.789-69
#
# Autor: Rodrigo Stulzer Lopes, www.stulzer.net
# Desde: 2001-08-09
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2008-03-01 Agora a consulta é travada com CAPTCHA
zzirpf ()
{
	zzzz -h irpf $1 && return
	
	local url='http://www.receita.fazenda.gov.br/Scripts/srf/irpf'
	local ano=$1
	local z=${ano#200}

	# Verificação dos parâmetros
	[ "$2" ] || { zztool uso irpf; return; }
	
	[ "$z" != 1 -a "$z" != 2 -a "$z" != 3 ] && {
		echo "Ano inválido '$ano'. Deve ser 2001, 2002 ou 2003."
		return
	}
	$ZZWWWDUMP "$url/$ano/irpf$ano.dll?VerificaDeclaracao&CPF=$2" |
		sed '1,8d; s/^ */  /; /^  \[BUTTON\]/,$d'
}

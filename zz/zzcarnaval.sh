# ----------------------------------------------------------------------------
# Mostra a data da terça-feira de Carnaval para qualquer ano.
# Obs.: Se o ano não for informado, usa o atual.
# Regra: 47 dias antes do domingo de Páscoa.
# Uso: zzcarnaval [ano]
# Ex.: zzcarnaval
#      zzcarnaval 1999
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2008-10-23
# Versão: 1
# Licença: GPL
# Requisitos: zzdata zzpascoa
# Tags: data
# ----------------------------------------------------------------------------
zzcarnaval ()
{
	zzzz -h carnaval "$1" && return

	local ano="$1"

	# Se o ano não for informado, usa o atual
	test -z "$ano" && ano=$(date +%Y)

	# Validação
	zztool -e testa_ano $ano || return 1

	# Ah, como é fácil quando se tem as ferramentas certas ;)
	zzdata $(zzpascoa $ano) - 47
}

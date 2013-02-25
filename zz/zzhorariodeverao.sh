# ----------------------------------------------------------------------------
# Mostra as datas de início e fim do horário de verão.
# Obs.: Ano de 2008 em diante. Se o ano não for informado, usa o atual.
# Regra: 3º domingo de outubro/fevereiro, exceto carnaval (4º domingo).
# Uso: zzhorariodeverao [ano]
# Ex.: zzhorariodeverao
#      zzhorariodeverao 2009
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2008-10-24
# Versão: 1
# Licença: GPL
# Requisitos: zzcarnaval zzdata zzdiadasemana
# Tags: data
# ----------------------------------------------------------------------------
zzhorariodeverao ()
{
	zzzz -h horariodeverao "$1" && return

	local inicio fim data domingo_carnaval
	local dias_3a_semana="15 16 17 18 19 20 21"
	local ano="$1"

	# Se o ano não for informado, usa o atual
	test -z "$ano" && ano=$(date +%Y)

	# Validação
	zztool -e testa_ano "$ano" || return 1

	# Só de 2008 em diante...
	if test "$ano" -lt 2008
	then
		echo 'Antes de 2008 não havia regra fixa para o horário de verão'
		return 1
	fi

	# Encontra os dias de início e término do horário de verão.
	# Sei que o algoritmo não é eficiente, mas é simples de entender.
	#
	for dia in $dias_3a_semana
	do
		data="$dia/10/$ano"
		test $(zzdiadasemana $data) = 'domingo' && inicio="$data"

		data="$dia/02/$((ano+1))"
		test $(zzdiadasemana $data) = 'domingo' && fim="$data"
	done

	# Exceção à regra: Se o domingo de término do horário de verão
	# coincidir com o Carnaval, adia o término para o próximo domingo.
	#
	domingo_carnaval=$(zzdata $(zzcarnaval $((ano+1)) ) - 2)
	test "$fim" = "$domingo_carnaval" && fim=$(zzdata $fim + 7)

	# Datas calculadas, basta mostrar o resultado
	echo "$inicio"
	echo "$fim"
}

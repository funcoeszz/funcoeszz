# ----------------------------------------------------------------------------
# Converte horas em minutos.
# Obs.: Se não informada a hora, usa o horário atual para o cálculo.
# Uso: zzhoramin [hh:mm]
# Ex.: zzhoramin
#      zzhoramin 10:53       # Retorna 653
#      zzhoramin -10:53      # Retorna -653
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2008-12-05
# Versão: 4
# Licença: GPLv2
# Requisitos: zzhora zztestar
# Tags: tempo, conversão
# ----------------------------------------------------------------------------
zzhoramin ()
{

	zzzz -h horamin "$1" && return

	local mintotal hh mm hora operacao

	operacao='+'

	# Testa se o parâmetro passado é uma hora valida
	if ! zztestar hora "${1#-}"; then
		hora=$(zzhora agora | cut -d ' ' -f 1)
	else
		hora="$1"
	fi

	# Verifica se a hora é positiva ou negativa
	if test "${hora#-}" != "$hora"; then
		operacao='-'
	fi

	# passa a hora para hh e minuto para mm
	hh="${hora%%:*}"
	mm="${hora##*:}"

	# Retira o zero das horas e minutos menores que 10
	hh="${hh#0}"
	mm="${mm#0}"

	# Se tiver algo faltando, salva como zero
	hh="${hh:-0}"
	mm="${mm:-0}"

	# faz o cálculo
	mintotal=$(($hh * 60 $operacao $mm))

	# Tcharã!!!!
	echo "$mintotal"
}

# ----------------------------------------------------------------------------
# Gera um número aleatório, conforme o $RANDOM no bash.
# Sem argumentos, comporta-se igual a $RANDOM.
# Apenas um argumento, número entre 0 e o valor fornecido.
# Com dois argumentos, número entre esses limites dados.
#
# Uso: zzaleatorio [numero] [numero]
# Exemplo: zzaleatorio 10
#          zzaleatorio 5 15
#          zzaleatorio
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-13
# Versão: 1
# Licença: GPL
# Requisitos: zzvira
# ----------------------------------------------------------------------------
zzaleatorio ()
{
	zzzz -h aleatorio "$1" && return

	local inicio=0
	local fim=32767
	local v_temp

	# Se houver só um número, entre 0 e o número
	[ "$1" ] && fim="$1"

	# Se houver dois números, entre o primeiro e o segundo
	[ "$2" ] && inicio="$1" fim="$2"

	# Verificações básicas
	zztool testa_numero "$inicio" || return 1
	zztool testa_numero "$fim"    || return 1

	# Se ambos são iguais, retorna o próprio número
	[ "$inicio" = "$fim" ] && { echo "$fim"; return 0; }

	# Se o primeiro é maior, inverte a posição
	if test "$inicio" -gt "$fim"
	then
		v_temp="$inicio"
		inicio="$fim"
		fim="$v_temp"
	fi

	# Usando o awk, sendo o gerador randômico semeado pelo inverso do número dos nanos segundos
	echo "$(date +%N | zzvira) $inicio $fim"|awk '{ srand($1); printf "%.0f\n", $2 + rand()*($3 - $2) }'
}

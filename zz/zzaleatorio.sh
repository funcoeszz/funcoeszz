# ----------------------------------------------------------------------------
# Gera um número aleatório, conforme o $RANDOM no bash.
# Sem argumentos, comporta-se igual a $RANDOM.
# Apenas um argumento, número entre 0 e o valor fornecido.
# Com dois argumentos, número entre esses limites dados.
#
# Uso: zzaleatorio [numero] [numero]
# Ex.: zzaleatorio 10
#      zzaleatorio 5 15
#      zzaleatorio
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-13
# Versão: 4
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

	# Usando o dispositivo /dev/urandom
	v_temp=$(od -An -N2 -i /dev/urandom)

	# Se não estiver disponível, usa o dispositivo /dev/random
	zztool testa_numero $v_temp || v_temp=$(od -An -N2 -i /dev/random)

	# Se não estiver disponível, usa o tempo em nanosegundos
	zztool testa_numero $v_temp || v_temp=$(date +%N)

	if zztool testa_numero $v_temp
	then
		# Se um dos casos acima atenderem, usa essa chamada
		echo "$(zzvira $v_temp) $inicio $fim" | awk '{ srand($1); printf "%.0f\n", $2 + rand()*($3 - $2) }'
	else
		# Se não estiver disponível, a data e tempo do atual que é padrão
		echo "$inicio $fim" | awk '{ srand(); printf "%.0f\n", $1 + rand()*($2 - $1) }'
		# Aguarda 1 segundo, para garantir aleatoriedade no caso
		sleep 1
	fi
}

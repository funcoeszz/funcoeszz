# ----------------------------------------------------------------------------
# Mostra uma seqüência numérica, um número por linha, ou outro formato.
# É uma emulação do comando seq, presente no Linux.
# Opções:
#   -f    Formato de saída (printf) para cada número, o padrão é '%d\n'
# Uso: zzseq [-f formato] [número-inicial [passo]] número-final
# Ex.: zzseq 10                   # de 1 até 10
#      zzseq 5 10                 # de 5 até 10
#      zzseq 10 5                 # de 10 até 5 (regressivo)
#      zzseq 0 2 10               # de 0 até 10, indo de 2 em 2
#      zzseq 10 -2 0              # de 10 até 0, indo de 2 em 2
#      zzseq -f '%d:' 5           # 1:2:3:4:5:
#      zzseq -f '%0.4d:' 5        # 0001:0002:0003:0004:0005:
#      zzseq -f '(%d)' 5          # (1)(2)(3)(4)(5)
#      zzseq -f 'Z' 5             # ZZZZZ
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2002-12-06
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzseq ()
{
	zzzz -h seq "$1" && return

	local operacao='+'
	local inicio=1
	local passo=1
	local formato='%d\n'
	local fim i

	# Se tiver -f, guarda o formato e limpa os argumentos
	if test "$1" = '-f'
	then
		formato="$2"
		shift
		shift
	fi

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso seq; return 1; }

	# Se houver só um número, vai "de um ao número"
	fim="$1"

	# Se houver dois números, vai "do primeiro ao segundo"
	[ "$2" ] && inicio="$1" fim="$2"

	# Se houver três números, vai "do primeiro ao terceiro em saltos"
	[ "$3" ] && inicio="$1" passo="$2" fim="$3"

	# Verificações básicas
	zztool -e testa_numero_sinal "$inicio" || return 1
	zztool -e testa_numero_sinal "$passo"  || return 1
	zztool -e testa_numero_sinal "$fim"    || return 1
	if test "$passo" -eq 0
	then
		echo "O passo não pode ser zero."
		return 1
	fi

	# Internamente o passo deve ser sempre positivo para simplificar
	# Assim mesmo que o usuário faça 0 -2 10, vai funcionar
	[ "$passo" -lt 0 ] && passo=$((0 - passo))

	# Se o primeiro for maior que o segundo, a contagem é regressiva
	[ "$inicio" -gt "$fim" ] && operacao='-'

	# Loop que mostra o número e aumenta/diminui a contagem
	i="$inicio"
	while (
		test "$inicio" -lt "$fim" -a "$i" -le "$fim" ||
		test "$inicio" -gt "$fim" -a "$i" -ge "$fim")
	do
		printf "$formato" "$i"
		i=$(($i $operacao $passo))  # +n ou -n
	done

	# Caso especial: início e fim são iguais
	test "$inicio" -eq "$fim" && echo "$inicio"
}

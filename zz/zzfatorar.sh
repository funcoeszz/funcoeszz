# ----------------------------------------------------------------------------
# http://www.primos.mat.br/primeiros_10000_primos.txt
# Fatora um número em fatores primos.
# Com as opções:
#   --atualiza: força o cache ser atualizado.
#   --bc: saída apenas da expressão, que pode ser usado no bc, awk ou etc.
#   --no-bc: saída apenas do fatoramento.
#    por padrão exibe tanto o fatoramento como a expressão.
#
# Se o número for primo, é exibido a mensagem apenas.
#
# Uso: zzfatorar [--atualiza] [--bc|--no-bc] <numero>
# Ex.: zzfatorar 1458
#      zzfatorar --bc 1296
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-14
# Versão: 1
# Licença: GPL
# Requisitos: zzjuntalinhas
# ----------------------------------------------------------------------------
zzfatorar ()
{
	zzzz -h fatorar "$1" && return

	local url='http://www.primos.mat.br/primeiros_10000_primos.txt'
	local cache="$ZZTMP.fatorar"
	local linha_atual=1
	local primo_atual=2
	local bc=0
	local num_atual saida tamanho indice

	[ "$1" ] || { zztool uso fatorar; return 1; }

	while  [ "${1#-}" != "$1" ]
	do
		case "$1" in
		'--atualiza')
			# Força atualizar o cache
			rm -f "$cache"
			shift
		;;
		'--bc')
			# Apenas sai a expressão matemática que pode ser usado no bc ou awk
			[ "$bc" -eq 0 ] && bc=1
			shift
		;;
		'--no-bc')
			# Apenas sai a fatoração
			[ "$bc" -eq 0 ] && bc=2
			shift
		;;
		*) break;;
		esac
	done

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWDUMP "$url" | awk '{for(i=1;i<=NF;i++) print $i }' > "$cache"
	fi

	# Apenas para numeros inteiros
	if zztool testa_numero "$1" && test $1 -ge 2
	then
		# Se o número fornecido for primo, retorna-o e sai
		grep "^${1}$" ${cache} > /dev/null
		[ "$?" = "0" ] && { echo " $1 é um número primo."; return; }

		num_atual="$1"
		tamanho=$((${#1} + 1))

		# Enquanto a resultado for maior que o número primo continua, ou dentro das 10000 primos listados
		while [ ${num_atual} -gt ${primo_atual} -a ${linha_atual} -le 10000 ]
		do

			# Repetindo a divisão pelo número primo atual, enquanto for exato
			while [ $((${num_atual} % ${primo_atual})) -eq 0 ]
			do
				[ "$bc" != "1" ] && printf "%${tamanho}s | %s\n" ${num_atual} ${primo_atual}
				num_atual=$((${num_atual} / ${primo_atual}))
				saida="${saida} ${primo_atual}"
				[ "$bc" != "1" -a "${num_atual}" = "1" ] && { printf "%${tamanho}s |\n" 1; break; }
			done

			# Se o número atual é primo
			grep "^${num_atual}$" ${cache} > /dev/null
			if [ "$?" = "0" ]
			then
				saida="${saida} ${num_atual}"
				if [ "$bc" != "1" ]
				then
					printf "%${tamanho}s | %s\n" ${num_atual} ${num_atual}
					printf "%${tamanho}s |\n" 1
				fi
				break
			fi

			# Definindo o número primo a ser usado
			linha_atual=$((${linha_atual} + 1))
			primo_atual=$(sed -n "${linha_atual}p" "$cache")
			[ ${#primo_atual} -eq 0 ] && { zztool eco " Valor não fatorável nesse script!"; return 1; }
		done

		if [ "$bc" != "2" ]
		then
			saida=$(echo "$saida " | sed 's/ /&\n/g'| sed '/^ *$/d;s/^ */ /g' |
			uniq -c | awk '{ if ($1==1) {print $2} else {print $2 "^" $1} }' | zzjuntalinhas -d ' * ')
			[ "$bc" -eq "1" ] || echo
			echo " $1 = $saida"
		fi
	fi
}

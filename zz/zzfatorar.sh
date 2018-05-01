# ----------------------------------------------------------------------------
# Fatora um número em fatores primos.
# Com as opções:
#   --bc: saída apenas da expressão, que pode ser usado no bc, awk ou etc.
#   --no-bc: saída apenas do fatoramento.
#    por padrão exibe tanto o fatoramento como a expressão.
#
# Se o número for primo, é exibido a mensagem apenas.
#
# Uso: zzfatorar [--bc | --no-bc] <número>
# Ex.: zzfatorar 1458
#      zzfatorar --bc 1296
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-14
# Versão: 4
# Licença: GPL
# Requisitos: zzjuntalinhas zzdivisores
# Tags: número, cálculo
# Nota: opcional factor
# ----------------------------------------------------------------------------
zzfatorar ()
{
	zzzz -h fatorar "$1" && return

	local cache=$(zztool cache fatorar)
	local linha_atual=1
	local primo_atual=2
	local bc=0
	local num_atual saida tamanho indice linha

	test -n "$1" || { zztool -e uso fatorar; return 1; }

	while  test "${1#-}" != "$1"
	do
		case "$1" in
		--bc)
			# Apenas sai a expressão matemática que pode ser usado no bc ou awk
			test "$bc" -eq 0 && bc=1
			shift
		;;
		--no-bc)
			# Apenas sai a fatoração
			test "$bc" -eq 0 && bc=2
			shift
		;;
		*) break;;
		esac
	done

	# Apenas para numeros inteiros
	if zztool testa_numero "$1" && test $1 -ge 2
	then

		if which factor >/dev/null 2>&1
		then
			# Se existe o camando factor usa-o
			factor $1 | sed 's/.*: //g' | awk '{for(i=1;i<=NF;i++) print $i }' | uniq > "$cache"
		else
			# Aqui lista todos os divisores do número informado não considerando o 1
			# E descobre entre os divisores, quem é primo usando zzdivisores novamente.
			# Aqueles que tiverem apenas 2 divisores (primos) são mantidos, além do próprio número.
			zzdivisores $1 |
			tr ' ' '\n' |
			sed '1d; $!{ /.\{1,\}[024568]$/d; }' |
			while read linha
			do
				zzdivisores $linha | awk 'NF==2 {print $2}'
			done > "$cache"
		fi
		primo_atual=$(head -n 1 "$cache")

		# Se o número fornecido for primo, retorna-o e sai
		grep "^${1}$" ${cache} > /dev/null
		test "$?" = "0" && { echo "$1 é um número primo."; return; }

		num_atual="$1"
		tamanho=${#1}

		# Enquanto a resultado for maior que o número primo continua, ou dentro dos primos listados no cache.
		while test ${num_atual} -gt ${primo_atual} -a ${linha_atual} -le $(zztool num_linhas "$cache")
		do

			# Repetindo a divisão pelo número primo atual, enquanto for exato
			# e ecoando a fatoração formatada
			while test $((${num_atual} % ${primo_atual})) -eq 0
			do
				test "$bc" != "1" && printf "%${tamanho}s | %s\n" ${num_atual} ${primo_atual}
				num_atual=$((${num_atual} / ${primo_atual}))
				saida="${saida} ${primo_atual}"
				test "$bc" != "1" -a "${num_atual}" = "1" && { printf "%${tamanho}s |\n" 1; break; }
			done

			# Se o número atual é primo finaliza a fatoração
			# ecoando os 2 últimos elementos
			grep "^${num_atual}$" ${cache} > /dev/null
			if test "$?" = "0"
			then
				saida="${saida} ${num_atual}"
				if test "$bc" != "1"
				then
					printf "%${tamanho}s | %s\n" ${num_atual} ${num_atual}
					printf "%${tamanho}s |\n" 1
				fi
				break
			fi

			# Definindo o próximo número primo a ser usado
			if test "${num_atual}" != "1"
			then
				linha_atual=$((${linha_atual} + 1))
				primo_atual=$(sed -n "${linha_atual}p" "$cache")
				test ${#primo_atual} -eq 0 && { zztool erro "Valor não fatorável nessa configuração do script!"; return 1; }
			fi
		done

		if test "$bc" != "2"
		then
			# Formatando a fórmula ao final da fatoração
			saida=$(
				echo "$saida " |
				tr ' ' '\n' |
				sed '/^ *$/d;s/^ *//g' |
				uniq -c |
				awk '{ if ($1==1) {print $2} else {print $2 "^" $1} }' |
				zzjuntalinhas -d ' * '
			)
			test "$bc" -eq "1" || echo
			echo "$1 = $saida"
		fi
	fi

	# Limpeza
	rm -f "$cache"
}

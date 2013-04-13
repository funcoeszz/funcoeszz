# ----------------------------------------------------------------------------
# Lista todos os divisores de um número inteiro e positivo, maior que 2.
#
# Uso: zzdivisores <numero>
# Ex.: zzdivisores 1400
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-25
# Versão: 2
# Licença: GPL
# Requisitos: zzfatorar
# ----------------------------------------------------------------------------
zzdivisores ()
{
	zzzz -h divisores "$1" && return

	[ "$1" ] || { zztool uso divisores; return 1; }

	local fatores fator divisores_temp divisor divisor_atual
	local divisores="1"

	if zztool testa_numero "$1" && test $1 -ge 2
	then
		# Decompõe o número em fatores primos
		fatores=$(zzfatorar --no-bc $1 | cut -f 2 -d "|" | zztool lines2list)

		# Se for primo informa 1 e ele mesmo
		zztool grep_var 'primo' "$fatores" && { echo "1 $1"; return; }

		for fator in $fatores
		do
			# Para cada fator primo, multiplica-se pelos divisores já conhecidos
			for divisor in $divisores
			do
				divisor_atual=$(($fator * $divisor))

				# Apenas armazenando se divisor não existir
				echo "$divisores_temp" | zztool list2lines | grep "^${divisor_atual}$" > /dev/null
				if [ $? -eq 1 ]
				then
					divisores_temp=$( echo "$divisores_temp $divisor_atual")
				fi
			done

			# Reabastece a variável divisores eliminando repetições
			divisores=$(echo "$divisores $divisores_temp" | zztool list2lines | sort -n | uniq | zztool lines2list)
		done

		# Elimina-se as repetições e ordena-se os divisores encontrados
		echo $divisores | zztool list2lines | sort -n | uniq | zztool lines2list
		echo
	else
		# Se não for um número válido exibe a ajuda
		zzdivisores -h
	fi
}

# ----------------------------------------------------------------------------
# Gera um CNPJ válido aleatório ou valida um CNPJ informado.
# Obs.: O CNPJ informado pode estar formatado (pontos e hífen) ou não.
# Uso: zzcnpj [cnpj]
# Ex.: zzcnpj 12.345.678/0001-95      # valida o CNPJ
#      zzcnpj 12345678000195          # com ou sem formatadores
#      zzcnpj                         # gera um CNPJ válido
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2004-12-23
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzcnpj ()
{
	zzzz -h cnpj "$1" && return

	local i n somatoria digito1 digito2 cnpj base

	# Atenção:
	# Essa função é irmã-quase-gêmea da zzcpf, que está bem
	# documentada, então não vou repetir aqui os comentários.
	#
	# O cálculo dos dígitos verificadores também é idêntico,
	# apenas com uma máscara numérica maior, devido à quantidade
	# maior de dígitos do CNPJ em relação ao CPF.

	cnpj=$(echo "$*" | tr -d -c 0123456789)

	if [ "$cnpj" ]
	then
		# CNPJ do usuário

		if [ ${#cnpj} -ne 14 ]
		then
			echo 'CNPJ inválido (deve ter 14 dígitos)'
			return 1
		fi

		base="${cnpj%??}"
	else
		# CNPJ gerado aleatoriamente

		while [ ${#cnpj} -lt 8 ]
		do
			cnpj="$cnpj$((RANDOM % 9))"
		done

		cnpj="${cnpj}0001"
		base="$cnpj"
	fi

	# Cálculo do dígito verificador 1

	set - $(echo "$base" | sed 's/./& /g')

	somatoria=0
	for i in 5 4 3 2 9 8 7 6 5 4 3 2
	do
		n="$1"
		somatoria=$((somatoria + (i * n)))
		shift
	done

	digito1=$((11 - (somatoria % 11)))
	[ $digito1 -ge 10 ] && digito1=0

	# Cálculo do dígito verificador 2

	set - $(echo "$base" | sed 's/./& /g')

	somatoria=0
	for i in 6 5 4 3 2 9 8 7 6 5 4 3 2
	do
		n="$1"
		somatoria=$((somatoria + (i * n)))
		shift
	done
	somatoria=$((somatoria + digito1 * 2))

	digito2=$((11 - (somatoria % 11)))
	[ $digito2 -ge 10 ] && digito2=0

	# Mostra ou valida o CNPJ
	if [ ${#cnpj} -eq 12 ]
	then
		echo "$cnpj$digito1$digito2" |
			sed 's|\(..\)\(...\)\(...\)\(....\)|\1.\2.\3/\4-|'
	else
		if [ "${cnpj#????????????}" = "$digito1$digito2" ]
		then
			echo 'CNPJ válido'
		else
			# Boa ação do dia: mostrar quais os verificadores corretos
			echo "CNPJ inválido (deveria terminar em $digito1$digito2)"
		fi
	fi
}

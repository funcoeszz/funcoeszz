# ----------------------------------------------------------------------------
# Cria, valida ou formata um número de CNPJ.
# Obs.: O CNPJ informado pode estar formatado (pontos e hífen) ou não.
# Uso: zzcnpj [-f] [cnpj]
# Ex.: zzcnpj 12.345.678/0001-95      # valida o CNPJ informado
#      zzcnpj 12345678000195          # com ou sem pontuação
#      zzcnpj                         # gera um CNPJ válido (aleatório)
#      zzcnpj -f 12345678000195       # formata, adicionando pontuação
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2004-12-23
# Versão: 3
# Licença: GPL
# Requisitos: zzaleatorio
# ----------------------------------------------------------------------------
zzcnpj ()
{
	zzzz -h cnpj "$1" && return

	local i n somatoria digito1 digito2 cnpj base auxiliar quieto

	# Atenção:
	# Essa função é irmã-quase-gêmea da zzcpf, que está bem
	# documentada, então não vou repetir aqui os comentários.
	#
	# O cálculo dos dígitos verificadores também é idêntico,
	# apenas com uma máscara numérica maior, devido à quantidade
	# maior de dígitos do CNPJ em relação ao CPF.

	cnpj=$(echo "$*" | tr -d -c 0123456789)

	# CNPJ válido formatado
	if test "$1" = '-f'
	then
		cnpj=$(echo "$cnpj" | sed 's/^0*//')

		# Só continua se o CNPJ for válido
		auxiliar=$(zzcnpj $cnpj 2>&1)
		if test "$auxiliar" != 'CNPJ válido'
		then
			zztool erro "$auxiliar"
			return 1
		fi

		cnpj=$(printf %014d "$cnpj")
		echo $cnpj | sed '
			s|.|&-|12
			s|.|&/|8
			s|.|&.|5
			s|.|&.|2
		'
		return 0
	fi

	# CNPJ válido não formatado
	if test "$1" = '-F'
	then

		if test "${#cnpj}" -eq 0
		then
			zzcnpj | tr -d -c '0123456789\n'
			return 0
		fi

		cnpj=$(echo "$cnpj" | sed 's/^0*//')

		# Só continua se o CNPJ for válido
		auxiliar=$(zzcnpj $cnpj 2>&1)
		if test "$auxiliar" != 'CNPJ válido'
		then
			zztool erro "$auxiliar"
			return 1
		fi

		printf "%014d\n" "$cnpj"
		return 0
	fi

	test "$1" = '-q' && quieto=1

	if test -n "$cnpj"
	then
		# CNPJ do usuário
		cnpj=$(printf %014d "$cnpj")

		if test ${#cnpj} -ne 14
		then
			test -n "$quieto" || zztool erro 'CNPJ inválido (deve ter 14 dígitos)'
			return 1
		fi

		base="${cnpj%??}"

		for ((i=0;i<13;i++))
			do
				auxiliar=$(echo "$base" | sed "s/$i/X/g")
				if test "$auxiliar" = "XXXXXXXXXXXX"
				then
					test -n "$quieto" || zztool erro "CNPJ inválido (não pode conter os 12 primeiros digitos iguais)"
					return 1
				fi
			done
		#Fim do laço de verificação de digitos repetidos

	else
		# CNPJ gerado aleatoriamente

		while test ${#cnpj} -lt 8
		do
			cnpj="$cnpj$(zzaleatorio 8)"
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
	test $digito1 -ge 10 && digito1=0

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
	test $digito2 -ge 10 && digito2=0

	# Mostra ou valida o CNPJ
	if test ${#cnpj} -eq 12
	then
		echo "$cnpj$digito1$digito2" |
			sed 's|\(..\)\(...\)\(...\)\(....\)|\1.\2.\3/\4-|'
	else
		if test "${cnpj#????????????}" = "$digito1$digito2"
		then
			test -n "$quieto" || echo 'CNPJ válido'
		else
			# Boa ação do dia: mostrar quais os verificadores corretos
			test -n "$quieto" || zztool erro "CNPJ inválido (deveria terminar em $digito1$digito2)"
			return 1
		fi
	fi
}

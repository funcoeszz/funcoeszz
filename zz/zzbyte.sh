# ----------------------------------------------------------------------------
# Conversão entre grandezas de bytes (mega, giga, tera, etc).
# Uso: zzbyte N [unidade-entrada] [unidade-saida]  # BKMGTPEZY
# Ex.: zzbyte 2048                    # Quanto é 2048 bytes?  -- 2K
#      zzbyte 2048 K                  # Quanto é 2048KB?      -- 2M
#      zzbyte 7 K M                   # Quantos megas em 7KB? -- 0.006M
#      zzbyte 7 G B                   # Quantos bytes em 7GB? -- 7516192768B
#      for u in b k m g t p e z y; do zzbyte 2 t $u; done
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2008-03-01
# Versão: 1
# Licença: GPL
# Requisitos: zzmaiusculas
# ----------------------------------------------------------------------------
zzbyte ()
{
	zzzz -h byte "$1" && return

	local i i_entrada i_saida diferenca operacao passo falta
	local unidades='BKMGTPEZY' # kilo, mega, giga, etc
	local n="$1"
	local entrada="${2:-B}"
	local saida="${3:-.}"

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso byte; return 1; }

	# Sejamos amigáveis com o usuário permitindo minúsculas também
	entrada=$(echo "$entrada" | zzmaiusculas)
	saida=$(  echo "$saida"   | zzmaiusculas)

	# Verificações básicas
	if ! zztool grep_var "$entrada" "$unidades"
	then
		echo "Unidade inválida '$entrada'"
		return 1
	fi
	if ! zztool grep_var "$saida" ".$unidades"
	then
		echo "Unidade inválida '$saida'"
		return 1
	fi
	zztool -e testa_numero "$n" || return 1

	# Extrai os números (índices) das unidades de entrada e saída
	i_entrada=$(zztool index_var "$entrada" "$unidades")
	i_saida=$(  zztool index_var "$saida"   "$unidades")

	# Sem $3, a unidade de saída será otimizada
	[ $i_saida -eq 0 ] && i_saida=15

	# A diferença entre as unidades guiará os cálculos
	diferenca=$((i_saida - i_entrada))
	if [ "$diferenca" -lt 0 ]
	then
		operacao='*'
		passo='-'
	else
		operacao='/'
		passo='+'
	fi

	i="$i_entrada"
	while [ "$i" -ne "$i_saida" ]
	do
		# Saída automática (sem $3)
		# Chegamos em um número menor que 1024, hora de sair
		[ "$n" -lt 1024 -a "$i_saida" -eq 15 ] && break

		# Não ultrapasse a unidade máxima (Yota)
		[ "$i" -eq ${#unidades} -a "$passo" = '+' ] && break

		# 0 < n < 1024 para unidade crescente, por exemplo: 1 B K
		# É hora de dividir com float e colocar zeros à esquerda
		if [ "$n" -gt 0 -a "$n" -lt 1024 -a "$passo" = '+' ]
		then
			# Quantos dígitos ainda faltam?
			falta=$(( (i_saida - i - 1) * 3))

			# Pulamos direto para a unidade final
			i="$i_saida"

			# Cálculo preciso usando o bc (Retorna algo como .090)
			n=$(echo "scale=3; $n / 1024" | bc)
			[ "$n" = '0' ] && break # 1 / 1024 = 0

			# Completa os zeros que faltam
			[ "$falta" -gt 0 ] && n=$(printf "%0.${falta}f%s" 0 "${n#.}")

			# Coloca o zero na frente, caso necessário
			[ "${n#.}" != "$n" ] && n="0$n"

			break
		fi

		# Terminadas as exceções, este é o processo normal
		# Aumenta/diminui a unidade e divide/multiplica por 1024
		i=$(($i $passo 1))
		n=$(($n $operacao 1024))
	done

	# Mostra o resultado
	echo "$n"$(echo "$unidades" | cut -c "$i")
}

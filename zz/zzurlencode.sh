# ----------------------------------------------------------------------------
# Codifica um texto numa URL.
# Permite especificar um conjunto de caracteres a não serem codificados.
# Uso: zzurlencode [string]
# Ex.: zzurlencode '!@#$_+{}^+abcd'	# %21%40%23%24_%2B%7B%7D%5E%2Babcd
#      zzurlencode ':/' http://		# http://
#      zzurlencode http://		# http%3A%2F%2F
#
# Autor: Guilherme Magalhães Gall <gmgall (a) gmail com>
# Desde: 2013-03-19
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzurlencode ()
{
	zzzz -h urlencode "$1" && return

	local string
	local caractere
	local nl=$(printf '\n')
	local nao_converter='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-'

	# Se foram passados 3 ou mais parâmetros, mostra mensagem de uso.
	if test $# -ge 3; then
		zztool uso urlencode
		return 1
	# Se 2 parâmetros foram passados, o 1º indica um conjunto de
	# caracteres que não serão codificados e o 2º o texto a codificar.
	elif test $# -eq 2; then
		nao_converter="$nao_converter$1"
		string="$2"
	# Se apenas 1 parâmetro foi passado, é o texto a codificar.
	else
		string="$1"
	fi

	# Loop a cada caractere. O printf o converte para hexa se o caractere
	# não constar em nao_converter, senão o imprime
	printf %s "$string" | while IFS= read -r -n 1 caractere
	do
		if test "$caractere" = "$nl"
		then
			# Exceção para contornar um bug:
			#   printf %x 'c retorna 0 quando c=\n
			printf '%%0A'
		else
			# Não usei zztool grep_var porque ele considera ?
			# caractere especial (glob)
			if printf "$nao_converter" | fgrep "$caractere" > /dev/null
			then
				printf "$caractere"
			else
				printf '%%%02X' "'$caractere"
			fi
		fi
	done
}

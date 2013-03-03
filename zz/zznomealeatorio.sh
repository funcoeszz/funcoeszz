# ----------------------------------------------------------------------------
# Gera um nome aleatório de N caracteres, alternando consoantes e vogais.
# Obs.: Se nenhum parâmetro for passado, gera um nome de 6 caracteres.
# Uso: zznomealeatorio [N]
# Ex.: zznomealeatorio
#      zznomealeatorio 8
#
# Autor: Guilherme Magalhães Gall <gmgall (a) gmail com> twitter: @gmgall
# Desde: 2013-03-03
# Versão: 1
# Licença: GPL
# Requisitos: zzseq zzmat
# ----------------------------------------------------------------------------
zznomealeatorio ()
{
	zzzz -h nomealeatorio "$1" && return

	local alfabeto='aeioubcdfghjlmnpqrstvxz'
	# Sem parâmetros, gera nome de 6 caracteres.
	local entrada=${1:-6}
	local contador
	local letra
	local nome

	# Se a quantidade de parâmetros for incorreta ou não for número
	# inteiro positivo, mostra mensagem de uso e sai.	
	(test $# -gt 1 || ! zztool testa_numero "$entrada") && {
		zztool uso nomealeatorio
		return 1
	}

	# Se o usuário quer um nome de 0 caracteres, basta retornar.
	test "$entrada" -eq 0 && return

	# Gera nome aleatório com $entrada caracteres. Alterna consoantes e
	# vogais. Algoritmo baseado na função randomName() do código da
	# página http://geradordenomes.com
	for contador in $(zzseq "$entrada")
	do
		if [ $((contador%2)) -eq 1 ]
		then
			letra=$(echo "$alfabeto" | cut -c$(zzmat -p0 random 6 23))
		else
			letra=$(echo "$alfabeto" | cut -c$(zzmat -p0 random 1 5))
		fi
		nome="$nome$letra"
	done
	echo "$nome"
}

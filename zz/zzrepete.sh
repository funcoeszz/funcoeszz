# ----------------------------------------------------------------------------
# Repete um dado texto na quantidade de vezes solicitada.
# Com a opção -l ou --linha cada repetição é uma nova linha.
#
# Uso: zzrepete [-l | --linha] <repetições> <texto>
# Ex.: zzrepete 15 Foo     # FooFooFooFooFooFooFooFooFooFooFooFooFooFooFoo
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2016-04-12
# Versão: 1
# Licença: GPL
# Requisitos: zzseq
# Tags: texto, manipulação
# ----------------------------------------------------------------------------
zzrepete ()
{
	zzzz -h repete "$1" && return

	test -n "$1" || { zztool -e uso repete; return 1; }

	# Definindo variáveis
	local linha i qtde

	# Uma repetição por linha
	if test '-l' = "$1" -o '--linha' = "$1"
	then
		linha='\n'
		shift
	fi

	# Ao menos 2 parâmetros: Número de repetições e o resto o que vai ser repetido
	test $# -ge 2 || { zztool -e uso repete; return 1; }

	# Se preenche os requesitos, vamos em frente.
	if zztool testa_numero "$1" && test "$1" -gt 0
	then
		qtde="$1"
		shift

		# É aqui que acontece, o código é auto-explicativo :)
		for i in $(zzseq $qtde)
		do
			printf "$*${linha}"
		done |
		zztool nl_eof

	else
		# Ops! Deu algum erro.
		zztool erro "Número inválido para repetições: $1"
		return 1
	fi
}

# ----------------------------------------------------------------------------
# Lista todos os divisores de um número inteiro e positivo, maior que 2.
#
# Uso: zzdivisores <número>
# Ex.: zzdivisores 1400
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-25
# Versão: 6
# Licença: GPL
# Tags: número, cálculo
# ----------------------------------------------------------------------------
zzdivisores ()
{
	zzzz -h divisores "$1" && return

	test -n "$1" || { zztool -e uso divisores; return 1; }

	if zztool testa_numero "$1" && test $1 -ge 2
	then
		# Código adaptado a partir da solução em:
		# http://stackoverflow.com/questions/11699324/
		echo "$1" |
		awk '{
				limits = sqrt($1)
				for (i=1; i <= limits; i++) {
					if ($1 % i == 0) {
						print i
						ind = $1 / i
						if (i != ind ) print ind
					}
				}
		}' |
		sort -n |
		zztool lines2list | zztool nl_eof
	else
		# Se não for um número válido.
		zztool erro "Apenas números naturais maiores ou iguais a 2."
		return 1
	fi
}

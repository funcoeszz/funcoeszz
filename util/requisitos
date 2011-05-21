#!/bin/bash
# 2011-05-20
# Aurelio Jargas
#
# Mostra quando uma função está faltando ou sobrando na linha Requisitos:
# 
# $ ./requisitos 
# zzcarnaval: # Requisitos: zzpascoa
# zzfeed: Função listada mas não utilizada: zzbeep
#

cd $(dirname "$0") || exit 1

cd ../zz
for f in zz*
do
	# Caso especial, já tratado, pode ignorar
	test $f = 'zzdictodos' && continue

	# Quais as funções já listadas em Requisitos:?
	requisitos=$(sed -n 's/^# Requisitos://p' $f)

	# Quais as funções usadas por esta zz?
	encontradas=$(
		funcoeszz limpalixo $f |
		grep 'zz[a-z]' |
		grep -v '()$' |
		grep -o 'zz[a-z0-9]*' |
		egrep -v 'zztool|zzzz' |
		sort |
		uniq)

	# SOBRANDO
	# Funções listadas em Requisitos: mas não utilizadas
	for req in $requisitos
	do
		# Se o requisito não for uma função zz, ignore
		echo $req | grep ^zz >/dev/null || continue

		echo "$encontradas" | grep -w $req >/dev/null ||
			echo "$f: Função listada mas não utilizada: $req"
	done

	# FALTANDO
	# Funções utilizadas que não estão na linha Requisitos:
	if test -n "$encontradas"
	then
		echo "$encontradas" |
			while read funcao
			do
				# Uma função usar ela mesma está OK
				test $funcao = $f && continue
				
				# Exceção: a zzconverte é apenas citada nos comentários
				test $f = 'zzmat' -a $funcao = 'zzconverte' && continue

				echo $requisitos | grep -w $funcao >/dev/null ||
					echo "$f: # Requisitos: $funcao"
			done
	fi
done

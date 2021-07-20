#!/bin/bash
# 2011-05-20
# Aurelio Jargas
#
# Mostra quando uma função está faltando ou sobrando na linha Requisitos:
#
# $ ./requisitos.sh
# zzcarnaval: # Requisitos: zzpascoa
# zzfeed: Função listada mas não utilizada: zzbeep
# zzdata.sh: Função lista a si própria como requisito
#

cd "$(dirname "$0")/.." || exit 1  # go to repo root
cd zz || exit 1

for f in zz*
do
	# Caso especial, já tratado, pode ignorar
	test "$f" = 'zzdictodos.sh' && continue

	# Quais as funções já listadas em Requisitos:?
	requisitos=$(sed -n 's/^# Requisitos://p' "$f")

	# Quais as funções usadas por esta zz?
	encontradas=$(
		grep -v '^[ 	]*#' "$f" |
		grep '\bzz[a-z]' |
		grep -v '()$' |
		grep -Eo '\bzz[a-z0-9]+\b' |
		sort |
		uniq)

	# REQUER A SI MESMA
	# Não faz sentido uma função colocar a si mesma como requisito
	for req in $requisitos
	do
		test "$req.sh" = "$f" &&
			echo "$f: Função lista a si própria como requisito"
	done

	# REQUISITO REPETIDO
	echo "$requisitos" | tr ' ' '\n' | sort | uniq -d | while read -r repetida
	do
		echo "$f: Requisito repetido: $repetida"
	done

	# SOBRANDO
	# Funções listadas em Requisitos: mas não utilizadas
	for req in $requisitos
	do
		# Se o requisito não for uma função zz, ignore
		echo "$req" | grep ^zz >/dev/null ||
			{ echo "$f: $req não é uma função ZZ, registre em 'Nota:'" ; continue; }

		echo "$encontradas" | grep -w "$req" >/dev/null ||
			echo "$f: Função listada mas não utilizada: $req"
	done

	# FALTANDO
	# Funções utilizadas que não estão na linha Requisitos:
	if test -n "$encontradas"
	then
		echo "$encontradas" |
			while read -r funcao
			do
				# Uma função usar ela mesma está OK
				test "$funcao.sh" = "$f" && continue

				# Falso-positivo: zzcores é mencionada em um comentário
				test "$f" = zztool.sh && test "$funcao" = zzcores && continue

				# Falso-positivo: estes são nomes de arquivos
				test "$f" = zzzz.sh && case "$funcao" in
					zzcshrc | zzzshrc) continue;;
				esac

				echo "$requisitos" | grep -w "$funcao" >/dev/null ||
					echo "$f: # Requisitos: $funcao"
			done
	fi
done | {
	# Garante que o exit code é 1 se este script produzir qualquer output
	! grep .
}

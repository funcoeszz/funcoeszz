#!/bin/bash
# 2011-05-20
# Aurelio Jargas
#
# Verificações de indentação nas funções.
# Procura por espaços em branco em lugares errados.


cd $(dirname "$0") || exit 1

cd ../zz

funcoeszz tool eco "Linha que inicia com um espaço"
grep '^ ' * |
	grep -v -E '^zz(google|palpite|loteria2)'  # caso válido, sed multilinha

funcoeszz tool eco "Linha com Tab e espaço misturados"
grep '	 ' * |
	# [\t ]: Dentro de colchetes, é regex
	fgrep -v '[	 ]'

funcoeszz tool eco "Linha com Tabs ou espaços inúteis no final"
grep '[^ 	][ 	]\{1,\}$' * |
	grep -v ^zzxml  # exceção, usado num comentário

funcoeszz tool eco "Linhas vazias, mas com brancos"
egrep '^[	 ]+$' *

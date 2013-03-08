# ----------------------------------------------------------------------------
# http://www.php.net/manual/pt_BR/indexes.functions.php
# Lista completa com funções do php
# com a opção -d ou --detalhe busca mais informação da função
#
# Uso: zzphp <palavra|regex>
# Ex.:
#      zzphp array                   # mostra as funçoes com "array" no nome
#      zzphp -d mysql_fetch_object   # mostra descrição da função mysql_fetch_object
#      zzphp ^X                      # mostra as funções que começam com X
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-06
# Versão: 1
# Licença: GPL
# Requisitos: zzminusculas
# ----------------------------------------------------------------------------
zzphp ()
{
	zzzz -h php "$1" && return

	local url='http://www.php.net/manual/pt_BR/indexes.functions.php'
	local cache="$ZZTMP.php"
	local padrao="$*"
	local end funcao

	# Força atualização da listagem apagando o cache
	if [ "$1" = '--atualiza' ]
	then
		rm -f "$cache"
		shift
	fi

	if [ "$1" = '-d' -o "$1" = '--detalhe' ]
	then
		url='http://www.php.net/manual/pt_BR'
		if [ "$2" ]
		then
			funcao=$(echo "$2" | zzminusculas)
			# Ajustando link entre classe e função
			echo "$funcao" | grep '::' >/dev/null
			if [ $? -eq 0 ]
			then
				end=$(echo "${funcao}.php" | sed 's/::[$]*/\./g')
			else
				end=$(echo "function.${funcao}.php")
			fi

			# Ajuste entre nome e o link da função
			end=$(echo "${end}" | sed 's/__//g;s/_/-/g;s/->/./g' | zzminusculas)

			$ZZWWWDUMP "${url}/${end}" | sed -n "/^${funcao}/,/___*$/p" | sed '$d'
		fi
	else
		# Se o cache está vazio, baixa listagem da Internet
		if ! test -s "$cache"
		then
			$ZZWWWDUMP "$url" | sed -n '/^ *+/p' | sed 's/^ *+ //g' > "$cache"
		fi

		if [ "$padrao" ]
		then
			# Busca a(s) função(ões)
			grep -h -i -- "$padrao" "$cache"
		else
			cat "$cache"
		fi
	fi
}

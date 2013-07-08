# ----------------------------------------------------------------------------
# http://www.php.net/manual/pt_BR/indexes.functions.php
# Lista completa com funções do PHP.
# com a opção -d ou --detalhe busca mais informação da função
# com a opção --atualiza força a atualização co cache local
#
# Uso: zzphp <palavra|regex>
# Ex.: zzphp --atualiza              # Força atualização do cache
#      zzphp array                   # mostra as funçoes com "array" no nome
#      zzphp -d mysql_fetch_object   # mostra descrição do  mysql_fetch_object
#      zzphp ^X                      # mostra as funções que começam com X
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-06
# Versão: 2
# Licença: GPL
# Requisitos: zzunescape
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
			funcao=$(echo "$2" | sed 's/ .*//')
			end=$(cat "$cache" | grep -h -i -- "^$funcao " | cut -f 2 -d"|")
			# Prevenir casos como do zlib://
			funcao=$(echo "$funcao" | sed 's|//||g')
			[ $? -eq 0 ] && $ZZWWWDUMP "${url}/${end}" | sed -n "/^${funcao}/,/add a note add a note/p" | sed '$d;/___*$/,$d'
		fi
	else
		# Se o cache está vazio, baixa listagem da Internet
		if ! test -s "$cache"
		then
			# Formato do arquivo:
			# nome da função - descrição da função : link correspondente
			$ZZWWWHTML "$url" | sed -n '/class="index"/p' |
			awk -F'"' '{print substr($5,2) "|" $2}' |
			sed 's/<[^>]*>//g' |
			zzunescape --html > "$cache"
		fi

		if [ "$padrao" ]
		then
			# Busca a(s) função(ões)
			cat "$cache" | cut -f 1 -d"|" | grep -h -i -- "$padrao"
		else
			cat "$cache" | cut -f 1 -d"|"
		fi
	fi
}

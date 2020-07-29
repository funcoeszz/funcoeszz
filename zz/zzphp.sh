# ----------------------------------------------------------------------------
# http://www.php.net/manual/pt_BR/indexes.functions.php
# Lista completa com funções do PHP.
# com a opção -d ou --detalhe busca mais informação da função
# com a opção --atualiza força a atualização co cache local
#
# Uso: zzphp <palavra|regex>
# Ex.: zzphp --atualiza              # Força atualização do cache
#      zzphp array                   # mostra as funções com "array" no nome
#      zzphp -d mysql_fetch_object   # mostra descrição do  mysql_fetch_object
#      zzphp ^X                      # mostra as funções que começam com X
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-06
# Versão: 3
# Licença: GPL
# Requisitos: zzunescape
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzphp ()
{
	zzzz -h php "$1" && return

	local url='http://www.php.net/manual/pt_BR/indexes.functions.php'
	local cache=$(zztool cache php)
	local padrao="$*"
	local end funcao

	# Força atualização da listagem apagando o cache
	if test '--atualiza' = "$1"
	then
		zztool atualiza php
		shift
	fi

	if test '-d' = "$1" -o '--detalhe' = "$1"
	then
		url='http://www.php.net/manual/pt_BR'
		if test -n "$2"
		then
			funcao=$(echo "$2" | sed 's/ .*//')
			end=$(cat "$cache" | grep -h -i -- "^$funcao " | cut -f 2 -d"|")
			# Prevenir casos como do zlib://
			funcao=$(echo "$funcao" | sed 's|//||g')
			test $? -eq 0 && zztool dump "${url}/${end}" |
			sed -n "/^ *${funcao}/,/add a note add a note/{p; /add a note/q; }" |
			sed '$d; /[_-][_-][_-][_-]*$/,$d; s/        */       /'
		fi
	else
		# Se o cache está vazio, baixa listagem da Internet
		if ! test -s "$cache"
		then
			# Formato do arquivo:
			# nome da função - descrição da função : link correspondente
			zztool source "$url" | sed -n '/class="index"/p' |
			awk -F'"' '{print substr($5,2) "|" $2}' |
			sed 's/<[^>]*>//g' |
			zzunescape --html > "$cache"
		fi

		if test -n "$padrao"
		then
			# Busca a(s) função(ões)
			cat "$cache" | cut -f 1 -d"|" | grep -h -i -- "$padrao"
		else
			cat "$cache" | cut -f 1 -d"|"
		fi
	fi
}

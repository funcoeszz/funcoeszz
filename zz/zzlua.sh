# ----------------------------------------------------------------------------
# http://www.lua.org/manual/5.1/pt/manual.html
# Lista de funções da linguagem Lua.
# com a opção -d ou --detalhe busca mais informação da função
# com a opção --atualiza força a atualização do cache local
#
# Uso: zzlua <palavra|regex>
# Ex.: zzlua --atualiza        # Força atualização do cache
#      zzlua file              # mostra as funçoes com "file" no nome
#      zzlua -d debug.debug    # mostra descrição da função debug.debug
#      zzlua ^d                # mostra as funções que começam com d
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-09
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzlua ()
{
	zzzz -h lua "$1" && return

	local url='http://www.lua.org/manual/5.1/pt/manual.html'
	local cache="$ZZTMP.lua"
	local padrao="$*"

	# Força atualização da listagem apagando o cache
	if [ "$1" = '--atualiza' ]
	then
		rm -f "$cache"
		shift
	fi

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWDUMP "$url" | sed -n '/^4.1/,/^ *6/p' | sed '/^ *[4-6]/,/^ *__*$/{/^ *__*$/!d;}' > "$cache"
	fi

	if [ "$1" = '-d' -o "$1" = '--detalhe' ]
	then
		# Detalhe de uma função específica
		if [ "$2" ]
		then
			sed -n "/  $2/,/^ *__*$/p" "$cache" | sed '/^ *__*$/d'
		fi
	elif [ "$padrao" ]
	then
		# Busca a(s) função(ões)
		sed -n '/^ *__*$/,/^ *[a-z_]/p' "$cache" |
		sed '/^ *__*$/d;/^ *$/d;s/^  //g;s/\([^ ]\) .*$/\1/g' |
		grep -h -i -- "$padrao"
	else
		# Lista todas as funções
		sed -n '/^ *__*$/,/^ *[a-z_]/p' "$cache" |
		sed '/^ *__*$/d;/^ *$/d;s/\([^ ]\) .*$/\1/g'
	fi
}

# ----------------------------------------------------------------------------
# http://www.lua.org/manual/5.1/pt/manual.html
# Lista de funções da linguagem Lua.
# com a opção -d ou --detalhe busca mais informação da função
# com a opção --atualiza força a atualização do cache local
#
# Uso: zzlua <palavra|regex>
# Ex.: zzlua --atualiza        # Força atualização do cache
#      zzlua file              # mostra as funções com "file" no nome
#      zzlua -d debug.debug    # mostra descrição da função debug.debug
#      zzlua ^d                # mostra as funções que começam com d
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-09
# Versão: 2
# Licença: GPL
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzlua ()
{
	zzzz -h lua "$1" && return

	local url='http://www.lua.org/manual/5.1/pt/manual.html'
	local cache=$(zztool cache lua)
	local padrao="$*"

	# Força atualização da listagem apagando o cache
	if test '--atualiza' = "$1"
	then
		zztool atualiza lua
		shift
	fi

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		zztool dump "$url" |
		awk '
				$0  ~ /^$/  { branco++; if (branco == 3) { print "----------"; branco = 0 } }
				$0 !~ /^$/  { for (i=1;i<=branco;i++) { print "" }; print ; branco = 0 }
			' |
		sed -n '/^ *4\.1/,/^ *6/p' |
		sed '/^ *[4-6]/,/^ *[_-][_-][_-][_-]*$/{/^ *[_-][_-][_-][_-]*$/!d;}' > "$cache"
	fi

	if test '-d' = "$1" -o '--detalhe' = "$1"
	then
		# Detalhe de uma função específica
		if test -n "$2"
		then
			sed -n "/  *$2/,/^ *[_-][_-][_-][_-]*$/p" "$cache" |
			sed '/^ *[_-][_-][_-][_-]*$/d' | sed '$ { /^ *$/ d; }'
		fi
	elif test -n "$padrao"
	then
		# Busca a(s) função(ões)
		sed -n '/^ *[_-][_-][_-][_-]*$/,/^ *[a-z_]/p' "$cache" |
		sed '/^ *[_-][_-][_-][_-]*$/d;/^ *$/d;s/^  //g;s/\([^ ]\) .*$/\1/g' |
		grep -h -i -- "$padrao"
	else
		# Lista todas as funções
		sed -n '/^ *[_-][_-][_-][_-]*$/,/^ *[a-z_]/p' "$cache" |
		sed '/^ *[_-][_-][_-][_-]*$/d;/^ *$/d;s/\([^ ]\) .*$/\1/g'
	fi
}

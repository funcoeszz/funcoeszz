# ----------------------------------------------------------------------------
# Lista constantes matemáticas e físicas e unidades do SI.
# Argumentos:
#   -m: Apenas constantes matemáticas.
#   -f: Apenas constantes físicas.
#   -s: Unidades usadas no SI (Sistema Internacional de Unidades).
#   -a: Dados astronômicos do Sol, Terra e Lua.
#   -p: Unidades de Planck.
#
# Obs.: Sem argumentos, mostra todas as listas.
#       Se usar mais de um argumento considera apenas o último.
#
# Uso: zzconstantes [-m|-f|-s|-a|-p]
# Ex.: zzconstantes         # lista completa
#      zzconstantes -f      # lista as constates físicas somente
#      zzconstantes -m -a   # lista as dados astronômicos somente
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2021-01-04
# Versão: 1
# Requisitos: zzzz zztool zzcut zzjuntalinhas zzpad zzsqueeze zzunescape zzutf8 zzwc zzxml
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzconstantes ()
{
	zzzz -h constantes "$1" && return

	local a b c d e i modo lista

	# Caso seja escolhida apenas uma listagem
	while test "${1#-}" != "$1"
	do
		case "$1" in
			-m) lista='m'; shift ;;
			-s) lista='1'; shift ;;
			-f) lista='2'; shift ;;
			-a) lista='3'; shift ;;
			-p) lista='p'; shift ;;
			-*) zztool uso constantes; return 1 ;;
			*)  break ;;
		esac
	done

	if test 'm' == "${lista:-m}"
		then
		# Constantes Matemáticas
		zztool eco Constantes Matemáticas
		zztool source 'https://pt.wikipedia.org/wiki/Lista_de_constantes_matem%C3%A1ticas' |
		sed -n '/<table/,/table>/p' |
		zzjuntalinhas -i '<tr' -f 'tr>' -d '_' |
		zzxml --untag |
		sed 's/_\{1,\}/_/g;s/^_//' |
		zzunescape --html |
		zzcut -f 1-3 -s -d '_' |
		sed 's/\([0-9]\) \([0-9]\)/\1\2/g;' |
		while IFS='_' read a b c
		do
			if test 'i' == "$a"
			then
				c=$(echo "$c" | sed 's/,.*/ (√-1)/')
				b=$(echo "$b" | sed 's/2/²/')
			elif test 'K' == "$a"
			then
				c=$(echo "$c" | sed 's/ 1//g')
			fi
			echo "$(zzpad 47 $c) $(zzpad 7 $a) $b"
		done
	fi

	if zztool grep_var '1' "${lista:-1 2 3}" || zztool grep_var '2' "${lista:-1 2 3}"  || zztool grep_var '3' "${lista:-1 2 3}"
	then
		# Constantes Físicas
		for i in $( echo "${lista:-1 2 3}" | tr -d -c ' 123')
		do
			zztool source "http://lilith.fisica.ufmg.br/~labexp/anexos/Constantes_Fisicas_arquivos/sheet00${i}.htm"
		done |
		zzutf8 |
		sed -n '/<table/,/table>/p' |
		zzxml --tidy |
		zzjuntalinhas -i '<td' -f 'td>' -d '' |
		zzjuntalinhas -i '<tr' -f 'tr>' -d '_' |
		zzxml --untag |
		zzunescape --html |
		sed 's/_[_[:space:] ]\{1,\}/_/g;s/^_*//;s/_*$//;/Adaptado do/d;/retirados/d' |
		zzsqueeze |
		sed 's/\([0-9]\) \([0-9]\)/\1\2/g;s/&#1013;/ϵ/' |
		while IFS='_' read a b c d e
		do
			if test -z "$b"
			then
				test $(echo "$a" | zzwc -m) -le 55 && test 4 -ne ${modo:-1} && zztool eco "$a" || echo "$a"
				continue
			elif test 'Símbolo' == "$c" && test -z "$d"
			then
				modo=1
			elif test 'Símbolo' == "$c" && test -n "$d"
			then
				modo=2
			elif test 'Símbolo' == "$b"
			then
				modo=3
			elif test 'Sol' == "$b"
			then
				modo=4
			fi
			case $modo in
				1) echo "$(zzpad 25 $a) $(zzpad 14 $b) $c" ;;
				2) echo "$(zzpad 37 $a) $(zzpad 31 $b) $(zzpad 8 $c) $d" ;;
				3) echo "$(zzpad 62 $a) $(zzpad 8 $b) $(zzpad 20 $c) $(zzpad 19 $d) $e" ;;
				4) echo "$(zzpad 60 $a) $(zzpad 13 $b) $(zzpad 11 $c) $d $e" ;;
			esac
		done
	fi

	# Outras constantes ligadas a Planck
	if test 'p' == "${lista:-p}"
	then
		zztool eco "Unidades de Planck"
		zztool source 'https://pt.wikipedia.org/wiki/Unidades_de_Planck' |
		sed -n '/Tabela 2/,/Tabela 4/p' |
		zzxml --tidy |
		zzjuntalinhas -i '<th' -f 'th>' -d '' |
		zzjuntalinhas -i '<td' -f 'td>' -d ' ' |
		zzjuntalinhas -i '<tr' -f 'tr>' -d '|' |
		zzunescape --html |
		zzsqueeze |
		zzxml --untag |
		awk -F '|' '
			BEGIN { printf "%-32s %-27s %s\n", "Nome", "Dimensão", "Equivalência no SI" }
			/Tabela/{next}
			NF>7 {
				sub(/^ */,"", $2); sub(/ *$/,"", $2)
				gsub(/  2/,"²",$4)
				gsub(/  3/,"³",$4)
				sub(/^ */,"", $4); sub(/ *$/,"", $4)
				sub(/ +Q/,"Q",$4)
				sub(/ +T +/,"T^",$4)
				sub(/ *\//,"/", $4)
				sub(/ +)/,")", $4)
				gsub(/ +/," ", $4)
				sub(/^ */,"", $8); sub(/ *$/,"", $8)
				sub(/ +× +10  +/,"×10^",$8)
				sub(/ × 10¹  +/,"×10 ", $8)
				sub(/ +/," ", $8)
				printf "%-32s %-27s %s\n", $2, $4, $8
			}
		'
	fi
}

# ----------------------------------------------------------------------------
# Exibe a lista do Código Internacional Q e suas descrições.
# Sem argumento só lista os código.
# Com a opção --desc mostra a pergunta relacionada.
# Com o código como argumento exibe sua descrição completa.
#
# Uso: zzcodq [--desc | código Q]
# Ex.: zzcodq           # Lista todos os códigos apenas.
#      zzcodq --desc    # Lista todos os códigos com a pergunta associada.
#      zzcodq qra       # Detalhes da pergunta e resposta para QRA
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2021-01-07
# Versão: 1
# Requisitos: zzzz zztool zzcolunar zzcut zzjuntalinhas zzmaiusculas zzwc zzxml
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzcodq ()
{

	zzzz -h codq "$1" && return

	local q

	if test -n "$1"
	then
		case "$1" in
		--desc) q='D' ;;
		-*)     zztool -e uso codq; return 1 ;;
		*)
			test $(echo "$1" | zzwc -m) -ne 3 && { zztool -e uso codq; return 1; }
			test $(echo "$1" | zzmaiusculas | zzcut -c 1) != "Q" && { zztool -e uso codq; return 1; }
			q=$(echo "$1" | zzmaiusculas)
		;;
		esac
	else
		q='Q'
	fi

	local url='https://pt.wikipedia.org/wiki/C%C3%B3digo_Internacional_Q'

	# Código Q
	zztool source "$url" |
		zzxml --tidy |
		sed -n '/<table class="wikitable"/,/table>/p' |
		zzjuntalinhas -i '<ol' -f 'ol>' -d '§' |
		zzjuntalinhas -i '<th' -f 'th>' -d '' |
		zzjuntalinhas -i '<td' -f 'td>' -d '' |
		zzjuntalinhas -i '<tr' -f 'tr>' -d '|' |
		zzxml --untag |
		sed '
			s/§\{1,\}/§/g
			s/|\{1,\}/|/g
			s/[[:blank:]]\{1,\}\([|§]\)/\1/g
			s/§|/|/g
		' |
		awk -F '|' -v aq="$q" '
			# Soemnte lista os códigos
			aq == "Q" && length($2)==3 { print $2; next }

			length($2)==3 && $2==(length(aq)==3?aq:$2) {
				print $2

				if (length(aq)==3) {
					print ""
					print " Pergunta:"
				}

				# Com a pergunta associada
				if (length(aq)==3 || aq=="D") {
					gsub(/§/,"\n    ",$3)
					print "  "$3
					print ""
				}

				# Com a reposta esperada
				if (length(aq)==3) {
					print " Resposta:"
					gsub(/§/,"\n    ",$4)
					print "  " $4
				}
			}
		' |
		if test 'Q' == "$q"
		then
			zzcolunar -w 5 7
		else
			cat -
		fi
}

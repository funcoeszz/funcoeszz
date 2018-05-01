# ----------------------------------------------------------------------------
# Exibe partes selecionadas de linhas de cada ARQUIVO/STDIN na saída padrão.
# É uma emulação do comando cut, com recursos adicionais.
#
# Opções:
#  -c LISTA    seleciona apenas estes caracteres.
#
#  -d DELIM    usa DELIM em vez de TAB (padrão) como delimitador de campo.
#
#  -f LISTA    seleciona somente estes campos; também exibe qualquer
#              linha que não contenha o caractere delimitador.
#
#  -s          não emite linhas que não contenham delimitadores.
#
#  -D TEXTO    usa TEXTO como delimitador da saída
#              o padrão é usar o delimitador de entrada.
#
#  -v          Inverter o sentido, apagando as partes selecionadas.
#
#  Obs.:  1) Se o delimitador da entrada for uma Expressão Regular,
#            é recomendando declarar o delimitador de saída.
#         2) Se o delimitador de entrada for ou possuir:
#             - '\' (contra-barra), use '\\' (1 escape) para cada '\'.
#             - '/' (barra), use '[/]' (lista em ER) para cada '/'.
#         3) Se o delimitador de saída for ou possuir:
#             - '\' (contra-barra), use '\\\\' (3 escapes) para cada '\'.
#             - '/' (barra), use '\/' (1 escape) para cada '/'.
#
#  Use uma, e somente uma, das opções -c ou -f.
#  Cada LISTA é feita de um ou vários intervalos separados por vírgulas.
#  Cada intervalo da lista exibe seu trecho, mesmo se for repetido.
#
#  Cada intervalo pode ser:
#    N     caractere ou campo na posição N, começando por 1.
#    N-    Do caractere ou campo na posição N até o fim da linha.
#    N-M   Do caractere ou campo na posição N até a posição M.
#    -M    Do primeiro caractere ou campo até a posição M.
#    -     Do primeiro caractere ou campo até ao fim da linha.
#    N~M   Do caractere ou campo na posição N até o final indo em M saltos.
#    ~M    Do começo até o fim da linha em M saltos de caracteres ou campos.
#    d     Caractere "d", posicionar o delimitador na saida de caracteres.
#
# Uso: zzcut <-c|-f> <número[s]|range> [-d <delimitador>] [-v]
# Ex.: zzcut -c 5,2 arq.txt     # 5º caractere, seguido pelo 2º caractere
#      zzcut -c 7-4,9- arq.txt  # 7º ao 4º e depois do 9º ao fim da linha
#      zzcut -v -c 3-8 arq.txt  # Exclui do 3º ao 8º caractere
#      zzcut -f 1,-,3  arq.txt  # 1º campo, toda linha e 3º campo
#      zzcut -v -f 6-  arq.txt  # Exclui a partir do 6º campo
#      zzcut -f 8,8,8 -d ";" arq.txt   # 8º campo 3 vezes. Delimitador ";"
#      zzcut -f 10,6 -d: -D _ arq.txt  # 10º e 6º campos, novo delimitador _
#      zzcut -c 1,d,10 -D: arq.txt     # 1º e 10º caracteres. Delimitador :
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2016-02-09
# Versão: 4
# Licença: GPL
# Requisitos: zzunescape
# Tags: cut, emulação
# ----------------------------------------------------------------------------
zzcut ()
{

	zzzz -h cut "$1" && return

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso cut; return 1; }

	local tipo range ofd codscript qtd_campos only_delim inverte sp rlm
	local delim=$(printf '\t')

	# Recurso para oferecer a oportunidade de aspas serem usadas no delimitador
	# Usando um caractere não imprimível no lugar da aspas
	local aspas=$(echo "&zwnj;" | zzunescape --html)

	# Definindo qual delimitador apresenta a aspas pelos dois bits na variável
	# O primeiro bit define o delimitador na entrada
	# O segundo bit define o delimitador na saída
	# 0 = não há aspas no delimitador
	# 1 = há aspas no delimitador
	local bit_aspas='00'

	# Opções de linha de comando
	while test "${1#-}" != "$1"
	do
		case "$1" in
			-c*)
				# Caracter
				test -n "$tipo" && { zztool erro "Somente um tipo de lista pode ser especificado"; return 1; }
				tipo='c'
				range="${1#-c}"
				if test -z "$range"
				then
					range="$2"
					shift
				fi
				shift
			;;
			-f*)
				# Campo
				test -n "$tipo" && { zztool erro "Somente um tipo de lista pode ser especificado"; return 1; }
				tipo='f'
				range="${1#-f}"
				if test -z "$range"
				then
					range="$2"
					shift
				fi
				shift
			;;
			-d*)
				# Definindo delimitador para opção campo
				unset delim
				delim="${1#-d}"
				if test -z "$delim"
				then
					delim="$2"
					shift
				fi

				# Apenas usa o recurso se houver aspas no delimitador de entrada
				if zztool grep_var '"' "$delim"
				then
					delim=$(echo "$delim" | sed 's/"/'${aspas}'/g')
					bit_aspas=$(echo "$bit_aspas" | sed 's/^./1/')
				fi
				shift
			;;
			-D*)
				ofd="${1#-D}"
				if test -z "$ofd"
				then
					ofd="$2"
					shift
				fi
				shift
			;;
			# Apenas linha que possuam delimitadores
			-s) only_delim='1'; shift ;;
			# Invertendo a seleção
			-v) inverte='1';    shift ;;
			* ) break ;;
		esac
	done

	# Um tipo de lista é mandatório
	test -z "$tipo" && { zztool erro "Deve-se especificar uma lista de caracteres ou campos"; return 1; }

	# O range é mandatório, seja qual for o tipo
	# O range só pode ser composto de números [0-9], traço [-], til [~], vírgula [,]  ou "d"
	if test -n "$range"
	then
		if echo "${range#=}" | grep -E '^[d0-9,~-]{1,}$' 2>/dev/null >/dev/null
		then
			range=$(echo "${range#=}" | sed 's/[^,]d//g;s/d[^,]//g;s/,,*/,/g;s/^,//;s/,$//')

			case "$tipo" in
				c)
					if test "$inverte" = '1'
					then
						sp=$(echo "&thinsp;" | zzunescape --html)
						codscript=$(
							echo "$range" | zztool list2lines | sort -n |
							awk -v tsp="$sp" '
								# Apagar linha toda
								/^-$/ { print "s/.*//";exit }
								# Apagar desde o início da linha até um caractere
								/^-[0-9]+$/ && NR==1 {sub(/-/,""); inicio = $1 }
								# Apagar de um caractere até o fim da linha
								/^[0-9]+-$/ {sub(/-/,""); print "s/^\\(.\\{"$1-1"\\}\\).*$/\\1/;"; exit}
								Apagar um caractere ou um trecho
								/^[0-9]+(-[0-9]+)*$/ {
									if ($1 ~ /^[0-9]+$/ && $1 > inicio ) { printf "s/./" tsp "/" $1 ";" }
									else {
										split("", faixa); split($1, faixa, "-")
										if (faixa[1] == faixa[2] && faixa[1] > inicio ) { printf "s/./" tsp "/" faixa[1] ";" }
										else {
											if (faixa[2] < faixa[1]) {
												temp = faixa[2]; faixa[2] = faixa[1]; faixa[1] = temp
											}
											for (i=faixa[1]; i<=faixa[2]; i++) { printf "s/./" tsp "/" i ";" }
										}
									}
								}
								# Apagar caracteres em saltos N~M.
								/^[0-9]*~[0-9]+$/ {
									split("", faixa); split($1, faixa, "~")
									faixa[2]*=(faixa[2]>=0?1:-1)
									faixa[2]=(faixa[2]==0?1:faixa[2])
									faixa[1]=(length(faixa[1])>0 && faixa[1]>0?faixa[1]:faixa[2])
									printf "s/./" tsp "/" faixa[1] "\n :ini\n s/\\(" tsp ".\\{" faixa[2]-1 "\\}\\)[^" tsp "]/\\1" tsp "/\n t ini\n"
								}
								END {
									if (inicio) print "s/^.\\{" inicio "\\}//;"
									print "p"
								}
							'
						)
					else
						ofd="${ofd:-$delim}"
						rlm=$(echo "&rlm;" | zzunescape --html)

						qtd_campos=$(echo "$range" |
								awk -F "," '{
									while(NF){
										if ($NF ~ /^[0-9]*~[0-9]+$/ || $NF ~ /^[0-9]*-[0-9]*$/ || $NF ~ /^[d0-9]+$/) i++
										NF--
									}
									print i
								}'
							)

						codscript=$(
							echo "$range" |
							awk -F "," -v ofs="$ofd" -v rlm="$rlm" 'BEGIN {print "h;"} {
								for (i=1; i<=NF; i++) {
									# Apenas um número, um caractere
									if ($i ~ /^[0-9]+$/) print "g;" ($i>1 ? "s/^.\\{1,"$i-1"\\}//;" : "" ) "s/^\\(.\\).*/\\1/;p"
									# Linha inteira ou faixa N-M (faixa de caracteres)
									if ($i ~ /^-$/) print "g;p"
									else if ($i ~ /^[0-9]*-[0-9]*$/) {
										split("", faixa); split($i, faixa, "-")
										faixa[1]=(length(faixa[1])>0?faixa[1]:1)
										faixa[2]=(length(faixa[2])>0?faixa[2]:"*")
										# Se segundo número for menor
										if (faixa[2]!="*" && faixa[2] < faixa[1]) {
											temp = faixa[2]; faixa[2] = faixa[1]; faixa[1] = temp
											inv=1
										}
										else inv=0
										printf "g;" (faixa[1]>1 ? "s/^.\\{1,"faixa[1]-1"\\}//;" : "" )
										print "s/^\\(." (faixa[2]!="*"?"\\{":"") faixa[2]-faixa[1]+1 (faixa[2]!="*"?"\\}":"") "\\)" (faixa[2]!="*"?".*":"") "/" (inv==1?rlm:"") "\\1/;p"
									}
									# Caracteres em saltos N~M.
									if ($i ~ /^[0-9]*~[0-9]+$/) {
										split("", faixa); split($i, faixa, "~")
										faixa[2]*=(faixa[2]>=0?1:-1)
										faixa[2]=(faixa[2]==0?1:faixa[2])
										faixa[1]=(length(faixa[1])>0 && faixa[1]>0?faixa[1]:faixa[2])
										printf "g;" ( faixa[1]>1 ? "s/^.\\{1," faixa[1]-1 "\\}//;" : "" )
										if (faixa[2]>1) printf "s/\\(.\\).\\{" faixa[2]-1 "\\}/\\1/g;"
										print "p"
									}
									if ($i == "d") { print "g;s/.*/" ofs "/g;p" }
								}
							}'
						)
					fi
				;;
				f)
					ofd="${ofd:-$delim}"
					# Apenas usa o recurso se houver aspas no delimitador de saída
					if zztool grep_var '"' "$ofd"
					then
						ofd=$(echo "$ofd" | sed 's/"/'${aspas}'/g')
						bit_aspas=$(echo "$bit_aspas" | sed 's/.$/1/')
					fi

					if test "$only_delim" = "1"
					then
						only_delim=$(zztool endereco_sed "$delim")
					fi

					if test "$inverte" = '1'
					then
						codscript=$(
							echo "$range" | zztool list2lines | sort -n |
							awk -v ofs="$ofd" 'BEGIN { print "BEGIN { OFS=\"" ofs "\" } { " }
								{
								# Apenas um número, um campo
								if ($1 ~ /^[0-9]+$/) { print "$" $1 "=\"\""}
								# Uma faixa N-M, uma faixa de campos
								if ($1 ~ /^[0-9]*-[0-9]*$/) {
									split("", faixa); split($1, faixa, "-")
									faixa[1]=(length(faixa[1])>0?faixa[1]:1)
									faixa[2]=(length(faixa[2])>0?faixa[2]:"FIM")
									# Se segundo número for menor
									if (faixa[2] < faixa[1]) {
										temp = faixa[2]; faixa[2] = faixa[1]; faixa[1] = temp
									}
									if (faixa[2]=="FIM") {
										print " ate_fim(" faixa[1] ", \"\", 1) "
									}
									else {
										for (j=faixa[1]; j<=faixa[2]; j++) {
											print "$" j "=\"\""
										}
									}
								}
								# Apagar caracteres em saltos N~M.
								if ($1 ~ /^[0-9]*~[0-9]+$/) {
									split("", faixa); split($1, faixa, "~")
									faixa[2]=(faixa[2]==0?1:faixa[2])
									faixa[1]=(length(faixa[1])>0 && faixa[1]>0?faixa[1]:faixa[2])
									print " ate_fim(" faixa[1] ", \"\", " faixa[2] ") "
								}
							}
							END { print " print }" }'
						)
					else
						codscript=$(
						echo "$range" |
						awk -F"," -v ofs="$ofd" '{
							printf "{ printf "
							for (i=1; i<=NF; i++) {
								# Apenas um número, um campo
								if ($i ~ /^[0-9]+$/) { printf "$" $i "\"" ofs "\""}
								# Uma faixa N-M, uma faixa de campos
								if ($i ~ /^[0-9]*-[0-9]*$/) {
									split("", faixa); split($i, faixa, "-")
									faixa[1]=(length(faixa[1])>0?faixa[1]:1)
									faixa[2]=(length(faixa[2])>0?faixa[2]:"FIM")

									if (faixa[2]=="FIM") {
										printf " ate_fim("faixa[1] ", \"" ofs "\", 1) "
									}
									else if (faixa[2] < faixa[1]) {
										for (j=faixa[1]; j>=faixa[2]; j--) {
											printf "$" j "\"" ofs "\""
										}
									}
									else {
										for (j=faixa[1]; j<=faixa[2]; j++) {
											printf "$" j "\"" ofs "\""
										}
									}
								}
								# Caracteres em saltos N~M.
								if ($i ~ /^[0-9]*~[0-9]+$/) {
									split("", faixa); split($i, faixa, "~")
									faixa[2]=(faixa[2]==0?1:faixa[2])
									faixa[1]=(length(faixa[1])>0 && faixa[1]>0?faixa[1]:faixa[2])
									printf " ate_fim(" faixa[1] ", \"" ofs "\", " faixa[2] ") "
								}
							}
							printf "; print \"\" }"
						}' 2>/dev/null
					)
				fi
				;;
			esac

		else
			zztool erro "Formato inválido para a lista de caracteres ou campos"; return 1
		fi
	else
		zztool erro "Deve-se definir pelo menos um range de caracteres ou campos"; return 1
	fi

	zztool file_stdin "$@" |
	if echo "$bit_aspas" | grep '^1' >/dev/null
	then
		sed 's/"/'${aspas}'/g'
	else
		cat -
	fi |
	case "$tipo" in
		c)
			sed -n "$codscript" |
			if test "$inverte" = '1'
			then
				sed "s/$sp//g"
			else
				sed "
				/$rlm/ {
					:ini
					s/\(.*\)$rlm\(.\)/\2\1$rlm/
					t ini
					s/$rlm//g
				}
				" |
				awk -v div="${qtd_campos:-1}" '{ printf $0 }; NR % div == 0 { print ""}'
			fi
		;;
		f)
			awk -F "$delim" -v tsp="$inverte" "
				function ate_fim (ini, sep, salto,  saida) {
						for (i=ini; i<=NF; i+=salto) {
							if (tsp == 1) { \$i=\"\" }
							else { saida = saida \$i sep }
						}
						if (tsp != 1) return saida
				}
				$only_delim $codscript" 2>/dev/null |
				sed "s/\(${ofd}\)\{2,\}/${ofd}/g;s/^${ofd}//;s/${ofd}$//"
		;;
	esac |
	if test "$bit_aspas" != '00'
	then
		sed 's/'${aspas}'/"/g'
	else
		cat -
	fi
}

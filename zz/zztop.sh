# ----------------------------------------------------------------------------
# Lista os computadores mais rápidos do mundo entre os 500 disponíveis.
# Por padrão lista os 10 primeiros da listagem mais atual.
#
# Pode-se pedir pela posição:
# -i <número>: listando a partir dessa posição em diante.
# -f <número>: listando até essa posição.
#
# Argumentos de ajuda:
#  -l: Exibe as listas disponíveis
#  -g: Exibe a lista por Eficiência Energética
#  -p: Exibe a lista por Gradiente de Conjugado de Alta Performance
#
# Argumentos de listagem:
#  [lista]:     Seleciona a lista, se omitida mostra mais recente.
#
# Sem argumentos usa a listagem mais recente.
#
# Uso: zztop [-l] [-g|-h] [-i número] [-f número] [lista]
# Ex.: zztop               # Lista os 10 mais rápidos ( mais atuais ).
#      zztop 23            # Lista os 10 mais rápidos em Junho de 2004
#      zztop -g            # Ordenando por eficiência energética
#      zztop -p            # Ordenado por alta performance
#      zztop -i 5          # Lista do 5º ao 10º mais rápido
#      zztop -f 270        # Lista os 270 mais rápidos
#      zztop -i 2 -f 5 40  # Lista do 2º ao 5º de Novembro 2012
#      zztop -l            # Exibe todas as listas disponíveis
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2015-07-19
# Versão: 4
# Licença: GPL
# Requisitos: zzcolunar zzjuntalinhas zzsqueeze zztac zztrim zzunescape zzxml
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zztop ()
{

	zzzz -h top "$1" && return

	local url='http://top500.org'
	local topico='top500'
	local release all_releases max_release ano mes pag pag_ini pag_fim
	local ini=1
	local fim=10

	# Argumento apenas para exibir opções diponíveis e sair
	while test "${1#-}" != "$1"
	do
		case "$1" in
		-l)
		# Meses e anos disponíveis, representado por um número sequencial
			zztool eco "(g) - Green500 - Eficiência Energética."
			zztool eco "(h) - High-Performance Conjugate Gradient (HPCG)."
			zztool source "${url}/statistics/list" |
			sed -n '/option value/{s/^.*value="//;s/<\/option>$//;s/".*>/	/;p;}' |
			sed '/June 1993$/q' |
			expand -t 3 |
			zztac |
			awk '$1>=49 {g="g"}; $1>=50 {h="h"}; {print $0 (g=="g"?" (g)":"") (h=="h"?" (h)":"")}' |
			zzcolunar -w 20 3
			return 0
		;;
		-g) topico='green500'; shift ;;
		-p) topico='hpcg' ;    shift ;;
		-i)
			if test -n "$2" && zztool testa_numero "$2"
			then
				ini="$2"
			else
				zztool -e uso top
				return 1
			fi
			shift
			shift
		;;
		-f)
			if test -n "$2" && zztool testa_numero "$2"
			then
				fim="$2"
			else
				zztool -e uso top
				return 1
			fi
			shift
			shift
		;;
		-*) zztool -e uso top; return 1 ;;
		esac
	done

	if test "$fim" -lt "$ini"
	then
		zztool -e uso top
		return 1
	fi

	# Pagina a serem consideradas nos links em função da posição inicial e final
	pag_ini=$(echo "scale=0;((${ini}-1)/100)+1" | bc -l)
	pag_fim=$(echo "scale=0;((${fim}-1)/100)+1" | bc -l)

	all_releases=$(
		zztool source "${url}/statistics/list" |
		sed -n '/option value/{s/^.*value="//;s/<\/option>$//;s/".*>/	/;p;}' |
		sed '/June 1993$/q'
	)

	# Escolha da lista
	if test -n "$1"
	then
		if zztool testa_numero "$1"
		then
			release="$1"
		else
			zztool -e uso top
			return 1
		fi
	fi

	# Definindo a lista em caso de omissão
	max_release=$(echo "$all_releases" | head -n 1 | sed 's/	.*//')
	if test -z "$release"
	then
		release=$max_release
	elif test "$release" -gt "$max_release"
	then
		release=$max_release
	fi

	# Dafinindo ano e mês
	ano=$(echo "$all_releases" | sed -n "/^${release}	/{s/.* //;p;}")
	mes=$(
		echo "$all_releases" |
		awk -v awk_release="$release" 'BEGIN {
			mes["January"]=1; mes["February"]=2; mes["March"]=3; mes["April"]=4;
			mes["May"]=5; mes["June"]=6; mes["July"]=7; mes["August"]=8;
			mes["September"]=9; mes["October"]=10; mes["November"]=11; mes["December"]=12;
			}
			{if ($1 == awk_release) printf "%02d\n", mes[$2]}'
	)

	# Data da lista
	if test -n "$ano"
	then
		echo "$mes/$ano"
	else
		echo "$cache" |
		sed -n '/option value/{s/^.*value="//;s/<\/option>$//;s/".*>/ /;p;}' |
		sed '/June 1993$/q' |
		sed -n "/^$release /{s/^[0-9]\{1,\} //;p;}"
	fi

	# Extraindo a lista escolhida
	for pag in $(seq "$pag_ini" "$pag_fim")
	do
		zztool source "${url}/lists/${topico}/list/${ano}/${mes}/?page=${pag}"
	done |
		zzxml --tag tr --notag thead --tidy |
		zzjuntalinhas -i '<td' -f 'td>' -d '' |
		zzjuntalinhas -i '<tr' -f 'tr>' -d '|' |
		sed 's/<\/a>/|/g; s/<a [^>]*>/|/g' |
		zzxml --untag |
		zzsqueeze |
		sed 's/,\{0,1\}[[:blank:]]\{1,\}|[[:blank:]]*/|/g' |
		tr -s '|' |
		awk -F '|' -v a_ini="$ini" -v a_fim="$fim" -v a_top="$topico" '
			$2 < a_ini { next }
			{
				printf "%03d: ", $2

				if (a_top=="top500") {
					print $3, "(" $4 ")"
					print " ├── " $5, "(" $6 ")"
					print " └── Cores:", $7,"| RMax:", $8, "| RPeak:", $9, "| Power:", (length($10)==0?"-":$10)
				}

				if (a_top=="green500") {
					print $4, "(" $5 ")"
					print " ├── " $6, "(" $7 ")"
					print " ├── Cores:", $8,"| RMax:", $9, "| Power:", (length($11)==0?"-":$10), "| Power Efficiency :", (length($11)==0?$10:$11)
					print " └── TOP500 Rank: ", $3
				}

				if (a_top=="hpcg") {
					print $4, "(" $5 ")"
					print " ├── " $6, "(" $7 ")"
					print " ├── Cores:", $8,"| RMax:", $9, "| HPCG:", (length($10)==0?"-":$10)
					print " └── TOP500 Rank: ", $3
				}

				print ""
			}
			$2 >= a_fim { exit }
		' |
	zzunescape --html |
	zztrim -r
}

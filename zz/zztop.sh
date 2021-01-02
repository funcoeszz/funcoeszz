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
#
# Argumentos de listagem:
#  [lista]:     Seleciona a lista, se omitida mostra mais recente.
#
# Sem argumentos usa a listagem mais recente.
#
# Uso: zztop [-l] [-i número] [-f número] [lista]
# Ex.: zztop               # Lista os 10 mais rápidos.
#      zztop 23            # Lista os 10 mais rápidos em Junho de 2004
#      zztop -i 5          # Lista do 5º ao 10º mais rápido
#      zztop -f 270        # Lista os 270 mais rápidos
#      zztop -i 2 -f 5 40  # Lista do 2º ao 5º de Novembro 2012
#      zztop -l            # Exibe todas as listas disponíveis
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2015-07-19
# Versão: 3
# Licença: GPL
# Requisitos: zzcolunar zztac zztrim zzunescape zzxml
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zztop ()
{

	zzzz -h top "$1" && return

	local url="http://top500.org"
	local release all_releases max_release ano mes pag pag_ini pag_fim
	local ini=1
	local fim=10

	# Argumento apenas para exibir opções diponíveis e sair
	while test "${1#-}" != "$1"
	do
		case "$1" in
		-l)
		# Meses e anos disponíveis, representado por um número sequencial
			zztool source "${url}/statistics/list" |
			sed -n '/option value/{s/^.*value="//;s/<\/option>$//;s/".*>/	/;p;}' |
			sed '/June 1993$/q' |
			expand -t 3 |
			zztac |
			zzcolunar -w 20 3
			return 0
		;;
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
		zztool source "${url}/lists/top500/list/${ano}/${mes}/?page=${pag}" |
		# sed '/<td style=/,/<\/td>/d' |
		zzxml --tag td --notag thead --tidy |
		sed '
			s/^[0-9]\{1,\},/ &/
			/googletag/d
			/system/{ s/.*="//;s/".*//; }
			s/<[^>]*>//g'
	done |
	awk '
		NF==0{ next }
		$1 ~ /^[0-9]+$/{ print "" }
		{ printf $0 "|" }
	' |
	sed '
		/^[[:blank:]]*$/d
		s/| -/ -/
		s/|$//
	' |
	awk -F '|' -v a_ini="$ini" -v a_fim="$fim" '
		NF < 7 { next }
		$1 < a_ini { next }
		{
			printf "%03d: ", $1
			print $3, "(" $4 ")"
			print " ├── " $5, "(" $6 ")"
			print " └── Cores:", $7,"| RMax:", $8, "| RPeak:", $9
			print ""
		}
		$1 >= a_fim { exit }
	' |
	zzunescape --html |
	zztrim -r |
	sed '
		s/[[:blank:]]*)/)/g
		s/([[:blank:]]\{1,\}/(/g
		s/[[:blank:]]\{2,\}\([-(]\)/ \1/g
		s/[[:blank:]]\{2,\}/ /g
	'
}

# ----------------------------------------------------------------------------
# Lista os 10 computadores mais rápidos do mundo.
# Sem argumentos usa a listagem mais recente.
# Definindo categoria, quantifica os 500 computadores mais rápidos.
#
# Argumentos de ajuda:
#  -c: Exibe categorias possíveis
#  -l: Exibe as listas disponíveis
#
# Argumentos de listagem:
#  [categoria]: Seleciona a categoria desejada.
#  [lista]:     Seleciona a lista, se omitida mostra mais recente.
# Obs: Podem ser usadas em conjunto
#
# Uso: zztop [-c|-l] [categoria] [lista]
# Ex.: zztop             # Lista os 10 mais rápidos.
#      zztop osfam 23    # Famílias de OS em Junho de 2004 ( Virada Linux! )
#      zztop country     # Quantifica por pais entre os 500 mais velozes
#      zztop -c          # Lista as categorias possíveis da listagem
#      zztop -l          # Exibe todas as listas disponíveis
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2015-07-19
# Versão: 2
# Licença: GPL
# Requisitos: zztac zzcolunar zzecho zzxml zzunescape zztrim
# ----------------------------------------------------------------------------
zztop ()
{

	zzzz -h top "$1" && return

	local url="http://top500.org"
	local cor='amarelo'
	local ntab=35
	local cache category release all_releases max_release ano mes

	# Argumento apenas para exibir opções diponíveis e sair
	while test "${1#-}" != "$1"
	do
		case "$1" in
		-c)
		# Categorias pela qual a lista se subdivide
			zzecho -l $cor "vendor        Vendors"
			zzecho -l $cor "app           Application Area"
			zzecho -l $cor "accel         Accelerator/Co-Processor"
			zzecho -l $cor "segment       Segments"
			zzecho -l $cor "continent     Continents"
			zzecho -l $cor "connfam       Interconnect Family"
			zzecho -l $cor "interconnect  Interconnect"
			zzecho -l $cor "country       Countries"
			zzecho -l $cor "region        Geographical Region"
			zzecho -l $cor "procgen       Processor Generation"
			zzecho -l $cor "accelfam      Accelerator/CP Family"
			zzecho -l $cor "architecture  Architecture"
			zzecho -l $cor "osfam         Operating system Family"
			zzecho -l $cor "cores         Cores per Socket"
			zzecho -l $cor "os            Operating System"
			return 0
		;;
		-l)
		# Meses e anos disponíveis, representado por um número sequencial
			zztool source "${url}/statistics/list" |
			sed -n '/option value/{s/^.*value="//;s/<\/option>$//;s/".*>/	/;p;}' |
			sed '/June 1993$/q' | expand -t 3 |
			zztac | zzcolunar -w 20 3
			return 0
		;;
		-*) zztool -e uso top; return 1 ;;
		esac
	done

	all_releases=$(
		zztool source "${url}/statistics/list" |
		sed -n '/option value/{s/^.*value="//;s/<\/option>$//;s/".*>/	/;p;}' |
		sed '/June 1993$/q'
	)

	while test -n "$1"
	do
		# Escolha da categoria
		case "$1" in
			vendor | app | accel | procgen | os)                  category="$1"; ntab=35; shift;;
			connfam | interconnect | country | region | accelfam) category="$1"; ntab=28; shift;;
			segment | continent | architecture | osfam | cores)   category="$1"; ntab=12; shift;;
		esac
		# Escolha da lista
		if zztool testa_numero "$1"
		then
			release="$1"
			shift
		fi
	done

	# Definindo a lista em caso de omissão
	max_release=$(echo "$all_releases" | head -n 1 | sed 's/	.*//')
	if test -z "$release"
	then
		release=$max_release
	elif test "$release" -gt "$max_release"
	then
		release=$max_release
	fi

	# Redefinindo url
	if test -n "$category"
	then
		url="${url}/statistics/list/${release}/${category}"
	else
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
		url="${url}/lists/${ano}/${mes}/"
	fi

	# Cacheando
	cache=$(zztool source "$url")

	# Data da lista
	if test -n "$ano"
	then
		echo "$mes/$ano"
	else
		echo "$cache" |
		sed -n '/option value/{s/^.*value="//;s/<\/option>$//;s/".*>/ /;p;}' |
		sed '/June 1993$/q' | sed -n "/^$release /{s/^[0-9]\{1,\} //;p;}"
	fi

	# Extraindo a lista escolhida
	if test -n "$category"
	then
		echo "$cache" |
		sed -n "/dataTable.addRows/{n;p;}" |
		sed "s/^ *//;s/',/	/g" |
		tr -d '\\' | tr -d "['," | tr ']' '\n' |
		expand -t $ntab
	else
		echo "$cache" | sed '/<td style=/,/<\/td>/d' |
		zzxml --tag td --notag thead --untag |
		sed '/^[0-9]\{1,\},/d;/googletag/d' |
		awk '$1 ~ /^[0-9]+$/{print ""};{printf $0"|"}'|
		sed '1d;s/| -/ -/;s/|$//' |
		awk -F'|' '{printf "%02d: ", $1; print $2, "(" $3 ")";print "    " $4, "(" $5 ")", $6; print ""}' |
		zzunescape --html |
		zztrim -r |
		sed 's/ *)/)/g;s/  *(/ (/g'
	fi
}

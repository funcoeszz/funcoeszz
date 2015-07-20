# ----------------------------------------------------------------------------
# Lista o ranking dos 500 computadores mais rápidos do mundo.
# Sem argumentos exibe os fabricantes da lista mais recente.
#
# Argumentos de ajuda:
#  -c: Exibe categorias possíveis
#  -l: Exibe as listas diponíveis
#
# Argumentos de listagem:
#  [categoria]: Seleciona a categoria desejada, padrão 'vendor'
#  [lista]:     Seleciona a lista, se omitida mostra mais recente
# Obs: Podem ser usadas em conjunto
#
# Uso: zztop [-c|-l] [categoria] [lista]
# Ex.: zztop             # Lista mais atual por fornecedor
#      zztop osfam 23    # Famílias de OS em Junho de 2004 ( Virada Linux! )
#      zztop country     # Lista mais atual por país
#      zztop -c          # Lista as categorias possíveis da listagem
#      zztop -l          # Exibe todas as listas disponíveis
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2015-07-19
# Versão: 1
# Licença: GPL
# Requisitos: zztac zzcolunar zzdatafmt zzecho
# ----------------------------------------------------------------------------
zztop ()
{

	zzzz -h top "$1" && return

	local url="http://top500.org/statistics/list"
	local cor='amarelo'
	local ntab=35
	local cache category release add_release max_release

	# Argumento apenas para exibir opções diponíveis e sair
	while test "${1#-}" != "$1"
	do
		case "$1" in
		-l)
		# Meses e anos disponíveis, representado por um número sequencial
			$ZZWWWHTML "$url" |
			sed -n '/option value/{s/^.*value="//;s/<\/option>$//;s/".*>/\t/;p;}' |
			sed '/June 1993$/q' | expand -t 3 |
			zztac | zzcolunar -w 20 3
			return 0
		;;
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
		-*) return 1 ;;
		esac
	done

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

	# Definindo padrão para categoria em caso de omissão
	test -z "$category" && category='vendor'

	# Definindo a lista em caso de omissão
	add_release=0
	test $(zzdatafmt -f M hoje) -gt 6 && add_release=1
	test $(zzdatafmt -f M hoje) -gt 11 && add_release=2
	max_release=$(echo "($(zzdatafmt -f AAAA hoje) - 1993) * 2 + $add_release" | bc)
	if test -z "$release"
	then
		release=$max_release
	elif test "$release" -gt "$max_release"
	then
		release=$max_release
	fi

	# Redefinindo url e cacheando
	url="${url}/${release}/$category"
	cache=$($ZZWWWHTML "$url")

	# Data da lista
	echo "$cache" |
	sed -n '/option value/{s/^.*value="//;s/<\/option>$//;s/".*>/ /;p;}' |
	sed '/June 1993$/q' | sed -n "/^$release /{s/^[0-9]\{1,\} //;p;}"

	# Extraindo a lista escolhida
	echo "$cache" |
	sed -n "/dataTable.addRows/{n;p;}" |
	sed "s/^ *//;s|\\\||g;s/',/\t/g"|
	tr -d "['," | tr ']' '\n' | expand -t $ntab
}

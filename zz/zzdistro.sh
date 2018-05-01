# ----------------------------------------------------------------------------
# Lista o ranking das distribuições no DistroWatch.
# Sem argumentos lista dos últimos 6 meses
# Se o argumento for 1, 3, 6 ou 12 é a ranking nos meses correspondente.
# Se o argumento for 2002 até o ano passado, é a ranking final desse ano.
# Se o primeiro argumento for -l, lista os links da distribuição no site.
#
# Uso: zzdistro [-l] [meses|ano]
# Ex.: zzdistro
#      zzdistro 2010  # Ranking em 2010
#      zzdistro 3     # Ranking dos últimos 3 meses.
#      zzdistro       # Ranking dos últimos 6 meses, com os links.
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2014-06-15
# Versão: 2
# Licença: GPL
# Requisitos: zzcolunar
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzdistro ()
{
	zzzz -h distro "$1" && return

	local url="http://distrowatch.com/"
	local lista=0
	local meses="1 4
3 13
6 26
12 52"

	test '-l' = "$1" && { lista=1; shift; }
	case $1 in
	1 | 3 | 6 | 12) url="${url}index.php?dataspan=$(echo "$meses" | awk '$1=='$1' {print $2}')"; shift ;;
	*)
	zztool testa_numero $1 && test $1 -ge 2002 -a $1 -lt $(date +%Y) && url="${url}index.php?dataspan=$1" && shift ;;
	esac

	test -n "$1" && { zztool -e uso distro; return 1; }

	zztool source "$url" | sed '1,/>Rank</d' |
	awk -F'"' '
		/phr1/ || /<th class="News">[0-9][0-9]?[0-9]?<\/th>/ {
			printf "%s\t", $3
			getline
			printf "%s\thttp://distrowatch.com/%s\n", $5, $4
		}
	' |
	sed 's/<[^>]*>//g;s/>//g' |
	if [ $lista -eq 1 ]
	then
		expand -t 4,18 | zzcolunar -w 60 2
	else
		sed 's/ *http.*//' | expand -t 4 | zzcolunar 4
	fi
}

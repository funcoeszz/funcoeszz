# ----------------------------------------------------------------------------
# Lista o ranking das distribuições no distrowatch.
# Sem argumentos lista dos últimos 6 meses
# Se o argumento for 1, 3, 6 ou 12 é a ranking nos meses correspondente.
# Se o argumento for 2002 até o ano passado, é a ranking final desse ano.
#
# Uso: zzdistro [meses|ano]
# Ex.: zzdistro
#      zzdistro 2010  # Ranking em 2010
#      zzdistro 3     # Ranking dos últimos 3 meses.
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2014-06-15
# Versão: 1
# Licença: GPL
# Requisitos: zzcolunar
# ----------------------------------------------------------------------------
zzdistro ()
{
	zzzz -h distro "$1" && return

	local url="http://distrowatch.com/"
	local meses="1 4
3 13
6 26
12 52"

	case $1 in
	1 | 3 | 6 | 12) url="${url}index.php?dataspan=$(echo "$meses" | awk '$1=='$1' {print $2}')"; shift ;;
	*)
	zztool testa_numero $1 && test $1 -ge 2002 -a $1 -lt $(date +%Y) && url="${url}index.php?dataspan=$1" && shift ;;
	esac

	[ $1 ] && { zztool uso distro; return 1; }

	$ZZWWWHTML "$url" | sed '1,/>Rank</d' |
	awk -F'"' '
		/phr1/ || /<th class="News">[0-9]{1,3}<\/th>/ {
			printf "%s\t", $3
			getline
			printf "%s\thttp://distrowatch.com/%s\n", $5, $4
		}
	' |
	sed 's/<[^>]*>//g;s/>//g' |
	expand -t 4,18 |
	zzcolunar -w 60 2
}

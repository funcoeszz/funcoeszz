# ----------------------------------------------------------------------------
# Localiza geograficamente seu IP de Internet ou um que seja informado.
# Uso: zzgeoip [ip]
# Ex.: zzgeoip
#      zzgeoip 187.75.22.192
#
# Autor: Alexandre Magno <alexandre.mbm (a) gmail com>
# Desde: 2013-07-06
# Versão: 3
# Licença: GPLv2
# Requisitos: zzxml zzipinternet zzecho zzminiurl
# ----------------------------------------------------------------------------
zzgeoip ()
{
	zzzz -h geoip "$1" && return

	local ip pagina latitude longintude cidade uf pais mapa
	local url='http://geoip.s12.com.br'

	if [ $# -ge 2 ]
	then
		zztool uso geoip
		return 1
	elif [ "$1" ]
	then
		zztool -e testa_ip "$1"
		[ $? -ne 0 ] && zztool uso geoip && return 1
		ip="$1"
	else
		ip=$(zzipinternet)
	fi

	pagina=$($ZZWWWHTML http://geoip.s12.com.br?ip=$ip |
				zzxml --tidy --untag --tag td |
				sed '/^[[:blank:]]*$/d;/&/d' |
				awk '{if ($0 ~ /:/) { printf "\n%s",$0 } else printf $0}'
			)

	cidade=$(echo "$pagina" |
			grep 'Cidade:' |
			cut -f2 -d:)

	uf=$(echo "$pagina" |
			grep 'Estado:' |
			cut -f2 -d:)

	pais=$(echo "$pagina" |
			grep 'País:' |
			cut -f2 -d:)

	latitude=$(echo "$pagina" |
			grep 'Latitude:' |
			cut -f2 -d: |
			tr ',' '.')

	longitude=$(echo "$pagina" |
			grep 'Longitude:' |
			cut -f2 -d: |
			tr ',' '.')

	mapa=$(zzminiurl "$url/mapa.asp?lat=$latitude&lon=$longitude&cidade=$cidade&estado=$uf")

	zzecho -n '       IP: '; zzecho -l verde -N "${ip:- }"
	zzecho -n '   Cidade: '; zzecho -N "${cidade:- }"
	zzecho -n '   Estado: '; zzecho -N "${uf:- }"
	zzecho -n '     País: '; zzecho -N "${pais:- }"
	zzecho -n ' Latitude: '; zzecho -l amarelo "${latitude:- }"
	zzecho -n 'Longitude: '; zzecho -l amarelo "${longitude:- }"
	zzecho -n '     Mapa: '; zzecho -l azul "${mapa:- }"
}

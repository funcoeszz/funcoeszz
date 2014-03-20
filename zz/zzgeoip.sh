# ----------------------------------------------------------------------------
# Localiza geograficamente seu IP de Internet ou um que seja informado.
# Uso: zzgeoip [ip]
# Ex.: zzgeoip
#      zzgeoip 187.75.22.192
#
# Autor: Alexandre Magno <alexandre.mbm (a) gmail com>
# Desde: 2013-07-06
# Versão: 1
# Licença: GPLv2
# Requisitos: zzxml zzipinternet zzecho zzminiurl
# ----------------------------------------------------------------------------
zzgeoip ()
{
	zzzz -h geoip "$1" && return
	
	local ip pagina src latitude longintude cidade uf pais mapa
	local url='http://geoip.s12.com.br'

	if [ $# -ge 2 ]
	then
		zztool uso geoip
		return 1
	elif [ $1 ]
	then
		zztool -e testa_ip $1
		[ $? -ne 0 ] && zztool uso geoip && return 1
		ip=$1
    else
        ip=$(zzipinternet)
    fi	

    pagina=$($ZZWWWHTML "$url?ip=$ip")

	pais=$(echo -e "$pagina" |
			zzxml --tag 'tr' |
			grep 'País:' |
			zzxml --tag 'strong' --untag)

	src=$(echo -e "$pagina" |
			zzxml --tag 'td' |
			grep 'tx_verde_14' |
			sed -e 's/^.* src=\"//' -e 's/\" width=.*$//' |
			sed 's/\&amp\;/\&/g')

	mapa=$(zzminiurl "$url/$src")

    src=$(echo "$src" | sed -e 's/^.*lat=//g' -e 's/\&[a-z]*=/|/g')

    # 50,9832992553711|7,13329982757568|Bergisch Gladbach|DF

	latitude=$(echo "$src" | cut -d'|' -f1)
	longitude=$(echo "$src" | cut -d'|' -f2)
	cidade=$(echo "$src" | cut -d'|' -f3)
	uf=$(echo "$src" | cut -d'|' -f4)

	latitude=${latitude/,/.}
	longitude=${longitude/,/.}

	# mapa="http://maps.google.com/maps?q=$latitude,$longitude" (bug)

	echo
	zzecho -n '        IP: '; zzecho -l verde -N "$ip"
	zzecho -n '    Cidade: '; zzecho -N "$cidade"
	zzecho -n '    Estado: '; zzecho -N "$uf"
	zzecho -n '      País: '; zzecho -N "$pais"
	zzecho -n '  Latitude: '; zzecho -l amarelo -e "\\$latitude"
	zzecho -n ' Longitude: '; zzecho -l amarelo -e "\\$longitude"
	zzecho -n '      Mapa: '; zzecho -l azul "$mapa"
	echo
}

# ----------------------------------------------------------------------------
# http://scifibrasil.com.br/data/
# Calcula a data estelar, a partir de uma data e horário.
#
# Sem argumentos calcula com a data e hora atual.
#
# Com um argumento, calcula conforme descrito:
#   Se for uma data válida, usa 0h 0min 0seg do dia.
#   Se for um horário, usa a data atual.
#
# Com dois argumentos sendo data seguida da hora.
#
# Uso: zzdataestelar [[data|hora] | data hora]
# Ex.: zzdataestelar
#      zzdataestelar hoje
#      zzdataestelar 25/01/2000
#      zzdataestelar 13:47:26
#      zzdataestelar 08/03/2010 14:25
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-10-28
# Versão: 1
# Licença: GPL
# Requisitos: zzdata zzdatafmt zznumero zzhora
# ----------------------------------------------------------------------------
zzdataestelar ()
{
	zzzz -h dataestelar "$1" && return

	local ano mes dia hora minuto segundo dias
	local tz=$(date "+%:z")

	case "$#" in
	0)
		# Sem agumento usa a data e hora atual UTC
		set - $(date -u "+%Y %m %d %H %M %S")
		ano=$1
		mes=$2
		dia=$3
		hora=$4
		minuto=$5
		segundo=$6
	;;
	1)
		if zzdata "$1" >/dev/null 2>&1
		then
			set - $(zzdatafmt -f "AAAA MM DD" "$1")
			ano=$1
			mes=$2
			dia=$3
			hora=0
			minuto=0
			segundo=0
		fi

		if zztool grep_var ':' "$1"
		then
			set - $(echo "$1" | sed 's/:/ /g')
			segundo=${3:-0}

			set - $(zzhora ${1}:${2} - $tz | sed 's/:/ /g')
			hora=$1
			minuto=$2

			set - $(zzdatafmt -f "AAAA MM DD" hoje)
			ano=$1
			mes=$2
			dia=$3
		fi
	;;
	2)
		if zzdata $1 >/dev/null 2>&1 && zztool grep_var ':' "$2"
		then
			set - $(zzdatafmt -f "AAAA MM DD $2" "$1" | sed 's/:/ /g')
			ano=$1
			mes=$2
			dia=$3
			segundo=${6:-0}

			set - $(zzhora "${4}:${5}" - "$tz" | sed 's/:/ /g')
			hora=$1
			minuto=$2
		fi
	;;
	esac

	if zztool testa_numero $ano
	then
		dias=$(zzdata ${dia}/${mes}/${ano} - 01/01/${ano})
		dias=$((dias + 1))

		echo "scale=6;(($ano + 4712) * 365.25) - 13.375 + ($dias * (1+59.2/86400)) + ($hora/24) + ($minuto/1440) + ($segundo/86400)" |
		bc -l | cut -c 3- | zznumero -f "%.2f" | tr ',' '.'
	else
		zztool uso dataestelar -h
		return 1
	fi
}

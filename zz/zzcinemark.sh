# ----------------------------------------------------------------------------
# http://cinemark.com.br/programacao
# Exibe a programação dos cinemas Cinemark de sua cidade.
# Sem argumento lista todas as cidades e todas as salas mostrando os códigos.
# Com o cógigo da cidade lista as salas dessa cidade.
# Com o código das salas mostra os filmes do dia.
# Um segundo argumento caso pode ser a data, para listar os filmes desse dia.
# As datas devem ser futuras e conforme a padrão zzdata
#
# Uso: zzcinemark [codigo_cidade | codigo_cinema] [data]
# Ex.: zzcinemark 1            # Lista os cinemas de São Paulo
#      zzcinemark 662 sab      # Filmes de Raposo Shopping no sábado
#
# Autor: Thiago Moura Witt <thiago.witt (a) gmail.com> <@thiagowitt>
# Desde: 2011-07-05
# Versão: 2
# Licença: GPL
# Requisitos: zzdatafmt zzxml zzunescape zztrim zzcolunar
# Tags: cinema
# ----------------------------------------------------------------------------
zzcinemark ()
{
	zzzz -h cinemark "$1" && return

	local cache=$(zztool cache cinemark)
	local url="http://cinemark.com.br/programacao"
	local cidade codigo dia

	if test "$1" = '--atualiza'
	then
		zztool atualiza cinemark
		shift
	fi

	if ! test -s "$cache"
	then
		# Lista de Cidades
		zztool source "$url" |
		grep '_Cidades\[' |
		sed "s/.*'\([0-9]\{1,2\}\)'/ \1/;s/] = '/:/;s/'.*//" > $cache

		# Lista de Salas por cidade
		zztool source "$url" |
		grep '_Cinemas\[' |
		sed "s/.*'\([0-9]\{1,2\}\)'/\1/;s/');//;s/].*( '/:/;s/'[^']*'/:/g" >> $cache
	fi

	if test $# = 0
	then
		# mostra opções
		echo "                                   Cidades e Salas disponíveis                                   "
		echo "================================================================================================="
		cat $cache |
		sed 's/^ /0/' |
		sort -n |
		awk -F ":" '
			NF==2 {printf "\n%s (Cod: %02d)\n", $2, $1}
			NF>2 {
				for (i=2;i<=NF;i+=2) {
					printf " %4s) %s\n", $i, $(i+1)
				}
			}
		' | zzcolunar 2
		return 0
	elif zztool testa_numero $1 && test $1 -lt 100
	then
		grep "^ *$1:" $cache |
		sort -n |
		awk -F ":" '
			NF==2 {printf "%s (Cod: %02d)\n", $2, $1}
			NF>2 {
				for (i=2;i<=NF;i+=2) {
					printf " %4s) %s\n", $i, $(i+1)
				}
			}
		'
		return 0
	elif zztool testa_numero $1 && test $1 -ge 100
	then
		if test -n "$2"
		then
			case "$2" in
					# apelidos
					hoje | amanh[ãa])
						dia=$(zzdatafmt -f "DD-MM-AAAA" $2)
					;;
					# semana (curto)
					dom | seg | ter | qua | qui | sex | sab)
						dia=$(zzdatafmt -f "DD-MM-AAAA" $2)
					;;
					# semana (longo)
					domingo | segunda | ter[cç]a | quarta | quinta | sexta | s[aá]bado)
						dia=$(zzdatafmt -f "DD-MM-AAAA" $2)
					;;
			esac

			if test -z "$dia"
			then
				if zztool testa_data $2
				then
					dia=$(zzdatafmt -f "DD-MM-AAAA" $2)
				else
					dia=$(zzdatafmt -f "DD-MM-AAAA" hoje)
				fi
			fi
		else
			dia=$(zzdatafmt -f "DD-MM-AAAA" hoje)
		fi

		zztool eco $(grep ":$1:" $cache | sed "s/.*:$1://;s/:.*//")

		zztool source "${url}/cinema/$1" |
		sed -n '/class="date-tab-content"/,/_Cidades/p' |
		sed -n '/class="date-tab-content"/p;/<h4>/p;/[0-9]h[0-9]/p;/images\/\(exibicao\|censura\)\//p' |
		awk '{
			if ($0 ~ /images/) {reserva=$0 }
			else if ($0 ~ /date-tab-content/) {print; print ""}
			else if ($0 ~ /[0-9]h[0-9]/){ print reserva; print; print "" }
			else print
			}' |
		sed '/date-/{ s/.*date-\(....\)-\(..\)-\(..\).*/Dia: \3-\2-\1/; }' |
		sed '/class="exibicao"/d;s/<[^>]*alt="\([A-Za-z0-9 ]*\)">/\1  /g' |
		zztrim |
		sed -n "/${dia}/,/Dia: /p" | sed '$d' |
		zzxml --untag | zzunescape --html
	fi
}

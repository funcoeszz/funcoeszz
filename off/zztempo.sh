# ----------------------------------------------------------------------------
# http://weather.noaa.gov/
# Mostra as condições do tempo (clima) em um determinado local.
# Se nenhum parâmetro for passado, são listados os países disponíveis.
# Se só o país for especificado, são listadas as suas localidades.
# As siglas também podem ser usadas, por exemplo SBPA = Porto Alegre.
# Uso: zztempo <país> <localidade>
# Ex.: zztempo 'United Kingdom' 'London City Airport'
#      zztempo brazil 'Curitiba Aeroporto'
#      zztempo brazil SBPA
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2004-02-19
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2016-08-28 Site foi descontinuado (veja issue #333)
zztempo ()
{
	zzzz -h tempo "$1" && return

	local codigo_pais codigo_localidade localidades
	local pais="$1"
	local localidade="$2"
	local cache_paises=$(zztool cache tempo)
	local cache_localidades=$(zztool cache tempo)
	local url='http://weather.noaa.gov'

	# Se o cache de países está vazio, baixa listagem da Internet
	if ! test -s "$cache_paises"
	then
		zztool source "$url" | sed -n '
			/="country"/,/\/select/ {
				s/.*="\([a-zA-Z]*\)">\(.*\) <.*/\1 \2/p
			}' > "$cache_paises"
	fi

	# Se nenhum parâmetro for passado, são listados os países disponíveis
	if ! test -n "$pais"
	then
		sed 's/^[^ ]*  *//' "$cache_paises"
		return
	fi

	# Grava o código deste país (BR  Brazil -> BR)
	codigo_pais=$(grep -i "$1" "$cache_paises" | sed 's/  .*//' | sed 1q)

	# O país existe?
	if ! test -n "$codigo_pais"
	then
		zztool erro "País \"$pais\" não encontrado"
		return 1
	fi

	# Se o cache de locais está vazio, baixa listagem da Internet
	cache_localidades=$cache_localidades.$codigo_pais
	if ! test -s "$cache_localidades"
	then
		zztool source "$url/weather/${codigo_pais}_cc.html" | sed -n '
			/="cccc"/,/\/select/ {
				//d
				s/.*="\([a-zA-Z]*\)">/\1 /p
			}' > "$cache_localidades"
	fi

	# Se só o país for especificado, são listadas as localidades deste país
	if ! test -n "$localidade"
	then
		cat "$cache_localidades"
		return
	fi

	# Pesquisa nas localidades
	localidades=$(grep -i "$localidade" "$cache_localidades")

	# A localidade existe?
	if ! test -n "$localidades"
	then
		zztool erro "Localidade \"$localidade\" não encontrada"
		return 1
	fi

	# Se mais de uma localidade for encontrada, mostre-as
	if test $(echo "$localidades" | zztool num_linhas) != 1
	then
		echo "$localidades"
		return 0
	fi

	# Grava o código do local (SBCO  Porto Alegre -> SBCO)
	codigo_localidade=$(echo "$localidades" | sed 's/  .*//')

	# Faz a consulta e filtra o resultado
	zztool dump "$url/weather/current/${codigo_localidade}.html" | sed -n '
		/Current Weather/,/24 Hour/ {
			//d
			/____*/d
			/----*/d
			/^ *$/d
			s/ *$//
			s/^ *//
			/Conditions at /d
			p
		}' |
		sed '2,$ s/^/   /'
}

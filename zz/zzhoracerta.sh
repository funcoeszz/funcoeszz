# ----------------------------------------------------------------------------
# http://www.worldtimeserver.com
# Mostra a hora certa de um determinado local.
# Se nenhum parâmetro for passado, são listados as localidades disponíveis.
# O parâmetro pode ser tanto a sigla quando o nome da localidade.
# A opção -s realiza a busca somente na sigla.
# Uso: zzhoracerta [-s] local
# Ex.: zzhoracerta rio grande do sul
#      zzhoracerta -s br
#      zzhoracerta rio
#      zzhoracerta us-ny
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2004-03-29
# Versão: 4
# Licença: GPL
# Tags: internet, tempo, consulta
# ----------------------------------------------------------------------------
zzhoracerta ()
{
	zzzz -h horacerta "$1" && return

	local codigo localidade localidades
	local cache=$(zztool cache horacerta)
	local url='http://www.worldtimeserver.com'

	# Opções de linha de comando
	if test '-s' = "$1"
	then
		shift
		codigo="$1"
	else
		localidade="$*"
	fi

	# Se o cache está vazio, baixa listagem da Internet
	# De: <li><a href="current_time_in_AR-JY.aspx">Jujuy</a></li>
	# Para: AR-JY -- Jujuy
	if ! test -s "$cache"
	then
		zztool source "$url/country.html" |
			grep 'current_time_in_' |
			sed 's/.*_time_in_// ; s/\.aspx">/ -- / ; s/<.*//' > "$cache"
	fi

	# Se nenhum parâmetro for passado, são listados os países disponíveis
	if ! test -n "$localidade$codigo"
	then
		cat "$cache"
		return
	fi

	# Faz a pesquisa por codigo ou texto
	if test -n "$codigo"
	then
		localidades=$(grep -i "^[^ ]*$codigo" "$cache")
	else
		localidades=$(grep -i "$localidade" "$cache")
	fi

	# Se mais de uma localidade for encontrada, mostre-as
	if test $(echo "$localidades" | zztool num_linhas) != 1
	then
		echo "$localidades"
		return
	fi

	# A localidade existe?
	if ! test -n "$localidades"
	then
		zztool erro "Localidade \"$localidade$codigo\" não encontrada"
		return 1
	fi

	# Grava o código da localidade (BR-RS -- Rio Grande do Sul -> BR-RS)
	localidade=$(echo "$localidades" | sed 's/ .*//')

	# Faz a consulta e filtra o resultado
	zztool dump "$url/current_time_in_$localidade.aspx" |
		sed -n '/Current Time in /,/Daylight Saving Time:/{
			s/Current Time in //
			/[?:]$/d
			/^ *$/d
			s/^ *//
			p
		}'
}

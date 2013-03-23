# ----------------------------------------------------------------------------
# http://www.ietf.org/timezones/data/iso3166.tab
# Busca a descrição de um código de país da internet (.br, .ca etc).
# Uso: zzdominiopais [.]código|texto
# Ex.: zzdominiopais .br
#      zzdominiopais br
#      zzdominiopais republic
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-05-15
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
zzdominiopais ()
{
	zzzz -h dominiopais "$1" && return

	local url='http://www.ietf.org/timezones/data/iso3166.tab'
	local cache="$ZZTMP.dominiopais"
	local sistema='/usr/share/zoneinfo/iso3166.tab'
	local padrao=$1
	local arquivo

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso dominiopais; return 1; }

	# Se o padrão inicia com ponto, retira-o e casa somente códigos
	if [ "${padrao#.}" != "$padrao" ]
	then
		padrao="^${padrao#.}"
	fi

	# Se já temos o arquivo de dados no sistema, tudo certo
	# Senão, baixa da internet
	if test -f "$sistema"
	then
		arquivo="$sistema"
	else
		arquivo="$cache"

		# Se o cache está vazio, baixa listagem da Internet
		if ! test -s "$cache"
		then
			$ZZWWWDUMP "$url" > "$cache"
		fi
	fi

	# O formato padrão de saída é BR - Brazil
	grep -i "$padrao" "$arquivo" |
		tr -s '\t ' ' ' |
		sed '/^#/d ; / - /! s/ / - /'
}

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
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzdominiopais ()
{
	zzzz -h dominiopais "$1" && return

	local url='http://www.ietf.org/timezones/data/iso3166.tab'
	local cache="$ZZTMP.dominiopais"
	local cache_sistema='/usr/share/zoneinfo/iso3166.tab'
	local padrao=$1

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso dominiopais; return 1; }

	# Se o padrão inicia com ponto, retira-o e casa somente códigos
	if [ "${padrao#.}" != "$padrao" ]
	then
		padrao="^${padrao#.}"
	fi

	# Primeiro tenta encontrar no cache do sistema
	if test -f "$cache_sistema"
	then
		# O formato padrão de saída é BR - Brazil
		grep -i "$padrao" $cache_sistema |
			tr -s '\t ' ' ' |
			sed '/^#/d ; / - /!s/ / - /'
		return
	fi

	# Ops, não há cache do sistema, então tentamos o cache da Internet

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWDUMP "$url" |
			tr -s '\t ' ' ' |
			sed '/^#/d ; / - /!s/ / - /' > "$cache"
	fi

	# Pesquisa no cache
	grep -i "$padrao" "$cache"
}

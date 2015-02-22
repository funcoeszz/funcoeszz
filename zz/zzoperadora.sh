# ----------------------------------------------------------------------------
# http://consultaoperadora.com.br
# Consulta operadora de um número de telefone fixo/celular.
# O formato utilizado é: <DDD><NÚMERO>
# Não utilize espaços, (), -
# Uso: zzoperadora [número]
# Ex.: zzoperadora 1934621026
#
# Autor: Mauricio Calligaris <mauriciocalligaris@gmail.com>
# Desde: 2013-06-19
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------

zzoperadora ()
{
	zzzz -h operadora "$1" && return

	local url="http://consultaoperadora.com.br"
	local post="numero=$1"

	# Verifica o paramentro
	if (! zztool testa_numero "$1" || test "$1" -eq 0)
	then
		zztool uso operadora
		return 1
	fi

	# Faz a consulta no site
	echo "${post}&tipo=consulta" |
	$ZZWWWPOST "$url" |
	sed -n '/Número:/p' |
	awk '{print $1, $2; print $3, $4; for(i=6;i<=NF;i++) {printf  $i " "}; print ""}'
}

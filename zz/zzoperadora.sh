# ----------------------------------------------------------------------------
# http://www.qualoperadora.net
# Consulta operadora de um número de telefone fixo/celular.
# O formato utilizado é: <DDD><NÚMERO>
# Não utilize espaços, (), -
# Uso: zzoperadora [número]
# Ex.: zzoperadora 1934621026
#
# Autor: Mauricio Calligaris <mauriciocalligaris@gmail.com>
# Desde: 2013-06-19
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------

zzoperadora ()
{
	zzzz -h operadora "$1" && return

	local url="http://www.qualoperadora.net"
	local post="telefone=$1"

	# Verifica o paramentro
	if (
		! zztool testa_numero "$1" ||
		test "$1" -eq 0)
	then
		zztool uso operadora
		return 1
	fi

	# Faz a consulta no site e retira as informações da tag <title>
	# do html da página.
	curl -s --data-urlencode $post $url |
	grep '<title>Resultado' |
	sed 's/<[^>]*>//g;s/-\{0,1\} \{0,1\}[[:upper:]][a-z]*: //g;s/^ */ /'
}

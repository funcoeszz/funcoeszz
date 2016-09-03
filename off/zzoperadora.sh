# ----------------------------------------------------------------------------
# Consulta operadora de um número de telefone fixo/celular.
# O formato utilizado é: <DDD><NÚMERO>
# Não utilize espaços, (), -
# Uso: zzoperadora [número]
# Ex.: zzoperadora 1934621026
#
# Autor: Mauricio Calligaris <mauriciocalligaris@gmail.com>
# Desde: 2013-06-19
# Versão: 4
# Licença: GPL
# Requisitos: zzutf8
# ----------------------------------------------------------------------------
# DESATIVADA: 2016-09-03 Site usam AJAX, impossível consultar :(
zzoperadora ()
{
	zzzz -h operadora "$1" && return

	local url="http://qualoperadora.info/consulta"
	local post="tel=$1"

	# Verifica o paramentro
	if (! zztool testa_numero "$1" || test "$1" -eq 0)
	then
		zztool -e uso operadora
		return 1
	fi

	# Faz a consulta no site
	zztool post lynx "$url" "$post" | zzutf8 |
	awk 'NR==4 {print "   Número:", $0}; NR==6{printf $0 "   -"}; NR>6 && NR<14 && NF>0'
}

# ----------------------------------------------------------------------------
# Mostra o seu número IP (externo) na Internet.
# Retorna IPv4 por padrão ou com o argumento '-4'. Com '-6' retorna o IPv6.
# Uso: zzipinternet [-4|-6]
# Ex.: zzipinternet
#      zzipinternet -4
#      zzipinternet -6
#      zzipinternet -6 || zzipinternet -4
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2005-09-01
# Versão: 7
# Requisitos: zzzz zztool
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzipinternet ()
{
	zzzz -h ipinternet "$1" && return

	local ip

	# Sem parâmetros seta IPv4 :
	if test $# -eq 0
	then
		set -- -4
	elif test $# -gt 1
	then
		zztool erro "Utilizar no máximo 1 argumento."
		return 5
	fi

	# Verifica parametro de entrada 
	case "$1" in 
	-6)
		# Retorna IPv6 se houver, senão vazio.
		ip=$(zztool source 'https://api6.ipify.org')

		# Para IPv6 invalido retorna error code 4
		test -z "$ip" || zztool -e testa_ipv6 $ip || return 4
		;;
	-4)
		# Retorna IPv4 se houver, senão vazio.
		ip=$(zztool source 'https://api4.ipify.org')

		# Para IPv4 invalido retorna error code 3
		test -z "$ip" || zztool -e testa_ipv4 $ip || return 3
		;;
	*)
		# parametro inválido:
		zztool erro "Opção inválida: $1"; 
		return 2;;
	esac

	# Se recebemos $ip vazio, retorna error code 1.
	if test -z "$ip"
	then
		return 1
	else
		# Sem erros. Retorna IP recebido
		echo $ip
	fi
}

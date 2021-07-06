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
# Requisitos: zzzz zztool zztestar
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzipinternet ()
{
	zzzz -h ipinternet "$1" && return

	local ip versao

	if test $# -gt 1
	then
		zztool erro "Utilizar no máximo 1 argumento."
		return 1
	fi

	# Determina versão de ip desejada.
	case "$1" in
		-4 | "")
			versao=4
		;;
		-6)
			versao=6
		;;
		*)
			zztool erro "Opção inválida: $1";
			return 1
		;;
	esac

	ip=$(zztool source "https://api${versao}.ipify.org")

	# IP vazio, não detectado. Pode ser o caso de pedir IPv6 numa
	# máquina onde somente IPv4 está configurado. Retorna 1 para o
	# usuário poder encadear: zzipinternet 6 || zzipinternet 4
	test -z "$ip" && return 1

	# Valida se é um IP mesmo ou se veio outra coisa
	zztestar -e ipv${versao} "$ip" || return 1

	# Sem erros. Retorna IP recebido
	echo "$ip"
}

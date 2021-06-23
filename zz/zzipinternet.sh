# ----------------------------------------------------------------------------
# Mostra o seu número IP (externo) na Internet.
# Aceita os argumentos '--v6', '--v4' (ou ambos) para exibir o IPv6 ou IPv4.
# Com '--v64' retorna o IPv6 externo se existir, senão retorna o IPv4.
# Uso: zzipinternet [--v6|--v4|--v64]
# Ex.: zzipinternet
#      zzipinternet --v6
#      zzipinternet --v64
#      zzipinternet --v6 --v4
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

	# Sem parâmetros seta IPv4 :
	if test $# -eq 0
	then
		set -- --v4
	fi

	#leitura dos parametros de entrada
	while test $# -gt 0
	do
		case "$1" in
		--v6)
			# se houver, IPv6, senão vazio:
			zztool source https://api6.ipify.org | zztool nl_eof;
			shift;;
		--v64)
			# se houver, IPv6, senão IPv4:
			zztool source https://api64.ipify.org | zztool nl_eof;
			shift;;
		--v4)
			# se houver, IPv4, senão vazio:
			zztool source https://api4.ipify.org | zztool nl_eof;
			shift;;
		*) 
			# parametro inválido:
			zztool erro "Opção inválida: $1"; return 1 ;;
		esac
	done
}

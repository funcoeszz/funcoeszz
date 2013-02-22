# ----------------------------------------------------------------------------
# Move os arquivos que tem um prefixo comum para um novo prefixo.
# Opções:
#   -a, --antigo informa o prefixo antigo a ser trocado.
#   -n, --novo   informa o prefixo novo a ser trocado.
# Uso: zzmudaprefixo -a antigo -n novo
# Ex.: zzmudaprefixo -a "antigo_prefixo" -n "novo_prefixo"
#      zzmudaprefixo -a "/tmp/antigo_prefixo" -n "/tmp/novo_prefixo"
#
# Autor: Lauro Cavalcanti de Sa <lauro (a) ecdesa com>
# Desde: 2009-09-21
# Versão: 2
# Licença: GPLv2
# ----------------------------------------------------------------------------
zzmudaprefixo ()
{

	#set -x

	zzzz -h mudaprefixo "$1" && return

	# Verifica numero minimo de parametros.
	if [ $# -lt 4 ] ; then
		zztool uso mudaprefixo
		return 1
	fi

	# Declara variaveis.
	local antigo novo n_sufixo_ini sufixo

	# Opcoes de linha de comando
	while [ $# -ge 1 ]
	do
		case "$1" in
			-a | --antigo)
				[ "$2" ] || { zztool uso mudaprefixo; return 1; }
				antigo=$2
				shift
				;;
			-n | --novo)
				[ "$2" ] || { zztool uso mudaprefixo; return 1; }
				novo=$2
				shift
				;;
			*) { zztool uso mudaprefixo; return 1; } ;;
		esac
		shift
	done

	# Renomeia os arquivos.
	n_sufixo_ini=`echo ${#antigo}`
	n_sufixo_ini=`expr ${n_sufixo_ini} + 1`
	for sufixo in `ls -1 "${antigo}"* | cut -c${n_sufixo_ini}-`;
	do
		# Verifica se eh arquivo mesmo.
		if [ -f "${antigo}${sufixo}" -a ! -s "${novo}${sufixo}" ] ; then
			mv -v "${antigo}${sufixo}" "${novo}${sufixo}"
		else
			echo "CUIDADO: Arquivo ${antigo}${sufixo} nao foi movido para ${novo}${sufixo} porque ou nao eh ordinario, ou destino ja existe!"
		fi
	done

}

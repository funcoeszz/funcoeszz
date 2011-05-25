# ----------------------------------------------------------------------------
# Transforma data do formato DDMMYYYY para DD/MM/YYYY.
# Opções:
#   -d, --data     data no formato DDMMYYYY.
#   -v, --verbose  exibe informações para debug durante o processamento.
# Uso: zzdatabarras -d data
# Ex.: zzdatabarras -d 28012010               # resposta: "28/01/2010"
#
# Autor: Lauro Cavalcanti de Sa <lauro (a) ecdesa com>
# Desde: 2010-01-28
# Versão: 20100128
# Licença: GPLv2
# ----------------------------------------------------------------------------
# DESATIVADA: 2011-05-24 Funcionalidades implementadas na zzdatafmt.
zzdatabarras ()
{
	#set -x
	
	zzzz -h databarras $1 && return
	
	# Declara variaveis.
	local data_barras_1 data_barras_2 data_barras_3 data_barras_4
	
	# Opcoes de linha de comando
	while [ $# -ge 1 ]
	do
		case "$1" in
			-d | --data)
				[ "$2" ] || { zztool uso databarras; return 1; }
				data=$2
				shift
				;;
			-v | --verbose)
				set -x
				;;
			*)
				zztool uso databarras
				set +x
				return 1
				;;
		esac
		shift
	done
	
	if [ ${#data} -ne 8 ]
	then
		zztool uso databarras
		set +x
		return 1
	fi
	
	data_barras_1=`echo ${data} | cut -c1-2`
	data_barras_2=`echo ${data} | cut -c3-4`
	data_barras_3=`echo ${data} | cut -c5-8`
	data_barras_4=`echo ${data} | cut -c9-`
	echo "${data_barras_1}/${data_barras_2}/${data_barras_3}${data_barras_4}"

}

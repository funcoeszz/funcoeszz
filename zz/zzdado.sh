# ----------------------------------------------------------------------------
# Dado virtual.
# Sem argumento, exibe um número aleatório entre 1 e 6.
# Com o argumento -f ou --faces, pode mudar a quantidade de lados do dado.
#
# Uso: zzdado
# Ex.: zzdado
#      zzdado -f 20
#      zzdado --faces 12
#
# Autor: Angelito M. Goulart, www.angelitomg.com
# Desde: 2012-12-05
# Versão: 2
# Licença: GPL
# Requisitos: zzaleatorio
# ----------------------------------------------------------------------------
zzdado ()
{

	local n_faces=6

	# Comando especial das funcoes ZZ
	zzzz -h dado "$1" && return

	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-f|--faces)
				if zztool testa_numero $2;
				then
					n_faces="$2"
				else
					echo "Numero inválido"
					return 1
				fi
			;;
			*)
				echo "Opção inválida"
				return 2
			;;
		esac
		shift
	done

	# Gera e exibe um numero aleatorio entre 1 e o total de faces
	zzaleatorio 1 $n_faces
}

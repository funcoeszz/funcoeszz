# ----------------------------------------------------------------------------
# http://glosbe.com
# Dicionário de Esperanto em inglês, português e alemão.
# Possui busca por palavra nas duas direções. O padrão é português-esperanto.
#
# Uso: zzdicesperanto [-d pt|en|de|eo] [-p pt|en|de|eo] palavra
# Ex.: zzdicesperanto esperança
#      zzdicesperanto -d en job
#      zzdicesperanto -d eo laboro
#      zzdicesperanto -p en trabalho
#
# Autor: Fernando Aires <fernandoaires (a) gmail com>
# Desde: 2005-05-20
# Versão: 4
# Licença: GPL
# ----------------------------------------------------------------------------
zzdicesperanto ()
{
	zzzz -h dicesperanto "$1" && return

	[ "$1" ] || { zztool uso dicesperanto; return 1; }

	local de_ling='pt'
	local para_ling='eo'
	local url="http://glosbe.com/"
	local pesquisa

	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-d)
				case "$2" in
					pt|en|de|eo)
						de_ling=$2
						shift

						if test $de_ling == "eo"
						then
							para_ling="pt"
						fi
					;;

					*)
						printf "Lingua de origem não suportada\n"
						return 1
					;;
				esac
			;;

			-p)
				case "$2" in
					pt|en|de|eo)
						para_ling=$2
						shift
					;;

					*)
						printf "Lingua de destino não suportada\n"
						return 2
					;;
				esac
			;;

			*)
				printf "Parametro desconecido\n"
				return 3
			;;
		esac
		shift
	done

	pesquisa="$1"

	$ZZWWWHTML $url/$de_ling/$para_ling/$pesquisa |
		sed -n 's/.*class=" phr">\([^<]*\)<.*/\1/p'
}

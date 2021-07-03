# ----------------------------------------------------------------------------
# https://glosbe.com
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
# Versão: 6
# Requisitos: zzzz zztool zzuniq zzurlencode zzxml
# Tags: internet, dicionário
# ----------------------------------------------------------------------------
zzdicesperanto ()
{
	zzzz -h dicesperanto "$1" && return

	test -n "$1" || { zztool -e uso dicesperanto; return 1; }

	local de_ling='pt'
	local para_ling='eo'
	local url="https://glosbe.com"
	local pesquisa

	while test "${1#-}" != "$1"
	do
		case "$1" in
			-d)
				case "$2" in
					pt|en|de|eo)
						de_ling=$2
						shift

						if test 'eo' = $de_ling
						then
							para_ling="pt"
						fi
					;;

					*)
						zztool erro "Lingua de origem não suportada"
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
						zztool erro "Lingua de destino não suportada"
						return 2
					;;
				esac
			;;

			*)
				zztool erro "Parametro desconecido"
				return 3
			;;
		esac
		shift
	done

	pesquisa="$1"

	zztool source $(zzurlencode -n ':/' "$url/$de_ling/$para_ling/$pesquisa") |
		zzxml --tag h3 --untag |
		zzuniq
}

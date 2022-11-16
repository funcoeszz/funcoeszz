# ----------------------------------------------------------------------------
# Mostra a classificação de pilotos e construtores da F1.
#
# Opções:
#   -p: Mostra apenas a classificação por pilotos.
#   -c: Mostra apenas a classificação por construtores.
#   ano: Seleciona o ano da classificação.
#
# Sem as opções -p e -c mostra ambos.
# Sem escolher um ano espefífico, exibe o mais atual.
#
# Uso: zzf1 [-p|-c] [ano]
# Ex.: zzf1
#      zzf1 -p        # Mais recente classificação de pilotos.
#      zzf1 -c        # Mais recente classificação de construtores.
#      zzf1 2017      # Classificação de pilotos e construtores em 2017.
#      zzf1 -p 2015   # Classificação de pilotos em 2015.
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2020-12-26
# Versão: 1
# Requisitos: zzzz zztool zzpad zztrim zzxml
# Tags: internet, corrida, consulta
# ----------------------------------------------------------------------------
zzf1 ()
{
	zzzz -h f1 "$1" && return

	local pontos piloto nac1 construtor nac2 ano opt fopt

	while test -n "$1"
	do
		case $1 in
			-p) opt='driver'; shift ;;
			-c) opt='constructor'; shift ;;
			[0-9][0-9][0-9][0-9]) ano="$1"; shift ;;
			-*) zztool -e uso f1; return 1 ;;
			*) break ;;
		esac
	done

	ano="${ano:-current}"
	opt="${opt:-driver constructor}"

	for fopt in $opt
	do
		# Pilotos e/ou Construtores
		zztool source "https://ergast.com/api/f1/${ano}/${fopt}Standings" |
			zztrim |
			awk -v optw=$fopt '
				BEGIN {
					if (optw=="driver")
						print "Pts|Piloto||País|Construtor"
					else
						print "Pts|Construtor|País"
				}
				/(Driver|Constructor)Standing|Name|Nationality/ {
				if ($0 ~ /points/) {
					sub(/.*points="/,"")
					sub(/".*/,"")
					printf $0; next
				}
				if ($0 ~ /(Driver|Constructor)Standing>/) { print ""; next }
				printf "|" $0
			}' |
			zzxml --untag |
			case $fopt in
			driver)
				sed 's/|/ /2' |
				while IFS='|' read -r pontos piloto nac1 construtor nac2
				do
					echo "$(zzpad -e 5 $pontos)  $(zzpad 25 $piloto) $(zzpad 15 $construtor)  $nac1"
				done
			;;
			constructor)
				while IFS='|' read -r pontos construtor nac2
				do
					echo "$(zzpad -e 5 $pontos)  $(zzpad 15 $construtor)  $nac2"
				done
			;;
			esac
			echo
		done
}

# ----------------------------------------------------------------------------
# Busca informações sobre o filme desejado.
# Use a opção -t ou --traducao para ver a sinopse traduzida pelo Google
# Translate.
#
# Uso: zzfilme [-t|--traducao] FILME
# Ex.: zzfilme matrix
#      zzfilme 'matrix revolutions'
#      zzfilme -t 'lord of the rings'
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2018-04-16
# Versão: 1
# Licença: GPL
# Requisitos: zzxml zztrim zztradutor zzecho zzcapitalize zzurldecode zzurlencode
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzfilme ()
{
	zzzz -h filme "$1" && return

	test -n "$1" || { zztool -e uso filme; return 1; }

	local traducao=0
	local tab=$(printf '\t')
	local api='https://www.omdbapi.com/?apikey=2c30e4db&type=movie&r=xml&plot=full&t'

	while test -n "$1"
	do
		case "$1" in
			-t | --traducao)
				traducao=1
				shift
			;;
			*)
				local filme=$(zzurlencode $1)
				shift
			;;
		esac
	done

	local request=$(zztool source "${api}=${filme}" | zzxml --tag movie --indent | sed 's/\("\) /\1\n/g ; s/<movie // ; s/\/>// ; s/"//g' | zztrim)
	filme=$(zzurldecode $filme)

	if test -z "$request"
	then
		zztool erro "Não foi possível coletar informações do filme $(zzecho -l vermelho "$filme")."
		return 1
	else
		zztool eco $(zzcapitalize "$filme:")

		zzecho -n -N -l branco "${tab}Titulo Original: "; echo "$request" | awk -F= '/title/ {print $2}'
		zzecho -n -N -l branco "${tab}Lançamento: "; echo "$request" | awk -F= '/released/ {print $2}'
		zzecho -n -N -l branco "${tab}Duração: "; echo "$request" | awk -F= '/runtime/ {print $2}'
		zzecho -n -N -l branco "${tab}Gênero: "; echo "$request" | awk -F= '/genre/ {print $2}'
		zzecho -n -N -l branco "${tab}Diretor: "; echo "$request" | awk -F= '/director/ {print $2}'
		zzecho -n -N -l branco "${tab}Atores principais: "; echo "$request" | awk -F= '/actors/ {print $2}'
		zzecho -n -N -l branco "${tab}País: "; echo "$request" | awk -F= '/country/ {print $2}'
		zzecho -n -N -l branco "${tab}Nota: "; echo "$request" | awk -F= '/imdbRating/ {print $2}'
		zzecho -n -N -l branco "${tab}Sinopse: " ; echo "$request" | awk -F= '/plot/ {print $2}' |
		if test "$traducao" -eq 1
		then
			zztradutor en-pt | zztrim
		else
			cat -
		fi
	fi
}

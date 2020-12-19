# ----------------------------------------------------------------------------
# Busca informações sobre o filme desejado.
#
# Uso: zzfilme FILME
# Ex.: zzfilme matrix
#      zzfilme 'matrix revolutions'
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2018-04-16
# Versão: 1
# Licença: GPL
# Requisitos: zzxml zztrim zzecho zzcapitalize zzurldecode zzurlencode
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzfilme ()
{
	zzzz -h filme "$1" && return

	test -n "$1" || { zztool -e uso filme; return 1; }

	local traducao=0
	local tab=$(printf '\t')
	local api='https://www.omdbapi.com/?apikey=2c30e4db&type=movie&r=xml&plot=full&t'

	local filme=$(zzurlencode $*)

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
		zzecho -n -N -l branco "${tab}Sinopse: " ; echo "$request" | awk -F= '/plot/ {print $2}'
	fi
}

# ----------------------------------------------------------------------------
# Busca informações sobre o filme desejado.
# Use a opção -t ou --traducao para ver a sinopse traduzida pelo Google
# Translate.
#
# Uso:	zzfilme [-t|--traducao] FILME
# Ex.:	zzfilme matrix
#		zzfilme 'matrix revolutions'
#		zzfilme -t 'lord of the rings'
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2018-04-16
# Versão: 1
# Licença: GPL
# Requisitos: zzxml, zztrim, zztradutor, zzecho
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
				local traducao=1
				shift
			;;
			*)
				local filme="$1"
				shift
			;;
		esac
	done
	
	local request=$(zztool dump "https://www.omdbapi.com/?apikey=2c30e4db&type=movie&r=xml&plot=full&t=$filme" | zzxml --tag movie --indent | sed 's/\("\) /\1\n/g ; s/<movie // ; s/\/>// ; s/"//g' | zztrim)
	
	if test -z "$request"
	then
		echo "Não foi possível coletar informações do filme $(zzecho -l vermelho "$filme")."
		return 1
	else
		zztool eco $(zzcapitalize "$filme:")
		
		zzecho -n -N -l branco "${tab}Titulo Original: "; echo "$request" | grep 'title' | cut -d'=' -f2
		zzecho -n -N -l branco "${tab}Lançamento: "; echo "$request" | grep 'released' | cut -d'=' -f2
		zzecho -n -N -l branco "${tab}Duração: "; echo "$request" | grep 'runtime' | cut -d'=' -f2
		zzecho -n -N -l branco "${tab}Gênero: "; echo "$request" | grep 'genre' | cut -d'=' -f2
		zzecho -n -N -l branco "${tab}Diretor: "; echo "$request" | grep 'director' | cut -d'=' -f2
		zzecho -n -N -l branco "${tab}Atores principais: "; echo "$request" | grep 'actors' | cut -d'=' -f2
		zzecho -n -N -l branco "${tab}País: "; echo "$request" | grep 'country' | cut -d'=' -f2
		zzecho -n -N -l branco "${tab}Nota: "; echo "$request" | grep 'imdbRating' | cut -d'=' -f2
		if test "$traducao" -eq 1
		then
			zzecho -n -N -l branco "${tab}Sinopse: " ; echo "$request" | grep 'plot' | cut -d'=' -f2 | zztradutor en-pt | zztrim
		else
			zzecho -n -N -l branco "${tab}Sinopse:  "; echo "$request" | grep 'plot' | cut -d'=' -f2
		fi
	fi
}

# ----------------------------------------------------------------------------
# http://www.ucicinemas.com.br
# Exibe a programação dos cinemas UCI de sua cidade.
# Se não for passado nenhum parâmetro, são listadas as cidades e cinemas.
# Obs.: não utilize acentos: digite "Sao Paulo", e não "São Paulo"
# Uso: zzcineuci [cidade | codigo_cinema]
# Ex.: zzcineuci recife
#      zzcineuci 14
#
# Autor: Rodrigo Pereira da Cunha <rodrigopc (a) gmail.com>
# Desde: 2009-05-04
# Versão: 5
# Licença: GPL
# ----------------------------------------------------------------------------
zzcineuci ()
{
	zzzz -h cineuci "$1" && return

	[ $# -gt 1 ] && zztool uso cineuci && return 1

	if [ $# = 0 ]; then # mostra opções
		printf "Cidades e cinemas disponíveis\n=============================\n"
		printf "\nCuritiba:\n\t01) UCI Estação\n\t15) UCI Palladium\n"
		printf "\nFortaleza:\n\t10) Multiplex UCI Ribeiro Iguatemi Fortaleza\n"
		printf "\nJuiz de Fora:\n\t12) UCI Kinoplex Independência\n"
		printf "\nRecife:\n\t04) Multiplex UCI Ribeiro Recife\n\t05) Multiplex UCI Ribeiro Tacaruna\n\t14) UCI Kinoplex Shop Plaza Casa Forte Recife\n"
		printf "\nSantana:\n\t13) UCI Santana Parque Shopping\n"
		printf "\nSão Paulo:\n\t08) UCI Jardim Sul\n\t09) UCI Anália Franco\n"
		printf "\nRibeirão Preto:\n\t02) UCI Ribeirão\n"
		printf "\nRio de Janeiro:\n\t07) UCI New York City Center\n\t11) UCI Kinoplex NorteShopping\n"
		printf "\nSalvador:\n\t03) Multiplex Iguatemi Salvador\n\t06) UCI Aeroclube\n\t17) UCI Orient Paralela\n"
		return 0
	fi

	local url="http://www.ucicinemas.com.br/controles/listaFilmeCinemaHome.aspx?cinemaID="
	local cidade=`echo $* | sed 's/ /_/g' | tr [:upper:] [:lower:]` #converte nome da cidade para minúscula e retira espaços
	local codigo codigos

	if zztool testa_numero ${cidade}; then # passou código
		[ "$cidade" -ge 1 -a "$cidade" -le 17 ] && codigos="$cidade" # testa se código é válido
	else # passou nome da cidade
		case $cidade in
			curitiba) codigos="1 15" ;;
			fortaleza) codigos="10" ;;
			juiz_de_fora) codigos="12" ;;
			recife) codigos="4 5 14" ;;
			ribeirao_preto) codigos="2" ;;
			rio_de_janeiro)	codigos="7 11" ;;
			santana) codigos="13" ;;
			sao_paulo) codigos="8 9";;
			salvador) codigos="3 6 17";;
		esac
	fi

	[ -z "$codigos" ] && return 1 # se não recebeu cidade ou código válido, sai

	for codigo in $codigos
	do
		$ZZWWWDUMP "$url$codigo" | sed '

			# Faxina
			s/^  *//
			/^$/ d
			/^Horários para/ d

			# Destaque ao redor do nome do cinema, quebra linha após
			1 i\
=================================================
			1 a\
=================================================\


			# Quebra linha após o horário
			/^Sala / G
		'
	done
	return 0
}

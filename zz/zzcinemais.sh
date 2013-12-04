# ----------------------------------------------------------------------------
# http://www.cinemais.com.br
# Busca horários das sessões dos filmes no site do Cinemais.
# Cidades disponíveis:
#   Anapolis               -  32
#   Cuiaba                 -  10
#   Guaratingueta          -  21
#   Juiz de Fora           -  35
#   Milenium               -  29
#   Manaus Plaza           -  20
#   Marilia                -  17
#   Monte Carlos           -  34
#   Patos de Minas         -  11
#   Resende                -  33
#   Sao Jose do Rio Preto  -  30
#   Uberaba                -   9
#   Uberlandia             -   8
#
# Uso: zzcinemais [cidade]
# Ex.: zzcinemais milenium
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2008-08-25
# Versão: 6
# Licença: GPLv2
# Requisitos: zzecho zzsemacento
# ----------------------------------------------------------------------------
zzcinemais ()
{
	zzzz -h cinemais "$1" && return

	[ "$1" ] || { zztool uso cinemais; return 1; }

	local codigo cidade sessoes controle ih im linha hora minuto i

	cidade=$(zzsemacento $* | sed 's/ /_/g' | tr '[A-Z]' '[a-z]')

	case "$cidade" in
		anapolis)
			codigo=32
			zzecho -N -l ciano "Anápolis-GO:"
		;;
		cuiaba)
			codigo=10
			zzecho -N -l ciano "Cuiabá-MT:"
		;;
		guaratingueta)
			codigo=21
			zzecho -N -l ciano "Guaratinguetá-SP:"
		;;
		juiz_de_fora)
			codigo=35
			zzecho -N -l ciano "Juíz de Fora-MG:"
		;;
		milenium)
			codigo=29
			zzecho -N -l ciano "Milenium-AM:"
		;;
		manaus_plaza)
			codigo=20
			zzecho -N -l ciano "Manaus Plaza-AM:"
		;;
		marilia)
			codigo=17
			zzecho -N -l ciano "Marília-SP:"
		;;
		monte_carlos)
			codigo=34
			zzecho -N -l ciano "Monte Carlos-MG:"
		;;
		patos_de_minas)
			codigo=11
			zzecho -N -l ciano "Pato de Minas-MG:"
		;;
		resende)
			codigo=33
			zzecho -N -l ciano "Resende-MG:"
		;;
		sao_jose_do_rio_preto)
			codigo=30
			zzecho -N -l ciano "São José do Rio Preto-SP:"
		;;
		uberaba)
			codigo=9
			zzecho -N -l ciano "Uberaba-SP:"
		;;
		uberlandia)
			codigo=8
			zzecho -N -l ciano "Uberlândia-SP:"
		;;
		*)
			echo "Cidade não cadastrada. Use a opção -h para ver a lista de cidades."
			return 1
		;;
	esac

	sessoes=$(
			$ZZWWWHTML "http://www.cinemais.com.br/programacao/cinema.php?cc=$codigo" |
			zztool texto_em_iso |
			grep -A 2 'href="../filmes/f' |
			while read linha; do
				if echo $linha | grep Classifica > /dev/null; then
					echo $linha | sed 's/.*//g';
				else
					echo $linha | sed 's/<[^>]*>//g;s/^[ \t]*//g'
				fi
			done
		)

	hora=$(date +%Hh%M | cut -d'h' -f1)
	minuto=$(date +%Hh%M | cut -d'h' -f2)

	printf %b ' '

	for i in $sessoes; do
		if echo "$i" | grep 'Dub\|Leg' > /dev/null; then
			printf %b "\033[G\033[32C| $i"
		elif echo "$i" | grep '^-$' > /dev/null ; then
			printf %b "\033[G\033[39C| "
		elif echo "$i" | grep '[0-9][0-9][h][0-9][0-9]' > /dev/null ;then
			if echo $controle | grep '[a-z]$' > /dev/null; then
				printf %b "\033[G\033[32C|      | "
			fi
			ih=$(echo $i | cut -d'h' -f1)
			im=$(echo $i | cut -d'h' -f2 | sed 's/,//g;s/[A-K]//g' | tr -d '\015')

			if [ "$hora" -lt "$ih"  ];then
				zzecho -n -l verde -N "$i "
			elif [ "$hora" -eq "$ih" -a "$minuto" -lt "$im" ];then
				zzecho -n -l verde -N "$i "
			else
				zzecho -n -l vermelho -N "$i "
			fi
		elif echo "$i" | grep '\-\-' > /dev/null; then
			printf %b "\n "
		else
			printf %b " $i"
		fi
		controle=$i
	done

	echo
}

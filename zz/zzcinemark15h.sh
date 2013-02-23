# ----------------------------------------------------------------------------
# http://cinemark.com.br/programacao/cidade/1
# Exibe os filmes com sessão às 15h (mais barata) no Cinemark da sua cidade.
# Uso: zzcinemark15h [cidade | codigo_cinema]
# Ex.: zzcinemark15h sao paulo
#
# Autor: Thiago Moura Witt <thiago.witt (a) gmail.com> <@thiagowitt>
# Desde: 2011-07-05
# Versão: 2
# Licença: GPL
# Requisitos: zzminusculas zzsemacento
# ----------------------------------------------------------------------------
zzcinemark15h ()
{
	zzzz -h cinemark15h "$1" && return

	if [ $# = 0 ]; then # mostra opções
		printf "Cidades disponíveis\n=============================\n"
		printf "Aracaju\n"
		printf "Barueri\n"
		printf "Belo Horizonte\n"
		printf "Brasília\n"
		printf "Campinas\n"
		printf "Campo Grande\n"
		printf "Canoas\n"
		printf "Cotia\n"
		printf "Curitiba\n"
		printf "Florianópolis\n"
		printf "Goiânia\n"
		printf "Guarulhos\n"
		printf "Jacareí\n"
		printf "Manaus\n"
		printf "Natal\n"
		printf "Niterói\n"
		printf "Osasco\n"
		printf "Palmas\n"
		printf "Porto Alegre\n"
		printf "Ribeirão Preto\n"
		printf "Rio de Janeiro\n"
		printf "Salvador\n"
		printf "Santo André\n"
		printf "Santos\n"
		printf "São Bernardo do Campo\n"
		printf "São José dos Campos\n"
		printf "São José dos Pinhais\n"
		printf "São Paulo\n"
		printf "Taguatinga\n"
		printf "Vitória\n"
		return 0
	fi

	#converte nome da cidade para minúscula e retira espaços
	local cidade=$(echo $* | sed 's/ /_/g' | zzminusculas | zzsemacento)
	local codigo=""

	if zztool testa_numero ${cidade}; then # passou código
		if [ "$cidade" -ge 1 -a "$cidade" -le 31 ]; then
			codigo="$cidade" # testa se código é válido
		else
			echo "Código de cidade inválido"
			return 1
		fi
	else # passou nome da cidade
		case $cidade in
			aracaju) codigo=10;;
			barueri) codigo=4;;
			belo_horizonte) codigo=21;;
			brasilia) codigo=14;;
			campinas) codigo=16;;
			campo_grande) codigo=13;;
			canoas) codigo=12;;
			cotia) codigo=30;;
			curitiba) codigo=18;;
			florianopolis) codigo=24;;
			goiania) codigo=23;;
			guarulhos) codigo=27;;
			jacarei) codigo=19;;
			manaus) codigo=15;;
			natal) codigo=22;;
			niteroi) codigo=20;;
			osasco) codigo=29;;
			palmas) codigo=31;;
			porto_alegre) codigo=11;;
			ribeirao_preto) codigo=6;;
			rio_de_janeiro) codigo=9;;
			salvador) codigo=26;;
			santo_andre) codigo=2;;
			santos) codigo=8;;
			sao_bernardo_do_campo) codigo=3;;
			sao_jose_dos_campos) codigo=5;;
			sao_jose_dos_pinhais) codigo=28;;
			sao_paulo) codigo=1;;
			taguatinga) codigo=17;;
			vitoria) codigo=25;;
			*) echo "Cidade inválida" && return 1;;
		esac
	fi

	# URL com query para api YQL do Yahoo, que extrai os dados da pagina do
	# Cinemark e retorna so o que interessa
	local url=$(echo "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20html%20where%20url%3D%22http%3A%2F%2Fcinemark.com.br%2Fprogramacao%2Fcidade%2F<CIDADE>%22%20and%20xpath%3D'%2F%2Fh3%20%7C%20%2F%2Fdiv%5B%40class%3D%22filme%22%20and%20div%2Fp%2Fspan%3D%2215h00%22%5D%2Fdiv%2Fh4%2Fa'&diagnostics=true" | sed "s/<CIDADE>/$codigo/")

	# Os primeiros dois comandos (-e) do sed sao para remover todas as
	# quebras de linha. O ultimo comando remove a parte que nao interessa,
	# depois extrai e formata os resultados
	result=$($ZZWWWHTML $url | sed -e :a -e '$!N; s/\n/ /; ta' \
	-e '/<results\/>/d;s/<?.*<results>//;s/<.results>.*//;s/<h3>\([^<]*\)<.h3>/\
\1:\
/g;s/<a[^>]*>\([^<]*\)<.a>/	\1\
/g')

	[ -z "$result" ] && result="Nenhuma sessão com promoção na sua cidade."

	echo "$result"
	echo
}

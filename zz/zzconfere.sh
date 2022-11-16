# ----------------------------------------------------------------------------
# Confere os resultados de loterias.
# quina, megasena, duplasena, lotomania, lotofácil e timemania.
#
# Opções:
#   quina:                Confere o concurso da Quina.
#   megasena:             Confere o concurso da Megasena.
#   duplasena:            Confere o concurso da Duplasena.
#   lotomania:            Confere o concurso da Lotomania.
#   lotofacil:            Confere o concurso da Lotofácil.
#   timemania:            Confere o concurso da Timemania.
#   sorte:                Confere o concurso do Dia da Sorte.
#   -c <número>:          Consulta o concurso especificado em número.
#   --apostas <arquivo>:  Arquivo onde estão as apostas feitas.
#
# Se a opção -c não for usada, consulta o último concurso da loteria.
#
# Se não for definido o arquivo de apostas, assume-se um arquivo com mesmo
# nome da loteria com extensão ".txt" no diretório atual ou,
# as apostas vierem como argumentos adicionais
# com a quantidade mínima a cada loteria.
#
#  Obs.: No arquivo usado deve haver uma aposta por linha apenas.
#
# Uso: zzconfere  <loterias> [-c <número>] [--apostas <arquivo> | [num1] ... ]
# Ex.: zzconfere megasena -c 1270
#      zzconfere lotofácil --apostas /tmp/meus_palpites.txt
#      zzconfere lotomania -c 550 numeros.csv
#      zzconfere quina 07 12 15 28 33 45
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2018-11-25
# Versão: 2
# Requisitos: zzzz zztool zzhsort zzloteria
# Tags: internet, jogo, consulta
# ----------------------------------------------------------------------------
zzconfere ()
{
	zzzz -h confere "$1" && return

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso confere; return 1; }

	local tipo num arquivo palpite codregex min max

	# Identificando qual loteria a ser conferida
	case "$1" in
	quina | megasena | duplasena | lotomania | lotof[aá]cil | timemania | sorte ) tipo="$1";;
	*) zztool -e uso confere; return 1;;
	esac
	shift

	# Opções de linha de comando
	while test "${1#-}" != "$1"
	do
		case "$1" in
			-c       ) zztool -e testa_numero "$2" && num="$2"        || return 1 ;;
			--apostas) zztool -e arquivo_legivel "$2" && arquivo="$2" || return 1 ;;
			*        ) break;;
		esac
		shift; shift
	done

	# Quantidade de apostas por tipo de loteria
	case $tipo in
		quina)                min=5;  max=15 ;;
		megasena | duplasena) min=6;  max=15 ;;
		lotof[aá]cil)         min=6;  max=15 ;;
		timemania)            min=10; max=10 ;;
		lotomania)            min=50; max=50 ;;
		sorte)                min=7;  max=15 ;;
	esac

	# Definindo as apostas passadas por argumento
	if test $# -ge $min -a $# -le $max
	then
		echo "$*" | grep '^[0-9 ]*$' >/dev/null && palpite="$*"
		test -z "$palpite" && { zztool erro "Quantidade da apostas válidas para $tipo incorretas"; return 1; }
	fi

	# Definindo arquivo padrão por omissão se não houver argumentos
	if test -z "$arquivo" && test -z "$palpite"
	then
		zztool -e arquivo_legivel "${tipo}.txt" && arquivo="${tipo}.txt" || { zztool erro "Quantidade da apostas válidas para $tipo incorretas"; return 1; }
	fi

	# Expressão regular que identifica e quantifica os acertos no awk
	codregex=$(
		zzloteria $tipo $num |
		case "$tipo" in
			(quina | megasena | timemania | sorte)
				sed '3!d;s/^[[:blank:]]*/\\</;s/[[:blank:]]\{1,\}/\\>\|\\</g;s/$/\\> /'
			;;
			(duplasena)
				sed 's/^[[:blank:]]*/\\</;s/[[:blank:]]\{1,\}/\\>\|\\</g;s/$/\\> /' |
				if test -z "$num"
				then
					sed -n '5p;13p;'
				else
					sed -n '5p;8p;'
				fi
			;;
			(lotomania)
				sed 's/^[[:blank:]]*/\\</;s/[[:blank:]]\{1,\}/\\>\|\\</g;s/$/\\>/' |
				if test -z "$num"
				then
					sed -n '3p;5p;7p;9p;'
				else
					sed -n '3,6p'
				fi |
				tr '\n' '|'
			;;
			(lotof[aá]cil)
				sed 's/^[[:blank:]]*/\\</;s/[[:blank:]]\{1,\}/\\>\|\\</g;s/$/\\>/' |
				sed -n '3,5p' |
				tr '\n' '|'
			;;
		esac |
		sed 's/.$//'
	)

	if test -n "$palpite"
	then
		# Os números apostados são argumentos passados
		echo "$palpite"
	else
		# Quando os números apostados estão listado em um arquivo
		while read -r palpite
		do
			echo "$palpite" |
			sed 's/^[^0-9]*//;s/[^0-9]$//;s/[^0-9]\{1,\}/ /g'
		done < "$arquivo"
	fi |
	sed 's/\<\([0-9]\)\>/0\1/g' |
	zzhsort |
	if test "$tipo" = "duplasena"
	then
		# Tratamento diferente para duplasena, pois a mesma aposta vale para dois sorteios
		awk -v min_awk=$min -v max_awk=$max 'NF>=min_awk && NF<=max_awk {
			print "1º Sorteio -", gsub(/\<('"$(echo "${codregex}" | sed '2d')"')\>/,"[&]"), "acerto(s):", $0
			gsub(/[][]/,"")
			print "2º Sorteio -", gsub(/\<('"$(echo "${codregex}" | sed '1d')"')\>/,"[&]"), "acerto(s):", $0
			}' |
			sort -n |
			sed 's/\[\[/[/g;s/\]\]/]/g' |
			awk 'NR==1{a=$1}; a!=$1 {a=$1; print ""}; 1'
	else
		awk -v min_awk=$min -v max_awk=$max 'NF>=min_awk && NF<=max_awk { print gsub(/\<('"${codregex}"')\>/,"[&]"), "acerto(s):", $0 }'
	fi
}

# ----------------------------------------------------------------------------
# Uma coletânea de funções matemáticas simples.
# Se o primeiro argumento for um '-p' seguido de número sem espaço
# define a precisão dos resultados ( casas decimais ), o padrão é 6
# Em cada função foi colocado um pequeno help um pouco mais detalhado,
# pois ficou muito extenso colocar no help do zzmat apenas.
#
# Funções matemáticas disponíveis.
# Aritméticas:               | Trigonométricas:
#  mmc    mdc                |  sen   cos   tan
#  media  soma  produto      |  csc   sec   cot
#  log    ln    raiz         |  asen  acos  atan
#  somatoria    produtoria
#  pow, potencia ou elevado
#
# Combinatória:        | Sequências:          | Funções:
#  fat                 |  pa  pa2  pg  lucas  |  area  volume  r3
#  arranjo  arranjo_r  |  fibonacci  ou fib   |  det   vetor   d2p
#  combinacao          |  tribonacci ou trib
#  combinacao_r        |  mersenne  recaman  collatz
#
# Equações:                  | Auxiliares:
#  eq2g  egr    err          |  abs  int
#  egc   egc3p  ege          |  sem_zeros
#  newton ou binomio_newton  |  aleatorio  random
#  conf_eq                   |  compara_num
#
# Mais detalhes: zzmat função
#
# Uso: zzmat [-pnumero] funções [número] [número]
# Ex.: zzmat mmc 8 12
#      zzmat media 5[2] 7 4[3]
#      zzmat somatoria 3 9 2x+3
#      zzmat -p3 sen 60g
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2011-01-19
# Versão: 23
# Licença: GPL
# Requisitos: zzcalcula zzseq zzaleatorio zztrim zzconverte zztestar
# ----------------------------------------------------------------------------
zzmat ()
{
	zzzz -h mat "$1" && return

	local funcao num precisao
	local pi=3.1415926535897932384626433832795
	local LANG=en

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso mat; return 1; }

	# Definindo a precisão dos resultados qdo é pertinente. Padrão é 6.
	echo "$1" | grep '^-p' >/dev/null
	if test "$?" = "0"
	then
		precisao="${1#-p}"
		zztestar numero $precisao || precisao="6"
		shift
	else
		precisao="6"
	fi

	funcao="$1"

	# Atalhos para funções pow e fat, usando operadores unários
	if zztool grep_var '^' "$funcao" && zztestar numero_real "${funcao%^*}" && zztestar numero_real "${funcao#*^}"
	then
		zzmat -p${precisao} pow "${funcao%^*}" "${funcao#*^}"
		return
	elif zztool grep_var '!' "$funcao" && zztestar numero "${funcao%\!}"
	then
		zzmat -p${precisao} fat "${funcao%\!}" $2
		return
	fi

	case "$funcao" in
	sem_zeros)
		# Elimina o zeros nao significativos
		local num1
		shift
		num1=$(zztool multi_stdin "$@" | tr ',' '.')
		num1=$(echo "$num1" | sed 's/^[[:blank:].0]*$/zero/;s/^[[:blank:]0]*//;s/zero/0/')
		if test $precisao -gt 0
			then
			echo "$num1" | grep '\.' > /dev/null
			if test "$?" = "0"
			then
				num1=$(echo "$num1" | sed 's/[0[:blank:]]*$//' | sed 's/\.$//')
			fi
		fi
		num1=$(echo "$num1" | sed 's/^\./0\./')
		echo "$num1"
	;;
	compara_num)
		if test $# -eq "3" && zztestar numero_real $2 && zztestar numero_real $3
		then
			local num1 num2
			num1=$(echo "$2" | tr ',' '.')
			num2=$(echo "$3" | tr ',' '.')
			echo "$num1 $num2" |
			awk '
				$1 > $2  { print "maior" }
				$1 == $2 { print "igual" }
				$1 < $2  { print "menor" }
			'
		else
			zztool erro " zzmat $funcao: Compara 2 numeros"
			zztool erro " Retorna o texto 'maior', 'menor' ou 'igual'"
			zztool erro " Uso: zzmat $funcao numero numero"
			return 1
		fi
	;;
	int)
		local num1
		if test "$2" = "-h"
		then
			zztool erro " zzmat $funcao: Valor Inteiro"
			zztool erro " Uso: zzmat $funcao numero"
			zztool erro "      echo numero | zzmat $funcao"
			return
		fi
		shift
		num1=$(zztool multi_stdin "$@" | tr ',' '.')
		if zztestar numero_real $num1
		then
			echo $num1 | sed 's/\..*$//'
		fi
	;;
	abs)
		local num1
		if test "$2" = "-h"
		then
			zztool erro " zzmat $funcao: Valor Absoluto"
			zztool erro " Uso: zzmat $funcao numero"
			zztool erro "      echo numero | zzmat $funcao"
			return
		fi
		shift
		num1=$(zztool multi_stdin "$@" | tr ',' '.')
		if zztestar numero_real $num1
		then
			echo "$num1" | sed 's/^[-+]//'
		fi
	;;
	sen | cos | tan | csc | sec | cot)
		if test $# -eq "2"
		then
			local num1 num2 ang
			num1=$(echo "$2" | sed 's/g$//; s/gr$//; s/rad$//' | tr , .)
			ang=$(echo "$2" | tr -d -c '[grad]')
			echo "$2" | grep -E '(g|rad|gr)$' >/dev/null
			if test "$?" -eq "0" && zztestar numero_real $num1
			then
				case $ang in
				g)   num2=$(zzconverte -p$((precisao+2)) gr $num1);;
				gr)  num2=$(zzconverte -p$((precisao+2)) ar $num1);;
				rad) num2=$num1;;
				esac

				case $funcao in
				sen) num1="scale=${precisao};s(${num2})" ;;
				cos) num1="scale=${precisao};c(${num2})" ;;
				tan)
					num1="scale=${precisao};if (c(${num2})) {s(${num2})/c(${num2})}" ;;
				sec)
					num1="scale=${precisao};if (c(${num2})) {1/c(${num2})}" ;;
				csc)
					num1="scale=${precisao};if (s(${num2})) {1/s(${num2})}" ;;
				cot)
					num1="scale=${precisao};if (s(${num2})) {c(${num2})/s(${num2})}" ;;
				esac

				test -n "$num1" && num="$num1"
			else
				echo " Uso: zzmat $funcao número(g|rad|gr) {graus|radianos|grado}"
			fi
		else
			zztool erro " zzmat Função Trigonométrica:
	sen: Seno
	cos: Cosseno
	tan: Tangente
	sec: Secante
	csc: Cossecante
	cot: Cotangente"
			zztool erro " Uso: zzmat $funcao número(g|rad|gr) {graus|radianos|grado}"
			return 1
		fi
	;;
	asen | acos | atan)
		if test $# -ge "2" && test $# -le "4" && zztestar numero_real $2
		then
			local num1 num2 num3 sinal
			num1=$(echo "$2" | tr ',' '.')
			test "$funcao" != "atan" && num2=$(awk 'BEGIN {if ('$num1'>1 || '$num1'<-1) print "erro"}')
			if test "$num2" = "erro"
			then
				zzmat $funcao -h >&2;return 1
			fi

			echo "$num1" | grep '^-' >/dev/null && sinal="-" || unset sinal
			num1=$(zzmat abs $num1)

			case $funcao in
			atan)
				num2=$(echo "a(${num1})" | bc -l)
				test -n "$sinal" && num2=$(echo "($pi)-($num2)" | bc -l)
				echo "$4" | grep '2' >/dev/null && num2=$(echo "($num2)+($pi)" | bc -l)
			;;
			asen)
				num3=$(echo "sqrt(1-${num1}^2)" | bc -l | awk '{printf "%.'${precisao}'f\n", $1}')
				if test "$num3" = $(printf '%.'${precisao}'f' 0 | tr ',' '.')
				then
					num2=$(echo "$pi/2" | bc -l)
				else
					num2=$(echo "a(${num1}/sqrt(1-${num1}^2))" | bc -l)
				fi
				echo "$4" | grep '2' >/dev/null && num2=$(echo "($pi)-($num2)" | bc -l)
				test -n "$sinal" && num2=$(echo "($pi)+($num2)" | bc -l)
			;;
			acos)
				num3=$(echo "$num1" | bc -l | awk '{printf "%.'${precisao}'f\n", $1}')
				if test "$num3" = $(printf '%.'${precisao}'f' 0 | tr ',' '.')
				then
					num2=$(echo "$pi/2" | bc -l)
				else
					num2=$(echo "a(sqrt(1-${num1}^2)/${num1})" | bc -l)
				fi
				test -n "$sinal" && num2=$(echo "($pi)-($num2)" | bc -l)
				echo "$4" | grep '2' >/dev/null && num2=$(echo "2*($pi)-($num2)" | bc -l)
			;;
			esac

			echo "$4" | grep 'r' >/dev/null && num2=$(echo "($num2)-2*($pi)" | bc -l)

			case $3 in
			g)        num=$(zzconverte -p$((precisao+2)) rg $num2);;
			gr)       num=$(zzconverte -p$((precisao+2)) ra $num2);;
			rad | "") num="$num2";;
			esac
		else
			zztool erro " zzmat Função Trigonométrica:
	asen: Arco-Seno
	acos: Arco-Cosseno
	atan: Arco-Tangente"
			zztool erro " Retorna o angulo em radianos, graus ou grado."
			zztool erro " Se não for definido retorna em radianos."
			zztool erro " Valores devem estar entre -1 e 1, para arco-seno e arco-cosseno."
			zztool erro " Caso a opção seja '2' retorna o segundo ângulo possível do valor."
			zztool erro " E se for 'r' retorna o ângulo no sentido invertido (replementar)."
			zztool erro " As duas opções poder ser combinadas: r2 ou 2r."
			zztool erro " Uso: zzmat $funcao número [[g|rad|gr] [opção]]"
			return 1
		fi
	;;
	log | ln)
		if test $# -ge "2" && test $# -le "3" && zztestar numero_real $2
		then
			local num1 num2
			num1=$(echo "$2" | tr ',' '.')
			zztestar numero_real "$3" && num2=$(echo "$3" | tr ',' '.')
			if test -n "$num2"
			then
				num="l($num1)/l($num2)"
			elif test "$funcao" = "log"
			then
				num="l($num1)/l(10)"
			else
				num="l($num1)"
			fi
		else
			zztool erro " Se não definir a base no terceiro argumento:"
			zztool erro " zzmat log: Logaritmo base 10"
			zztool erro " zzmat ln: Logaritmo Natural base e"
			zztool erro " Uso: zzmat $funcao numero [base]"
			return 1
		fi
	;;
	raiz)
		if test $# -eq "3" && zztestar numero_real "$3"
		then
			local num1 num2
			case "$2" in
			quadrada)  num1=2;;
			c[úu]bica) num1=3;;
			*)         num1="$2";;
			esac
			num2=$(echo "$3" | tr ',' '.')
			if test $(($num1 % 2)) -eq 0
			then
				if echo "$num2" | grep '^-' > /dev/null
				then
					zztool erro " Não há solução nos números reais para radicando negativo e índice par."
					return 1
				fi
			fi
			if zztestar numero_real $num1
			then
				num=$(awk 'BEGIN {printf "%.'${precisao}'f\n", '$num2'^(1/'$num1')}')
			else
				echo " Uso: zzmat $funcao <quadrada|cubica|numero> numero"
			fi
		else
			zztool erro " zzmat $funcao: Raiz enesima de um número"
			zztool erro " Uso: zzmat $funcao <quadrada|cubica|numero> numero"
			return 1
		fi
	;;
	potencia | elevado | pow)
		if test $# -eq "3" && zztestar numero_real "$2" && zztestar numero_real "$3"
		then
			local num1 num2
			num1=$(echo "$2" | tr ',' '.')
			num2=$(echo "$3" | tr ',' '.')
			if zztestar numero $num2
			then
				num=$(echo "scale=${precisao};${num1}^${num2}" | bc -l | awk '{ printf "%.'${precisao}'f\n", $1 }')
			else
				num=$(awk 'BEGIN {printf "%.'${precisao}'f\n", ('$num1')^('$num2')}')
			fi
		else
			zztool erro " zzmat $funcao: Um número elevado a um potência"
			zztool erro " Uso: zzmat $funcao número potência"
			zztool erro " Uso: zzmat número^potência"
			zztool erro " Ex.: zzmat $funcao 4 3"
			zztool erro " Ex.: zzmat 3^7"
			return 1
		fi
	;;
	area)
		if test $# -ge "2"
		then
			local num1 num2 num3
			case "$2" in
			triangulo)
				if zztestar numero_real $3 && zztestar numero_real $4
				then
					num1=$(echo "$3" | tr ',' '.')
					num2=$(echo "$4" | tr ',' '.')
					num="${num1}*${num2}/2"
				else
					zztool erro " Uso: zzmat $funcao $2 base altura";return 1
				fi
			;;
			retangulo | losango)
				if zztestar numero_real $3 && zztestar numero_real $4
				then
					num1=$(echo "$3" | tr ',' '.')
					num2=$(echo "$4" | tr ',' '.')
					num="${num1}*${num2}"
				else
					printf " Uso: zzmat %s %s " $funcao $2 >&2
					test "$2" = "retangulo" && echo "base altura" >&2 || echo "diagonal_maior diagonal_menor" >&2
					return 1
				fi
			;;
			trapezio)
				if zztestar numero_real $3 && zztestar numero_real $4 && zztestar numero_real $5
				then
					num1=$(echo "$3" | tr ',' '.')
					num2=$(echo "$4" | tr ',' '.')
					num3=$(echo "$5" | tr ',' '.')
					num="((${num1}+${num2})/2)*${num3}"
				else
					zztool erro " Uso: zzmat $funcao $2 base_maior base_menor altura";return 1
				fi
			;;
			toro)
				if zztestar numero_real $3 && zztestar numero_real $4 && test $(zzmat compara_num $3 $4) != "igual"
				then
					num1=$(echo "$3" | tr ',' '.')
					num2=$(echo "$4" | tr ',' '.')
					num="4*${pi}^2*${num1}*${num2}"
				else
					zztool erro " Uso: zzmat $funcao $2 raio1 raio2";return 1
				fi
			;;
			tetraedro | cubo | octaedro | dodecaedro | icosaedro | quadrado | circulo | esfera | cuboctaedro | rombicuboctaedro | rombicosidodecaedro | icosidodecaedro)
				if test -n "$3"
				then
					if zztestar numero_real $3
					then
						num1=$(echo "$3" | tr ',' '.')
						case $2 in
						tetraedro)           num="sqrt(3)*${num1}^2";;
						cubo)                num="6*${num1}^2";;
						octaedro)            num="sqrt(3)*2*${num1}^2";;
						dodecaedro)          num="sqrt(25+10*sqrt(5))*3*${num1}^2";;
						icosaedro)           num="sqrt(3)*5*${num1}^2";;
						quadrado)            num="${num1}^2";;
						circulo)             num="$pi*(${num1})^2";;
						esfera)              num="4*$pi*(${num1})^2";;
						cuboctaedro)         num="(6+2*sqrt(3))*${num1}^2";;
						rombicuboctaedro)    num="2*(9+sqrt(3))*${num1}^2";;
						icosidodecaedro)     num="(5*sqrt(3)+3*sqrt(5)*sqrt(5+2*sqrt(5)))*${num1}^2";;
						rombicosidodecaedro) num="(30+sqrt(30*(10+3*sqrt(5)+sqrt(15*(2+2*sqrt(5))))))*${num1}^2";;
						esac
					elif test $3 = "truncado" && zztestar numero_real $4
					then
						num1=$(echo "$4" | tr ',' '.')
						case $2 in
						tetraedro)       num="7*sqrt(3)*${num1}^2";;
						cubo)            num="2*${num1}^2*(6+6*sqrt(2)+6*sqrt(3))";;
						octaedro)        num="(6+sqrt(3)*12)*${num1}^2";;
						dodecaedro)      num="(sqrt(3)+6*sqrt(5+2*sqrt(5)))*5*${num1}^2";;
						icosaedro)       num="3*(10*sqrt(3)+sqrt(5)*sqrt(5+2*sqrt(5)))*${num1}^2";;
						cuboctaedro)     num="12*(2+sqrt(2)+sqrt(3))*${num1}^2";;
						icosidodecaedro) num="30*(1+sqrt(2*sqrt(4+sqrt(5)+sqrt(15+6*sqrt(6)))))*${num1}^2";;
						esac
					elif test $3 = "snub" && zztestar numero_real $4
					then
						num1=$(echo "$4" | tr ',' '.')
						case $2 in
						cubo)       num="${num1}^2*(6+8*sqrt(3))";;
						dodecaedro) num="55.286744956*${num1}^2";;
						esac
					else
						zztool erro " Uso: zzmat $funcao $2 lado|raio";return 1
					fi
				else
					zztool erro " Uso: zzmat $funcao $2 lado|raio";return 1
				fi
			;;
			esac
		else
			zztool erro " zzmat $funcao: Cálculo da área de figuras planas e superfícies"
			zztool erro " Uso: zzmat area <triangulo|quadrado|retangulo|losango|trapezio|circulo> numero"
			zztool erro " Uso: zzmat area <esfera|rombicuboctaedro|rombicosidodecaedro> numero"
			zztool erro " Uso: zzmat area <tetraedo|cubo|octaedro|dodecaedro|icosaedro|cuboctaedro|icosidodecaedro> [truncado] numero"
			zztool erro " Uso: zzmat area <cubo|dodecaedro> snub numero"
			zztool erro " Uso: zzmat area toro numero numero"
			return 1
		fi
	;;
	volume)
		if test $# -ge "2"
		then
			local num1 num2 num3
			case "$2" in
			paralelepipedo)
				if zztestar numero_real $3 && zztestar numero_real $4 && zztestar numero_real $5
				then
					num1=$(echo "$3" | tr ',' '.')
					num2=$(echo "$4" | tr ',' '.')
					num3=$(echo "$5" | tr ',' '.')
					num="${num1}*${num2}*${num3}"
				else
					zztool erro " Uso: zzmat $funcao $2 comprimento largura altura";return 1
				fi
			;;
			cilindro)
				if zztestar numero_real $3 && zztestar numero_real $4
				then
					num1=$(echo "$3" | tr ',' '.')
					num2=$(echo "$4" | tr ',' '.')
					num="($pi*(${num1})^2)*${num2}"
				else
					zztool erro " Uso: zzmat $funcao $2 raio altura";return 1
				fi
			;;
			cone)
				if zztestar numero_real $3 && zztestar numero_real $4
				then
					num1=$(echo "$3" | tr ',' '.')
					num2=$(echo "$4" | tr ',' '.')
					num="($pi*(${num1})^2)*${num2}/3"
				else
					zztool erro " Uso: zzmat $funcao $2 raio altura";return 1
				fi
			;;
			prisma)
				if zztestar numero_real $3 && zztestar numero_real $4
				then
					num1=$(echo "$3" | tr ',' '.')
					num2=$(echo "$4" | tr ',' '.')
					num="${num1}*${num2}"
				else
					zztool erro " Uso: zzmat $funcao $2 area_base altura";return 1
				fi
			;;
			piramide)
				if zztestar numero_real $3 && zztestar numero_real $4
				then
					num1=$(echo "$3" | tr ',' '.')
					num2=$(echo "$4" | tr ',' '.')
					num="${num1}*${num2}/3"
				else
					zztool erro " Uso: zzmat $funcao $2 area_base altura";return 1
				fi
			;;
			toro)
				local num_maior num_menor
				if zztestar numero_real $3 && zztestar numero_real $4 && test $(zzmat compara_num $3 $4) != "igual"
				then
					num1=$(echo "$3" | tr ',' '.')
					num2=$(echo "$4" | tr ',' '.')
					test $num1 -gt $num2 && num_maior=$num1 || num_maior=$num2
					test $num1 -lt $num2 && num_menor=$num1 || num_menor=$num2
					num="2*${pi}^2*${num_menor}^2*${num_maior}"
				else
					zztool erro " Uso: zzmat $funcao $2 raio1 raio2";return 1
				fi
			;;
			tetraedro | cubo | octaedro | dodecaedro | icosaedro | esfera | cuboctaedro | rombicuboctaedro | rombicosidodecaedro | icosidodecaedro)
				if test -n "$3"
				then
					if zztestar numero_real $3
					then
						num1=$(echo "$3" | tr ',' '.')
						case $2 in
						tetraedro)           num="sqrt(2)/12*${num1}^3";;
						cubo)                num="${num1}^3";;
						octaedro)            num="sqrt(2)/3*${num1}^3";;
						dodecaedro)          num="(15+7*sqrt(5))*${num1}^3/4";;
						icosaedro)           num="(3+sqrt(5))*${num1}^3*5/12";;
						esfera)              num="$pi*(${num1})^3*4/3";;
						cuboctaedro)         num="5/3*sqrt(2)*${num1}^3";;
						rombicuboctaedro)    num="(2*(6+5*sqrt(2))*${num1}^3)/3";;
						icosidodecaedro)     num="((45+17*sqrt(5))*${num1}^3)/6";;
						rombicosidodecaedro) num="(60+29*sqrt(5))/3*${num1}^3";;
						esac
					elif test $3 = "truncado" && zztestar numero_real $4
					then
						num1=$(echo "$4" | tr ',' '.')
						case $2 in
						tetraedro)       num="23*sqrt(2)/12*${num1}^3";;
						cubo)            num="(7*${num1}^3*(3+2*sqrt(2)))/3";;
						octaedro)        num="8*sqrt(2)*${num1}^3";;
						dodecaedro)      num="5*(99+47*sqrt(5))/12*${num1}^3";;
						icosaedro)       num="(125+43*sqrt(5))*${num1}^3*1/4";;
						cuboctaedro)     num="(22+14*sqrt(2))*${num1}^3";;
						icosidodecaedro) num="(90+50*sqrt(5))*${num1}^3";;
						esac
					elif test $3 = "snub" && zztestar numero_real $4
					then
						num1=$(echo "$4" | tr ',' '.')
						case $2 in
						cubo)       num="7.8894774*${num1}^3";;
						dodecaedro) num="37.61664996*${num1}^3";;
						esac
					else
						zztool erro " Uso: zzmat $funcao $2 lado|raio";return 1
					fi
				else
					zztool erro " Uso: zzmat $funcao $2 lado|raio";return 1
				fi
			;;
			esac
		else
			zztool erro " zzmat $funcao: Cálculo de volume de figuras geométricas"
			zztool erro " Uso: zzmat volume <paralelepipedo|cilindro|esfera|cone|prisma|piramide|rombicuboctaedro|rombicosidodecaedro> numero"
			zztool erro " Uso: zzmat volume <tetraedo|cubo|octaedro|dodecaedro|icosaedro|cuboctaedro|icosidodecaedro> [truncado] numero"
			zztool erro " Uso: zzmat volume <cubo|dodecaedro> snub numero"
			zztool erro " Uso: zzmat volume toro numero numero"
			return 1
		fi
	;;
	mmc | mdc)
		if test $# -ge "3"
		then
			local num_maior num_menor resto mdc mmc num2
			local num1=$2
			shift
			shift
			for num2 in $*
			do
				if zztestar numero $num1 && zztestar numero $num2
				then
					test "$num1" -gt "$num2" && num_maior=$num1 || num_maior=$num2
					test "$num1" -lt "$num2" && num_menor=$num1 || num_menor=$num2

					while test "$num_menor" -ne "0"
					do
						resto=$((${num_maior}%${num_menor}))
						num_maior=$num_menor
						num_menor=$resto
					done

					mdc=$num_maior
					mmc=$((${num1}*${num2}/${mdc}))
				fi
				shift
				test "$funcao" = "mdc" && num1="$mdc" || num1="$mmc"
			done

			case $funcao in
			mmc) echo "$mmc";;
			mdc) echo "$mdc";;
			esac
		else
			zztool erro " zzmat mmc: Menor Múltiplo Comum"
			zztool erro " zzmat mdc: Maior Divisor Comum"
			zztool erro " Uso: zzmat $funcao numero numero ..."
			return 1
		fi
	;;
	somatoria | produtoria)
		#colocar x como a variavel a ser substituida
		if test $# -eq "4"
		then
			zzmat $funcao $2 $3 1 $4
		elif test $# -eq "5" && zztestar numero_real $2 && zztestar numero_real $3 && zztestar numero_real $4 && zztool grep_var "x" $5
		then
			local equacao numero operacao sequencia num1 num2
			equacao=$(echo "$5" | sed 's/\[/(/g;s/\]/)/g')
			test "$funcao" = "somatoria" && operacao='+' || operacao='*'
			if test $(zzmat compara_num $2 $3) = 'maior'
			then
				num1=$2; num2=$3
			else
				num1=$3; num2=$2
			fi
			sequencia=$(zzmat pa $num2 $4 $(zzcalcula "(($num1 - $num2)/$4)+1" | zzmat int) | tr ' ' '\n')
			num=$(for numero in $sequencia
			do
				echo "($equacao)" | sed "s/^[x]/($numero)/;s/\([(+-]\)x/\1($numero)/g;s/\([0-9]\)x/\1\*($numero)/g;s/x/$numero/g"
			done | paste -s -d"$operacao" -)
		else
			zztool erro " zzmat $funcao: Soma ou Produto de expressão"
			zztool erro " Uso: zzmat $funcao limite_inferior limite_superior equacao"
			zztool erro " Uso: zzmat $funcao limite_inferior limite_superior razao equacao"
			zztool erro " Usar 'x' como variável na equação"
			zztool erro " Usar '[' e ']' respectivamente no lugar de '(' e ')', ou proteger"
			zztool erro " a fórmula com aspas duplas(\") ou simples(')"
			return 1
		fi
	;;
	media | soma | produto)
		if test $# -ge "2"
		then
			local soma=0
			local qtde=0
			local produto=1
			local peso=1
			local valor
			shift
			while test $# -ne "0"
			do
				if zztool grep_var "[" "$1" && zztool grep_var "]" "$1"
				then
					valor=$(echo "$1" | sed 's/\([0-9]\{1,\}\)\[.*/\1/' | tr ',' '.')
					peso=$(echo "$1" | sed 's/.*\[//;s/\]//')
					if zztestar numero_real "$valor" && zztestar numero "$peso"
					then
						if test $funcao = 'produto'
						then
							produto=$(echo "$produto*(${valor}^${peso})" | bc -l)
						else
							soma=$(echo "$soma+($valor*$peso)" | bc -l)
							qtde=$(($qtde+$peso))
						fi
					fi
				elif zztestar numero_real "$1"
				then
					if test $funcao = 'produto'
					then
						produto=$(echo "($produto) * ($1)" | tr ',' '.' | bc -l)
					else
						soma=$(echo "($soma) + ($1)" | tr ',' '.' | bc -l)
						qtde=$(($qtde+1))
					fi
				else
					zztool -e uso mat; return 1;
				fi
				shift
			done

			case "$funcao" in
			media)   num="${soma}/${qtde}";;
			soma)    num="${soma}";;
			produto) num="${produto}";;
			esac
		else
			zztool erro " zzmat $funcao:Soma, Produto ou Média Aritimética e Ponderada"
			zztool erro " Uso: zzmat $funcao numero[[peso]] [numero[peso]] ..."
			zztool erro " Usar o peso entre '[' e ']', justaposto ao número."
			return 1
		fi
	;;
	fat)
		if test $# -eq "2" -o $# -eq "3" && zztestar numero "$2" && test "$2" -ge "1"
		then
			local num1 num2
			if test "$3" = "s"
			then
				num1=$(zzseq $2)
			else
				num1="$2"
			fi
			for num2 in $(echo "$num1")
			do
				echo "define fat(x) { if (x <= 1) return (1); return (fat(x-1) * x); }; fat($num2)" |
				bc |
				tr -d '\\\n' |
				zztool nl_eof
			done |
			tr '\n' ' ' |
			zztrim |
			zztool nl_eof
		else
			zztool erro " zzmat $funcao: Resultado do produto de 1 ao numero atual (fatorial)"
			zztool erro " Com o argumento 's' imprime a sequência até a posição."
			zztool erro " Uso: zzmat $funcao numero [s]"
			zztool erro " Uso: zzmat numero! [s]"
			zztool erro " Ex.: zzmat $funcao 4"
			zztool erro "      zzmat 5!"
			return 1
		fi
	;;
	arranjo | combinacao | arranjo_r | combinacao_r)
		if test $# -eq "3" && zztestar numero "$2" && zztestar numero "$3" && test "$2" -ge "$3" && test "$3" -ge "1"
		then
			local n p dnp
			n=$(zzmat fat $2)
			p=$(zzmat fat $3)
			dnp=$(zzmat fat $(($2-$3)))
			case "$funcao" in
			arranjo)    test "$2" -gt "$3" && num="${n}/${dnp}" || return 1;;
			arranjo_r)  zzmat elevado "$2" "$3";;
			combinacao) test "$2" -gt "$3" && num="${n}/(${p}*${dnp})" || return 1;;
			combinacao_r)
				if test "$2" -gt "$3"
				then
					n=$(zzmat fat $(($2+$3-1)))
					dnp=$(zzmat fat $(($2-1)))
					num="${n}/(${p}*${dnp})"
				else
					return 1
				fi
			;;
			esac
		else
			zztool erro " zzmat arranjo: n elementos tomados em grupos de p (considera ordem)"
			zztool erro " zzmat arranjo_r: n elementos tomados em grupos de p com repetição (considera ordem)"
			zztool erro " zzmat combinacao: n elementos tomados em grupos de p (desconsidera ordem)"
			zztool erro " zzmat combinacao_r: n elementos tomados em grupos de p com repetição (desconsidera ordem)"
			zztool erro " Uso: zzmat $funcao total_numero quantidade_grupo"
			return 1
		fi
	;;
	newton | binomio_newton)
		if test "$#" -ge "2"
		then
			local num1 num2 grau sinal parcela coeficiente
			num1="a"
			num2="b"
			sinal="+"
			zztestar numero "$2" && grau="$2"
			if test -n "$3"
			then
				if test "$3" = "+" -o "$3" = "-"
				then
					sinal="$3"
					test -n "$4" && num1="$4"
					test -n "$5" && num2="$5"
				else
					test -n "$3" && num1="$3"
					test -n "$4" && num2="$4"
				fi
			fi
			echo "($num1)^$grau"
			for parcela in $(zzseq $((grau-1)))
			do
				coeficiente=$(zzmat combinacao $grau $parcela)
				test "$sinal" = "-" -a $((parcela%2)) -eq 1 && printf "%s" "- " || printf "%s" "+ "
				printf "%s * " "$coeficiente"
				echo "($num1)^$(($grau-$parcela)) * ($num2)^$parcela" | sed 's/\^1\([^0-9]\)/\1/g;s/\^1$//'
			done
			test "$sinal" = "-" -a $((grau%2)) -eq 1 && printf "%s" "- " || printf "%s" "+ "
			echo "($num2)^$grau"
		else
			echo " zzmat $funcao: Exibe o desdobramento do binônimo de Newton."
			echo " Exemplo no grau 3: (a + b)^3 = a^3 + 2a^2b + 2ab^2 + b^3"
			echo " Se nenhum sinal for especificado será assumido '+'"
			echo " Se não declarar variáveis serão assumidos 'a' e 'b'"
			echo " Uso: zzmat $funcao grau [+|-] [variavel(a) [variavel(b)]]"
		fi
	;;
	pa | pa2 | pg)
		if test $# -eq "4" && zztestar numero_real "$2" && zztestar numero_real "$3" && zztestar numero "$4"
		then
			local num_inicial razao passo valor
			num_inicial=$(echo "$2" | tr ',' '.')
			razao=$(echo "$3" | tr ',' '.')
			passo=0
			valor=$num_inicial
			while (test $passo -lt $4)
			do
				if test "$funcao" = "pa"
				then
					valor=$(echo "$num_inicial + ($razao * $passo)" | bc -l |
					awk '{printf "%.'${precisao}'f\n", $1}')
				elif test "$funcao" = "pa2"
				then
					valor=$(echo "$valor + ($razao * $passo)" | bc -l |
					awk '{printf "%.'${precisao}'f\n", $1}')
				else
					valor=$(echo "$num_inicial * $razao^$passo" | bc -l |
					awk '{printf "%.'${precisao}'f\n", $1}')
				fi
				valor=$(echo "$valor" | zzmat -p${precisao} sem_zeros)
				test $passo -lt $(($4 - 1)) && printf "%s " "$valor" || printf "%s" "$valor"
				passo=$(($passo+1))
			done
			echo
		else
			zztool erro " zzmat pa:  Progressão Aritmética"
			zztool erro " zzmat pa2: Progressão Aritmética de Segunda Ordem"
			zztool erro " zzmat pg:  Progressão Geométrica"
			zztool erro " Uso: zzmat $funcao inicial razao quantidade_elementos"
			return 1
		fi
	;;
	fibonacci | fib | lucas)
	# Sequência ou número de fibonacci
		if zztestar numero "$2"
		then
			awk 'BEGIN {
					seq = ( "'$3'" == "s" ? 1 : 0 )
					num1 = ( "'$funcao'" == "lucas" ? 2 : 0 )
					num2 = 1
					for ( i = 0; i < '$2' + seq; i++ ) {
						if ( seq == 1 ) { printf "%s ", num1 }
						num3 = num1 + num2
						num1 = num2
						num2 = num3
					}
					if ( seq != 1 ) { printf "%s ", num1 }
				}' |
				zztrim -r |
				zztool nl_eof
		else
			echo " Número de Fibonacci ou Lucas na posição especificada."
			echo " Com o argumento 's' imprime a sequência até a posição."
			echo " Uso: zzmat $funcao <número> [s]"
		fi
	;;
	tribonacci | trib)
	# Sequência ou número Tribonacci
		if zztestar numero "$2"
		then
			awk 'BEGIN {
					seq = ( "'$3'" == "s" ? 1 : 0 )
					num1 = 0
					num2 = 0
					num3 = 1
					for ( i = 0; i < '$2' + seq; i++ ) {
						if ( seq == 1 ) { printf "%s ", num1 }
						num4 = num1 + num2 + num3
						num1 = num2
						num2 = num3
						num3 = num4
					}
					if ( seq != 1 ) { printf "%s ", num1 }
				}' |
				zztrim -r |
				zztool nl_eof
		else
			echo " Número de Tribonacci na posição especificada."
			echo " Com o argumento 's' imprime a sequência até a posição."
			echo " Uso: zzmat $funcao <número> [s]"
		fi
	;;
	recaman)
	# Sequência ou número Recamán
		if zztestar numero "$2"
		then
			awk 'BEGIN {
					seq = ( "'$3'" == "s" ? 1 : 0 )
					a[0]=0; b[0]=0
					for ( i = 1; i <= '$2'; i++ ) {
						num=a[i-1]
						a[i] = ((num > i && ! ((num - i) in b)) ? num - i : num + i)
						b[a[i]]=i
					}
					if ( seq ) { for (i=0; i<length(a); i++) printf "%d ", a[i] }
					else { print a[length(a)-1] }
				}' |
				zztrim -r |
				zztool nl_eof
		else
			echo " Número de Recamán na posição especificada."
			echo " Com o argumento 's' imprime a sequência até a posição."
			echo " Uso: zzmat $funcao <número> [s]"
		fi
	;;
	mersenne)
	# Sequência ou número de Mersenne
		if zztestar numero "$2"
		then
			zzseq -f '2^%d-1\n' 0 $2 |
			bc |
			awk '{ if ($0 ~ /\\$/) { sub(/\\/,""); printf $0 } else { print } }' |
			if test "s" = "$3"
			then
				zztool lines2list | zztool nl_eof
			else
				sed -n '$p'
			fi
		else
				echo " Número de Mersenne na posição especificada."
				echo " Com o argumento 's' imprime a sequência até a posição."
				echo " Uso: zzmat $funcao <número> [s]"
		fi
	;;
	collatz)
	# Sequência de Collatz
	if zztestar numero "$2"
	then
		awk '
				function collatz(num) {
					printf num " "
					if (num>1) {
						if (num%2==0) { collatz(num/2) }
						else { collatz(3*num+1) }
					}
				}
				BEGIN { collatz('$2')}
			' |
			zztrim |
			zztool nl_eof
	else
		echo " Sequência de Collatz"
		echo " Uso: zzmat $funcao <número>"
	fi
	;;
	r3)
		shift
		if test -n "$1"
		then
			local num num1 num2 ind
			local num3=0
			local num4=0
			while test -n "$1"
			do
				num="$1"
				ind=1
				zztool grep_var "i" "$1" && ind=0 && num=$(echo "$1" | sed 's/i//')
				if (zztestar numero_real ${num%/*} || test ${num%/*} = 'x') && (zztestar numero_real ${num#*/} || test ${num#*/} = 'x')
				then
					num3=$((num3+1))
					if test $((num3%2)) -eq $ind
					then
						test ${num%/*} != 'x' && num1="$num1 ${num%/*}" || num4=$((num4+1))
						test ${num#*/} != 'x' && num2="$num2 ${num#*/}" || num4=$((num4+1))
					else
						test ${num%/*} != 'x' && num2="$num2 ${num%/*}" || num4=$((num4+1))
						test ${num#*/} != 'x' && num1="$num1 ${num#*/}" || num4=$((num4+1))
					fi
				fi
				shift
			done

			unset num
			if test $num4 -eq 1 && test -n "$num1" && test -n "$num2"
			then
				case $(zzmat compara_num $(echo "$num1" | awk '{print NF}') $(echo "$num2" | awk '{print NF}')) in
				maior)
					num=$(echo $(zzmat produto $num1)"/"$(zzmat produto $num2))
				;;
				menor)
					num=$(echo $(zzmat produto $num2)"/"$(zzmat produto $num1))
				;;
				*)
					zzmat $funcao
				;;
				esac
			else
				zzmat $funcao
			fi
		else
			echo " Calcula o valor de 'x', usando a regra de 3 simples ou composta."
			echo " Se alguma das frações tiver a letra i justaposta, é considerada inversamente proporcional."
			echo " Obs.: o i pode ser antes ou depois, mas não pode haver espaço em relação a fração."
			echo "       no local do valor a ser encontrado, digite apenas 'x', e somente uma vez."
			echo " Uso: zzmat $funcao <fração1>[i] <fração2>[i] [<fração3>[i] ...]"
		fi
	;;
	eq2g)
	#Equação do Segundo Grau: Raizes e Vértice
		if test $# = "4" && zztestar numero_real $2 && zztestar numero_real $3 && zztestar numero_real $4
		then
			local delta num_raiz vert_x vert_y raiz1 raiz2
			delta=$(echo "$2 $3 $4" | tr ',' '.' | awk '{valor=$2^2-(4*$1*$3); print valor}')
			num_raiz=$(awk 'BEGIN { if ('$delta' > 0)  {print "2"}
									if ('$delta' == 0) {print "1"}
									if ('$delta' < 0)  {print "0"}}')

			vert_x=$(echo "$2 $3" | tr ',' '.' |
			awk '{valor=((-1 * $2)/(2 * $1)); printf "%.'${precisao}'f\n", valor}' |
			zzmat -p${precisao} sem_zeros )

			vert_y=$(echo "$2 $delta" | tr ',' '.' |
			awk '{valor=((-1 * $2)/(4 * $1)); printf "%.'${precisao}'f\n", valor}' |
			zzmat -p${precisao} sem_zeros )

			case $num_raiz in
			0) raiz1="Sem raiz";;
			1) raiz1=$vert_x;;
			2)
				raiz1=$(echo "$2 $3 $delta" | tr ',' '.' |
				awk '{valor=((-1 * $2)-sqrt($3))/(2 * $1); printf "%.'${precisao}'f\n", valor}' |
				zzmat -p${precisao} sem_zeros )

				raiz2=$(echo "$2 $3 $delta" | tr ',' '.' |
				awk '{valor=((-1 * $2)+sqrt($3))/(2 * $1); printf "%.'${precisao}'f\n", valor}' |
				zzmat -p${precisao} sem_zeros )
			;;
			esac
			test "$num_raiz" = "2" && printf "%b\n" "X1: ${raiz1}\nX2: ${raiz2}" || echo "X: $raiz1"
			echo "Vertice: (${vert_x}, ${vert_y})"
		else
			zztool erro " zzmat $funcao: Equação do Segundo Grau (Raízes e Vértice)"
			zztool erro " Uso: zzmat $funcao A B C"
			return 1
		fi
	;;
	d2p)
		if test $# = "3" && zztool grep_var "," "$2" && zztool grep_var "," "$3"
		then
			local x1 y1 z1 x2 y2 z2 a b
			x1=$(echo "$2" | cut -f1 -d,)
			y1=$(echo "$2" | cut -f2 -d,)
			z1=$(echo "$2" | cut -f3 -d,)
			x2=$(echo "$3" | cut -f1 -d,)
			y2=$(echo "$3" | cut -f2 -d,)
			z2=$(echo "$3" | cut -f3 -d,)
			if zztestar numero_real $x1 && zztestar numero_real $y1 && zztestar numero_real $x2 && zztestar numero_real $y2
			then
				a=$(echo "(($y1)-($y2))^2" | bc -l)
				b=$(echo "(($x1)-($x2))^2" | bc -l)
				if zztestar numero_real $z1 && zztestar numero_real $z2
				then
					num="sqrt((($z1)-($z2))^2+$a+$b)"
				else
					num="sqrt($a+$b)"
				fi
			else
				zztool erro " Uso: zzmat $funcao ponto(a,b) ponto(x,y)";return 1
			fi
		else
			zztool erro " zzmat $funcao: Distância entre 2 pontos"
			zztool erro " Uso: zzmat $funcao ponto(a,b) ponto(x,y)"
			return 1
		fi
	;;
	vetor)
		if test $# -ge "3"
		then
			local valor ang teta fi oper tipo num1 saida
			local x1=0
			local y1=0
			local z1=0
			shift

			test "$1" = "-e" -o "$1" = "-c" && tipo="$1" || tipo="-e"
			oper="+"
			saida=$(echo "$*" | awk '{print $NF}')

			while (test $# -ge "1")
			do
				valor=$(echo "$1" | cut -f1 -d,)
				zztool grep_var "," $1 && teta=$(echo "$1" | cut -f2 -d,)
				zztool grep_var "," $1 && fi=$(echo "$1" | cut -f3 -d,)

				if test -n "$fi" && zztestar numero_real $valor
				then
					num1=$(echo "$fi" | sed 's/g$//; s/gr$//; s/rad$//')
					ang=$(echo "$fi" | tr -d -c '[grad]')
					echo "$fi" | grep -E '(g|rad|gr)$' >/dev/null
					if test "$?" -eq "0" && zztestar numero_real $num1
					then
						case $ang in
						g)   fi=$(zzconverte -p$((precisao+2)) gr $num1);;
						gr)  fi=$(zzconverte -p$((precisao+2)) ar $num1);;
						rad) fi=$num1;;
						esac
						z1=$(echo "$z1 $oper $(zzmat cos ${fi}rad) * $valor" | bc -l)
					elif zztestar numero_real $num1
					then
						z1="$num1"
					fi
				fi

				if test -n "$teta" && zztestar numero_real $valor
				then
					num1=$(echo "$teta" | sed 's/g$//; s/gr$//; s/rad$//')
					ang=$(echo "$teta" | tr -d -c '[grad]')
					echo "$teta" | grep -E '(g|rad|gr)$' >/dev/null
					if test "$?" -eq "0" && zztestar numero_real $num1
					then
						case $ang in
						g)   teta=$(zzconverte -p$((precisao+2)) gr $num1);;
						gr)  teta=$(zzconverte -p$((precisao+2)) ar $num1);;
						rad) teta=$num1;;
						esac
					else
						unset teta
					fi
				fi

				if zztestar numero_real $valor
				then
					test -n "$fi" && num1=$(echo "$(zzmat sen ${fi}rad)*$valor" | bc -l) ||
						num1=$valor
					test -n "$teta" && x1=$(echo "$x1 $oper $(zzmat cos ${teta}rad) * $num1" | bc -l) ||
						x1=$(echo "($x1) $oper ($num1)" | bc -l)
					test -n "$teta" && y1=$(echo "$y1 $oper $(zzmat sen ${teta}rad) * $num1" | bc -l)
				fi
				shift
			done

			valor=$(echo "sqrt(${x1}^2+${y1}^2+${z1}^2)" | bc -l)
			teta=$(zzmat asen $(echo "${y1}/sqrt(${x1}^2+${y1}^2)" | bc -l))
			fi=$(zzmat acos $(echo "${z1}/${valor}" | bc -l))

			case $saida in
			g)
				teta=$(zzconverte -p$((precisao+2)) rg $teta)
				fi=$(zzconverte -p$((precisao+2)) rg $fi)
			;;
			gr)
				teta=$(zzconverte -p$((precisao+2)) ra $teta)
				fi=$(zzconverte -p$((precisao+2)) ra $fi)
			;;
			*) saida="rad";;
			esac

			teta=$(awk 'BEGIN {printf "%.'${precisao}'f\n", '$teta'}' | zzmat -p${precisao} sem_zeros )
			fi=$(awk 'BEGIN {printf "%.'${precisao}'f\n", '$fi'}' | zzmat -p${precisao} sem_zeros )

			if test "$tipo" = "-c"
			then
				valor=$(echo "sqrt(${valor}^2-$z1^2)" | bc -l |
					awk '{printf "%.'${precisao}'f\n", $1}' | zzmat -p${precisao} sem_zeros )
				echo "${valor}, ${teta}${saida}, ${z1}"
			else
				valor=$(echo "$valor" | bc -l |
					awk '{printf "%.'${precisao}'f\n", $1}' | zzmat -p${precisao} sem_zeros )
				echo "${valor}, ${teta}${saida}, ${fi}${saida}"
			fi
		else
			zztool erro " zzmat $funcao: Operação entre vetores"
			zztool erro " Tipo de saída podem ser: padrão (-e)"
			zztool erro "  -e: vetor em coordenadas esférica: valor[,teta(g|rad|gr),fi(g|rad|gr)];"
			zztool erro "  -c: vetor em coordenada cilindrica: raio[,teta(g|rad|gr),altura]."
			zztool erro " Os angulos teta e fi tem sufixos g(graus), rad(radianos) ou gr(grados)."
			zztool erro " Os argumentos de entrada seguem o mesmo padrão do tipo de saída."
			zztool erro " E os tipos podem ser misturados em cada argumento."
			zztool erro " Unidade angular é o angulo de saida usado para o vetor resultante,"
			zztool erro " e pode ser escolhida entre g(graus), rad(radianos) ou gr(grados)."
			zztool erro " Não use separador de milhar. Use o ponto(.) como separador decimal."
			zztool erro " Uso: zzmat $funcao [tipo saida] vetor [vetor2] ... [unidade angular]"
			return 1
		fi
	;;
	egr | err)
	#Equação Geral da Reta
	#ax + by + c = 0
	#y1 – y2 = a
	#x2 – x1 = b
	#x1y2 – x2y1 = c
		if test $# = "3" && zztool grep_var "," "$2" && zztool grep_var "," "$3"
		then
			local x1 y1 x2 y2 a b c redutor m
			x1=$(echo "$2" | cut -f1 -d,)
			y1=$(echo "$2" | cut -f2 -d,)
			x2=$(echo "$3" | cut -f1 -d,)
			y2=$(echo "$3" | cut -f2 -d,)
			if zztestar numero_real $x1 && zztestar numero_real $y1 && zztestar numero_real $x2 && zztestar numero_real $y2
			then
				a=$(awk 'BEGIN {valor=('$y1')-('$y2'); printf "%.'${precisao}'f\n", valor}' | zzmat -p${precisao} sem_zeros)
				b=$(awk 'BEGIN {valor=('$x2')-('$x1');  printf "%+.'${precisao}'f\n", valor}' | zzmat -p${precisao} sem_zeros)
				c=$(zzmat det $x1 $y1 $x2 $y2 | awk '{printf "%+.'${precisao}'f\n", $1}' | zzmat -p${precisao} sem_zeros)
				m=$(awk 'BEGIN {valor=(('$y2'-'$y1')/('$x2'-'$x1')); printf "%.'${precisao}'f\n", valor}' | zzmat -p${precisao} sem_zeros)
				if zztestar numero_sinal $a && zztestar numero_sinal $b && zztestar numero_sinal $c
				then
					redutor=$(zzmat mdc $(zzmat abs $a) $(zzmat abs $b) $(zzmat abs $c))
					a=$(awk 'BEGIN {valor=('$a')/('$redutor'); print valor}')
					b=$(awk 'BEGIN {valor=('$b')/('$redutor');  print (valor<0?"":"+") valor}')
					c=$(awk 'BEGIN {valor=('$c')/('$redutor');  print (valor<0?"":"+") valor}')
				fi

				case "$funcao" in
				egr)
					echo "${a}x${b}y${c}=0" |
					sed 's/\([+-]\)1\([xy]\)/\1\2/g;s/[+]\{0,1\}0[xy]//g;s/+0=0/=0/;s/^+//';;
				err)
					redutor=$(awk 'BEGIN {printf "%+.'${precisao}'f\n", -('$m'*'$x1')+'$y1'}' | zzmat -p${precisao} sem_zeros)
					echo "y=${m}x${redutor}";;
				esac
			else
				zztool erro " Uso: zzmat $funcao ponto(a,b) ponto(x,y)";return 1
			fi
		else
			printf " zzmat %s: " $funcao
			case "$funcao" in
			egr) echo "Equação Geral da Reta.";;
			err) echo "Equação Reduzida da Reta.";;
			esac
			zztool erro " Uso: zzmat $funcao ponto(a,b) ponto(x,y)"
			return 1
		fi
	;;
	egc)
	#Equação Geral da Circunferência: Centro e Raio ou Centro e Ponto
	#x2 + y2 - 2ax - 2by + a2 + b2 - r2 = 0
	#A=-2ax | B=-2by | C=a2+b2-r2
	#r=raio | a=coordenada x do centro | b=coordenada y do centro
		if test $# = "3" && zztool grep_var "," "$2"
		then
			local a b r A B C
			if zztool grep_var "," "$3"
			then
				r=$(zzmat d2p $2 $3)
			elif zztestar numero_real "$3"
			then
				r=$(echo "$3" | tr ',' '.')
			else
				zztool erro " Uso: zzmat $funcao centro(a,b) (numero|ponto(x,y))";return 1
			fi
			a=$(echo "$2" | cut -f1 -d,)
			b=$(echo "$2" | cut -f2 -d,)
			A=$(awk 'BEGIN {valor=-2*('$a'); print (valor<0?"":"+") valor}')
			B=$(awk 'BEGIN {valor=-2*('$b'); print (valor<0?"":"+") valor}')
			C=$(awk 'BEGIN {valor=('$a')^2+('$b')^2-('$r')^2; print (valor<0?"":"+") valor}')
			echo "x^2+y^2${A}x${B}y${C}=0" | sed 's/\([+-]\)1\([xy]\)/\1\2/g;s/[+]0[xy]//g;s/+0=0/=0/'
		else
			zztool erro " zzmat $funcao: Equação Geral da Circunferência (Centro e Raio ou Centro e Ponto)"
			zztool erro " Uso: zzmat $funcao centro(a,b) (numero|ponto(x,y))"
			return 1
		fi
	;;
	egc3p)
	#Equação Geral da Circunferência: 3 Pontos
		if test $# = "4" && zztool grep_var "," "$2" &&	zztool grep_var "," "$3" && zztool grep_var "," "$4"
		then
			local x1 y1 x2 y2 x3 y3 A B C D
			x1=$(echo "$2" | cut -f1 -d,)
			y1=$(echo "$2" | cut -f2 -d,)
			x2=$(echo "$3" | cut -f1 -d,)
			y2=$(echo "$3" | cut -f2 -d,)
			x3=$(echo "$4" | cut -f1 -d,)
			y3=$(echo "$4" | cut -f2 -d,)

			if test $(zzmat det $x1 $y1 1 $x2 $y2 1 $x3 $y3 1) -eq 0
			then
				zztool erro "Pontos formam uma reta."
				return 1
			fi

			if ! zztestar numero_real $x1 || ! zztestar numero_real $x2 || ! zztestar numero_real $x3
			then
				zztool erro " Uso: zzmat $funcao ponto(a,b) ponto(c,d) ponto(x,y)";return 1
			fi

			if ! zztestar numero_real $y1 || ! zztestar numero_real $y2 || ! zztestar numero_real $y3
			then
				zztool erro " Uso: zzmat $funcao ponto(a,b) ponto(c,d) ponto(x,y)";return 1
			fi

			D=$(zzmat det $x1 $y1 1 $x2 $y2 1 $x3 $y3 1)
			A=$(zzmat det -$(echo "$x1^2+$y1^2" | bc) $y1 1 -$(echo "$x2^2+$y2^2" | bc) $y2 1 -$(echo "$x3^2+$y3^2" | bc) $y3 1)
			B=$(zzmat det $x1 -$(echo "$x1^2+$y1^2" | bc) 1 $x2 -$(echo "$x2^2+$y2^2" | bc) 1 $x3 -$(echo "$x3^2+$y3^2" | bc) 1)
			C=$(zzmat det $x1 $y1 -$(echo "$x1^2+$y1^2" | bc) $x2 $y2 -$(echo "$x2^2+$y2^2" | bc) $x3 $y3 -$(echo "$x3^2+$y3^2" | bc))

			A=$(awk 'BEGIN {valor='$A'/'$D';print (valor<0?"":"+") valor}')
			B=$(awk 'BEGIN {valor='$B'/'$D';print (valor<0?"":"+") valor}')
			C=$(awk 'BEGIN {valor='$C'/'$D';print (valor<0?"":"+") valor}')

			x1=$(awk 'BEGIN {valor='$A'/2*-1;print valor}')
			y1=$(awk 'BEGIN {valor='$B'/2*-1;print valor}')

			echo "x^2+y^2${A}x${B}y${C}=0" |
			sed 's/\([+-]\)1\([xy]\)/\1\2/g;s/[+]0[xy]//g;s/+0=0/=0/'
			echo "Centro: (${x1}, ${y1})"
		else
			zztool erro " zzmat $funcao: Equação Geral da Circunferência (3 pontos)"
			zztool erro " Uso: zzmat $funcao ponto(a,b) ponto(c,d) ponto(x,y)"
			return 1
		fi
	;;
	ege)
	#Equação Geral da Esfera: Centro e Raio ou Centro e Ponto
	#x2 + y2 + z2 - 2ax - 2by -2cz + a2 + b2 + c2 - r2 = 0
	#A=-2ax | B=-2by | C=-2cz | D=a2+b2+c2-r2
	#r=raio | a=coordenada x do centro | b=coordenada y do centro | c=coordenada z do centro
		if test $# = "3" && zztool grep_var "," "$2"
		then
			local a b c r A B C D
			if zztool grep_var "," "$3"
			then
				r=$(zzmat d2p $2 $3)
			elif zztestar numero_real "$3"
			then
				r=$(echo "$3" | tr ',' '.')
			else
				zztool erro " Uso: zzmat $funcao centro(a,b,c) (numero|ponto(x,y,z))";return 1
			fi
			a=$(echo "$2" | cut -f1 -d,)
			b=$(echo "$2" | cut -f2 -d,)
			c=$(echo "$2" | cut -f3 -d,)

			if ! zztestar numero_real $a || ! zztestar numero_real $b || ! zztestar numero_real $c
			then
				zztool erro " Uso: zzmat $funcao centro(a,b,c) (numero|ponto(x,y,z))";return 1
			fi
			A=$(awk 'BEGIN {valor=-2*('$a'); print (valor<0?"":"+") valor}')
			B=$(awk 'BEGIN {valor=-2*('$b'); print (valor<0?"":"+") valor}')
			C=$(awk 'BEGIN {valor=-2*('$c'); print (valor<0?"":"+") valor}')
			D=$(awk 'BEGIN {valor='$a'^2+'$b'^2+'$c'^2-'$r'^2;print (valor<0?"":"+") valor}')
			echo "x^2+y^2+z^2${A}x${B}y${C}z${D}=0" |
			sed 's/\([+-]\)1\([xyz]\)/\1\2/g;s/[+]0[xyz]//g;s/+0=0/=0/'
		else
			zztool erro " zzmat $funcao: Equação Geral da Esfera (Centro e Raio ou Centro e Ponto)"
			zztool erro " Uso: zzmat $funcao centro(a,b,c) (numero|ponto(x,y,z))"
			return 1
		fi
	;;
	aleatorio | random)
		#Gera um numero aleatorio (randomico)
		local min=0
		local max=1
		local qtde=1
		local n_temp

		if test "$2" = "-h"
		then
			echo " zzmat $funcao: Gera um número aleatório."
			echo " Sem argumentos gera números entre 0 e 1."
			echo " Com 1 argumento numérico este fica como limite superior."
			echo " Com 2 argumentos numéricos estabelecem os limites inferior e superior, respectivamente."
			echo " Com 3 argumentos numéricos, o último é a quantidade de número aleatórios gerados."
			echo " Usa padrão de 6 casas decimais. Use -p0 logo após zzmat para números inteiros."
			echo " Uso: zzmat $funcao [[minimo] maximo] [quantidade]"
			return
		fi

		if zztestar numero_real $3
		then
			max=$(echo "$3" | tr ',' '.')
			if zztestar numero_real $2;then min=$(echo "$2" | tr ',' '.');fi
		elif zztestar numero_real $2
		then
			max=$(echo "$2" | tr ',' '.')
		fi

		if test $(zzmat compara_num $max $min) = "menor"
		then
			n_temp=$max
			max=$min
			min=$n_temp
			unset n_temp
		fi

		if test -n "$4" && zztestar numero $4;then qtde=$4;fi

		case "$funcao" in
		aleatorio)
			awk 'BEGIN {srand();for(i=1;i<='$qtde';i++) { printf "%.'${precisao}'f\n", sprintf("%.'${precisao}'f\n",'$min'+rand()*('$max'-'$min'))}}' |
			zzmat -p${precisao} sem_zeros
			sleep 1
		;;
		random)
			n_temp=1
			while test $n_temp -le $qtde
			do
				zzaleatorio | awk '{ printf "%.'${precisao}'f\n", sprintf("%.'${precisao}'f\n",'$min'+($1/32767)*('$max'-'$min'))}' |
				zzmat -p${precisao} sem_zeros
				n_temp=$((n_temp + 1))
			done
		;;
		esac
	;;
	det)
		# Determinante de matriz (2x2 ou 3x3)
		if test $# -ge "5" && test $# -le "10"
		then
			local num
			shift
			for num in $*
			do
				if ! zztestar numero_real "$num"
				then
					zztool erro " Uso: zzmat $funcao numero1 numero2 numero3 numero4 [numero5 numero6 numero7 numero8 numero9]"
					return 1
				fi
			done
			case $# in
			4) num=$(echo "($1*$4)-($2*$3)" | tr ',' '.');;
			9) num=$(echo "(($1*$5*$9)+($7*$2*$6)+($4*$8*$3)-($7*$5*$3)-($4*$2*$9)-($1*$8*$6))" | tr ',' '.');;
			*)   zztool erro " Uso: zzmat $funcao numero1 numero2 numero3 numero4 [numero5 numero6 numero7 numero8 numero9]"; return 1;;
			esac
		else
			echo " zzmat $funcao: Calcula o valor da determinante de uma matriz 2x2 ou 3x3."
			echo " Uso: zzmat $funcao numero1 numero2 numero3 numero4 [numero5 numero6 numero7 numero8 numero9]"
			echo " Ex:  zzmat det 1 3 2 4"
		fi
	;;
	conf_eq)
		# Confere equação
		if test $# -ge "2"
		then
			equacao=$(echo "$2" | sed 's/\[/(/g;s/\]/)/g')
			local x y z eq
			shift
			shift
			while (test $# -ge "1")
			do
				x=$(echo "$1" | cut -f1 -d,)
				zztool grep_var "," $1 && y=$(echo "$1" | cut -f2 -d,)
				zztool grep_var "," $1 && z=$(echo "$1" | cut -f3 -d,)
				eq=$(echo $equacao | sed "s/^[x]/$x/;s/\([(+-]\)x/\1($x)/g;s/\([0-9]\)x/\1\*($x)/g;s/x/$x/g" |
					sed "s/^[y]/$y/;s/\([(+-]\)y/\1($y)/g;s/\([0-9]\)y/\1\*($y)/g;s/y/$y/g" |
					sed "s/^[z]/$z/;s/\([(+-]\)z/\1($z)/g;s/\([0-9]\)z/\1\*($z)/g;s/z/$z/g")
				echo "$eq" | bc -l
				unset x y z eq
				shift
			done
		else
			zztool erro " zzmat $funcao: Confere ou resolve equação."
			zztool erro " As variáveis a serem consideradas são x, y ou z nas fórmulas."
			zztool erro " As variáveis são justapostas em cada argumento separados por vírgula."
			zztool erro " Cada argumento adicional é um novo conjunto de variáveis na fórmula."
			zztool erro " Usar '[' e ']' respectivamente no lugar de '(' e ')', ou proteger"
			zztool erro " a fórmula com aspas duplas(\") ou simples(')"
			zztool erro " Potenciação é representado com o uso de '^', ex: 3^2."
			zztool erro " Não use separador de milhar. Use o ponto(.) como separador decimal."
			zztool erro " Uso: zzmat $funcao equacao numero|ponto(x,y[,z])"
			zztool erro " Ex:  zzmat conf_eq x^2+3*[y-1]-2z+5 7,6.8,9 3,2,5.1"
			return 1
		fi
	;;
	*)
	zzmat -h
	;;
	esac

	if test "$?" -ne "0"
	then
		return 1
	elif test -n "$num"
	then
		echo "$num" | bc -l | awk '{printf "%.'${precisao}'f\n", $1}' | zzmat -p${precisao} sem_zeros
	fi
}

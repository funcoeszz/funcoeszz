# ----------------------------------------------------------------------------
# Faz várias conversões como: caracteres, temperatura e distância.
#  Opções:
#   -e: Resposta expandida, mais explicativa.
#      Obs: sem essa opção a resposta é curta, apenas o número convertivo.
#
#  Códigos:
#          cf = (C)elsius             para (F)ahrenheit
#          fc = (F)ahrenheit          para (C)elsius
#          ck = (C)elsius             para (K)elvin
#          kc = (K)elvin              para (C)elsius
#          fk = (F)ahrenheit          para (K)elvin
#          kf = (K)elvin              para (F)ahrenheit
#          km = (K)Quilômetros        para (M)ilhas
#          mk = (M)ilhas              para (K)Quilômetros
#          db = (D)ecimal             para (B)inário
#          bd = (B)inário             para (D)ecimal
#          cd = (C)aractere           para (D)ecimal
#          dc = (D)ecimal             para (C)aractere
#          do = (D)ecimal             para (O)ctal
#          od = (O)ctal               para (D)ecimal
#          ho = (H)exadecimal         para (O)ctal
#          oh = (O)ctal               para (H)exadecimal
#          hc = (H)exadecimal         para (C)aractere
#          ch = (C)aractere           para (H)exadecimal
#          dh = (D)ecimal             para (H)exadecimal
#          hd = (H)exadecimal         para (D)ecimal
#          gr = (G)raus               para (R)adianos
#          rg = (R)adianos            para (G)raus
#          ar = Gr(A)dos              para (R)adianos
#          ra = (R)adianos            para Gr(A)dos
#          ag = Gr(A)dos              para (G)raus
#          ga = (G)raus               para Gr(A)dos
#
# Uso: zzconverte [-e] <código(s)> número [numero ...]
# Ex.: zzconverte cf 5
#      zzconverte dc 65
#      zzconverte db 32 47 28
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2003-10-02
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
zzconverte ()
{
	zzzz -h converte "$1" && return

	local opt

	if test "$1" = "-e"
	then
		opt="e"
		shift
	fi

	local s2='scale=2'
	local operacao=$1
	local resp suf1 suf2 bc_expr

	# Verificação dos parâmetros
	test -n "$2" || { zztool -e uso converte; return 1; }

	shift
	while test -n "$1"
	do
		case "$operacao" in
			cf)
				suf1="°C"; suf2="°F"; bc_expr="$s2;($1*9/5)+32"
			;;
			fc)
				suf1="°F"; suf2="°C"; bc_expr="$s2;($1-32)*5/9"
			;;
			ck)
				suf1="°C"; suf2="K"; bc_expr="$s2;$1+273.15"
			;;
			kc)
				suf1="K"; suf2="°C"; bc_expr="$s2;$1-273.15"
			;;
			kf)
				suf1="K"; suf2="°F"; bc_expr="$s2;($1*1.8)-459.67"
			;;
			fk)
				suf1="°F"; suf2="K"; bc_expr="$s2;($1+459.67)/1.8"
			;;
			km)
				suf1="km"; suf2="mi"; bc_expr="$s2;$1*0.6214"
				# resultado com 4 casas porque bc usa o mesmo do 0.6214
			;;
			mk)
				suf1="mi"; suf2="km"; bc_expr="$s2;$1*1.609"
				# resultado com 3 casas porque bc usa o mesmo do 1.609
			;;
			db)
				suf1="em decimal"; suf2="em binário"; bc_expr="obase=2;$1"
			;;
			bd)
				suf1="em binário"; suf2="em decimal"; bc_expr="ibase=2;$1"
				#echo "$((2#$1))"
			;;
			do)
				suf1="em decimal"; suf2="em octal"; bc_expr="obase=8;$1"
			;;
			od)
				suf1="em octal"; suf2="em decimal"; bc_expr="ibase=8;$1"
			;;
			ho)
				suf1="em hexadecimal"; suf2="em octal"; bc_expr="obase=8;ibase=16;$1"
			;;
			oh)
				suf1="em octal"; suf2="em hexadecimal"; bc_expr="obase=16;ibase=8;$1"
			;;
			cd)
				suf1="em caractere"; suf2="em decimal"
				resp=$(printf "%d\n" "'$1")
			;;
			dc)
				suf1="em decimal"; suf2="em caractere"
				if zztool testa_numero "$1" && test "$1" -gt 0
				then
					# echo -e $(printf "\\\x%x" $1)
					resp=$(awk 'BEGIN {printf "%c\n", '$1'}')
				fi
			;;
			ch)
				suf1="em caractere"; suf2="em hexadecimal"
				resp=$(printf "%x\n" "'$1")
			;;
			hc)
				suf1="em hexadecimal"; suf2="em caractere"
				resp=$(printf '%d\n' "0x${1#0x}" | awk '{printf "%c\n", $1}')
			;;
			dh)
				suf1="em decimal"; suf2="em hexadecimal"
				resp=$(printf '%x\n' "$1")
			;;
			hd)
				suf1="em hexadecimal"; suf2="em decimal"
				resp=$(printf '%d\n' "0x${1#0x}")
			;;
			gr)
				suf1="°"; suf2="rad"
				resp=$(echo "pi=4*a(1);$1*pi/180" | bc -l | awk '{printf "%.04f\n", $1}')
			;;
			rg)
				suf1="rad"; suf2="°"
				resp=$(echo "pi=4*a(1);$1*180/pi" | bc -l | awk '{printf "%.04f\n", $1}')
			;;
			ar)
				suf1="gon"; suf2="rad"
				resp=$(echo "pi=4*a(1);$1*pi/200" | bc -l | awk '{printf "%.04f\n", $1}')
			;;
			ra)
				suf1="rad"; suf2="gon"
				resp=$(echo "pi=4*a(1);$1*200/pi" | bc -l | awk '{printf "%.04f\n", $1}')
			;;
			ag)
				suf1="gon"; suf2="°"
				resp=$(echo "$1*0.9" | bc -l | awk '{printf "%.02f\n", $1}')
			;;
			ga)
				suf1="°"; suf2="gon"
				resp=$(echo "$1/0.9" | bc -l | awk '{printf "%.02f\n", $1}')
			;;
			*) zztool erro "Conversão inválida"; return 1; ;;
		esac

		test -n "$bc_expr" && resp=$(echo "$bc_expr" | bc -l)

		if test -n "$resp"
		then
			if test "$opt" = "e"
			then
				test "$suf1" != "°" && suf1=" $suf1"
				test "$suf2" != "°" && suf2=" $suf2"
				echo "${1}${suf1} = ${resp}${suf2}"
			else
				echo "$resp"
			fi
		fi

		shift
	done
}

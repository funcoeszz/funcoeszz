# ----------------------------------------------------------------------------
# Faz várias conversões como: caracteres, temperatura e distância.
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
#          hc = (H)exadecimal         para (C)aractere
#          ch = (C)aractere           para (H)exadecimal
#          dh = (D)ecimal             para (H)exadecimal
#          hd = (H)exadecimal         para (D)ecimal
# Uso: zzconverte <cf|fc|ck|kc|fk|kf|mk|km|db|bd|cd|dc|hc|ch|dh|hd> número
# Ex.: zzconverte cf 5
#      zzconverte dc 65
#      zzconverte db 32
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2003-10-02
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzconverte ()
{
	zzzz -h converte "$1" && return

	local s2='scale=2'
	local operacao=$1

	# Verificação dos parâmetros
	[ "$2" ] || { zztool uso converte; return 1; }

	shift
	while [ "$1" ]
	do
		case "$operacao" in
			cf)
				echo "$1 C = $(echo "$s2;($1*9/5)+32"     | bc) F"
			;;
			fc)
				echo "$1 F = $(echo "$s2;($1-32)*5/9"     | bc) C"
			;;
			ck)
				echo "$1 C = $(echo "$s2;$1+273.15"       | bc) K"
			;;
			kc)
				echo "$1 K = $(echo "$s2;$1-273.15"       | bc) C"
			;;
			kf)
				echo "$1 K = $(echo "$s2;($1*1.8)-459.67" | bc) F"
			;;
			fk)
				echo "$1 F = $(echo "$s2;($1+459.67)/1.8" | bc) K"
			;;
			km)
				echo "$1 km = $(echo "$s2;$1*0.6214"      | bc) milhas"
				# ^ resultado com 4 casas porque bc usa o mesmo do 0.6214
			;;
			mk)
				echo "$1 milhas = $(echo "$s2;$1*1.609"   | bc) km"
				# ^ resultado com 3 casas porque bc usa o mesmo do 1.609
			;;
			db)
				echo "obase=2;$1" | bc -l
			;;
			bd)
				#echo "$((2#$1))"
				echo "ibase=2;$1" | bc -l
			;;
			cd)
				printf "%d\n" "'$1"
			;;
			dc)
				# echo -e $(printf "\\\x%x" $1)
				awk 'BEGIN {printf "%c\n", '$1'}'
			;;
			ch)
				printf "%x\n" "'$1"
			;;
			hc)
				#echo -e "\x${1#0x}"
				printf '%d\n' "0x${1#0x}" | awk '{printf "%c\n", $1}'
			;;
			dh)
				printf '%x\n' "$1"
			;;
			hd)
				printf '%d\n' "0x${1#0x}"
			;;
		esac
		shift
	done
}

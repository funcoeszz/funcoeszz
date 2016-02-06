# ----------------------------------------------------------------------------
# Faz várias conversões como:
# caracteres, temperatura, distância, ângulo, grandeza e escala.
#  Opções:
#   -e: Resposta expandida, mais explicativa.
#      Obs: sem essa opção a resposta é curta, apenas o número convertivo.
#
# Temperatura:
#  cf = (C)elsius      => (F)ahrenheit  | fc = (F)ahrenheit  => (C)elsius
#  ck = (C)elsius      => (K)elvin      | kc = (K)elvin      => (C)elsius
#  fk = (F)ahrenheit   => (K)elvin      | kf = (K)elvin      => (F)ahrenheit
#
# Distância:
#  km = (K)Quilômetros => (M)ilhas      | mk = (M)ilhas      => (K)Quilômetros
#  mj = (M)etros       => (J)ardas      | jm = (J)ardas      => (M)etros
#  mp = (M)etros       => (P)és         | pm = (P)és         => (M)etros
#  jp = (J)ardas       => (P)és         | pj = (P)és         => (J)ardas
#
# Ângulo:
#  gr = (G)raus        => (R)adianos    | rg = (R)adianos    => (G)raus
#  ga = (G)raus        => Gr(A)dos      | ag = Gr(A)dos      => (G)raus
#  ra = (R)adianos     => Gr(A)dos      | ar = Gr(A)dos      => (R)adianos
#
# Número:
#  db = (D)ecimal      => (B)inário     | bd = (B)inário     => (D)ecimal
#  dc = (D)ecimal      => (C)aractere   | cd = (C)aractere   => (D)ecimal
#  do = (D)ecimal      => (O)ctal       | od = (O)ctal       => (D)ecimal
#  dh = (D)ecimal      => (H)exadecimal | hd = (H)exadecimal => (D)ecimal
#  hc = (H)exadecimal  => (C)aractere   | ch = (C)aractere   => (H)exadecimal
#  ho = (H)exadecimal  => (O)ctal       | oh = (O)ctal       => (H)exadecimal
#  hb = (H)exadecimal  => (B)inário     | bh = (B)inário     => (H)exadecimal
#  ob = (O)ctal        => (B)inário     | bo = (B)inário     => (O)ctal
#
# Escala:
#  Y => yotta      G => giga       d => deci       p => pico
#  Z => zetta      M => mega       c => centi      f => femto
#  E => exa        K => quilo      m => mili       a => atto
#  P => peta       H => hecto      u => micro      z => zepto
#  T => tera       D => deca       n => nano       y => yocto
#  un => unidade  ou  _ =>  unidade
#
# Uso: zzconverte [-e] <código(s)> [código grandeza] número [número ...]
# Ex.: zzconverte cf 5
#      zzconverte dc 65
#      zzconverte db 32 47 28
#      zzconverte G u 32    # Converte 32 gigas em 32000000000000000 micros
#      zzconverte f H 7     # Converte 7 femtos em 0.00000000000000007 hecto
#      zzconverte T 4       # Converte 4 teras em 4000000000000 unidades
#      zzconverte un M 3    # Converte 3 unidades em 0.000003 megas
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2003-10-02
# Versão: 4
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
	local pi='pi=4*a(1)'
	local awk_print='{saida=sprintf("%.04f", $1); sub(/[0]+$/,"",saida); sub(/\.$/,"",saida); print saida}'
	local operacao=$1
	local unid_escala="yzafpnumcd_DHKMGTPEZY"
	local nome_escala="yocto zepto atto femto pico nano micro mili centi deci un deca hecto quilo mega giga tera peta exa zetta yotta"
	local potencias="-24 -21 -18 -15 -12 -9 -6 -3 -2 -1 0 1 2 3 6 9 12 15 18 21 24"
	local resp suf1 suf2 bc_expr num_hex fator

	# Verificação dos parâmetros
	test -n "$2" || { zztool -e uso converte; return 1; }

	shift
	while test -n "$1"
	do
		# Verificando consistência para números
		case "$operacao" in
			b[dho]) zztool testa_binario "$1"                     || { shift; continue; } ;;
			d[boh]) zztool testa_numero  "$1"                     || { shift; continue; } ;;
			o[bdh]) echo "$1" | grep '^[0-7]\{1,\}$' >/dev/null   || { shift; continue; } ;;
			h[bdo])
				echo "$1" | grep '^[0-9A-Fa-f]\{1,\}$' >/dev/null || { shift; continue; }
				num_hex=$(echo ${1#0x} | tr [a-f] [A-F])
			;;
		esac

		case "$operacao" in
			# Escala:
			y|z|a|f|p|n|u|m|c|d|un|D|H|K|M|G|T|P|E|Z|Y)
				num_hex=$(echo $operacao | sed 's/un/_/')
				fator=$(echo "$potencias $(zztool index_var $num_hex $unid_escala)" | awk '{print $$NF}')
				suf1=$(echo "$nome_escala $(zztool index_var $num_hex $unid_escala)" | awk '{print $$NF}')
				case "$1" in
					y|z|a|f|p|n|u|m|c|d|un|D|H|K|M|G|T|P|E|Z|Y)
						num_hex=$(echo $1 | sed 's/un/_/')
						fator=$(echo "$potencias $(zztool index_var $num_hex $unid_escala)" | awk '{print '$fator' - $$NF}')
						suf2=$(echo "$nome_escala $(zztool index_var $num_hex $unid_escala)" | awk '{print $$NF}')
						shift
					;;
					*) suf2='un' ;;
				esac
				test $fator -lt 0 && s2="scale=${fator#-}"
				bc_expr="$s2;${1:-1}*10^$fator"
			;;
			# Temperatura:
			cf) suf1="°C";             suf2="°F";             bc_expr="$s2;($1*9/5)+32" ;;
			fc) suf1="°F";             suf2="°C";             bc_expr="$s2;($1-32)*5/9" ;;
			ck) suf1="°C";             suf2="K";              bc_expr="$s2;$1+273.15" ;;
			kc) suf1="K";              suf2="°C";             bc_expr="$s2;$1-273.15" ;;
			fk) suf1="°F";             suf2="K";              bc_expr="$s2;($1+459.67)/1.8" ;;
			kf) suf1="K";              suf2="°F";             bc_expr="$s2;($1*1.8)-459.67" ;;
			# Distância:
			km) suf1="km";             suf2="mi";             bc_expr="$s2;$1*0.6214" ;;
			mk) suf1="mi";             suf2="km";             bc_expr="$s2;$1*1.609" ;;
			mj) suf1="m";              suf2="yd";             bc_expr="$s2;$1/0.9144" ;;
			jm) suf1="yd";             suf2="m";              bc_expr="$s2;$1*0.9144" ;;
			mp) suf1="m";              suf2="ft";             bc_expr="$s2;$1/0.3048" ;;
			pm) suf1="ft";             suf2="m";              bc_expr="$s2;$1*0.3048" ;;
			jp) suf1="yd";             suf2="ft";             bc_expr="$s2;$1*3" ;;
			pj) suf1="ft";             suf2="yd";             bc_expr="$s2;$1/3" ;;
			# Número:
			db) suf1="em decimal";     suf2="em binário";     bc_expr="obase=2;$1" ;;
			bd) suf1="em binário";     suf2="em decimal";     bc_expr="ibase=2;$1" ;;
			dc) suf1="em decimal";     suf2="em caractere";   resp=$(awk 'BEGIN {printf "%c\n", '$1'}') ;;
			cd) suf1="em caractere";   suf2="em decimal";     resp=$(printf "%d\n" "'$1") ;;
			do) suf1="em decimal";     suf2="em octal";       bc_expr="obase=8;$1" ;;
			od) suf1="em octal";       suf2="em decimal";     bc_expr="ibase=8;${1#0}" ;;
			dh) suf1="em decimal";     suf2="em hexadecimal"; resp=$(printf '%x\n' "$1" | tr [a-f] [A-F]) ;;
			hd) suf1="em hexadecimal"; suf2="em decimal";     resp=$(printf '%d\n' "0x${1#0x}") ;;
			hc) suf1="em hexadecimal"; suf2="em caractere";   resp=$(printf '%d\n' "0x${1#0x}" | awk '{printf "%c\n", $1}') ;;
			ch) suf1="em caractere";   suf2="em hexadecimal"; resp=$(printf "%x\n" "'$1" | tr [a-f] [A-F]) ;;
			ho) suf1="em hexadecimal"; suf2="em octal";       bc_expr="obase=8;ibase=16;$num_hex" ;;
			hb) suf1="em hexadecimal"; suf2="em binário";     bc_expr="obase=2;ibase=16;$num_hex" ;;
			bh) suf1="em binário";     suf2="em hexadecimal"; bc_expr="obase=16;ibase=2;$1" ;;
			oh) suf1="em octal";       suf2="em hexadecimal"; bc_expr="obase=16;ibase=8;${1#0}" ;;
			ob) suf1="em octal";       suf2="em binário";     bc_expr="obase=2;ibase=8;${1#0}" ;;
			bo) suf1="em binário";     suf2="em octal";       bc_expr="obase=8;ibase=2;$1" ;;
			# Ângulo:
			gr) suf1="°";              suf2="rad";            resp=$(echo "$pi;$1*pi/180" | bc -l | awk "$awk_print") ;;
			rg) suf1="rad";            suf2="°";              resp=$(echo "$pi;$1*180/pi" | bc -l | awk "$awk_print") ;;
			ga) suf1="°";              suf2="gon";            resp=$(echo "$1/0.9" | bc -l | awk "$awk_print") ;;
			ag) suf1="gon";            suf2="°";              resp=$(echo "$1*0.9" | bc -l | awk "$awk_print") ;;
			ra) suf1="rad";            suf2="gon";            resp=$(echo "$pi;$1*200/pi" | bc -l | awk "$awk_print") ;;
			ar) suf1="gon";            suf2="rad";            resp=$(echo "$pi;$1*pi/200" | bc -l | awk "$awk_print") ;;
			*) zztool erro "Conversão inválida"; return 1; ;;
		esac

		test -n "$bc_expr" && resp=$(echo "$bc_expr" | bc -l | sed 's/\./0./')

		if test -n "$resp"
		then
			if test "$opt" = "e"
			then
				test "$suf1" != "°" && suf1=" $suf1"
				test "$suf2" != "°" && suf2=" $suf2"
				echo "${1:-1}${suf1} = ${resp}${suf2}"
			else
				echo "$resp"
			fi
		fi

		shift
	done
}

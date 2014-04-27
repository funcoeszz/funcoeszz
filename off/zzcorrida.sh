# ----------------------------------------------------------------------------
# Mostra a classificação dos pilotos em várias corridas (F1, Indy, GP, ...).
#
#  Use as seguintes combinações para as corridas
#   Fórmula 1: f1 ou formula1
#   Fórmula Indy: indy ou formula_indy
#   GP2: gp2
#   Fórmula Truck: truck ou formula_truck
#   Fórmula Truck Sul-Americana: truck_sul
#   Stock Car: stock ou stock_car
#   Moto GP: moto ou moto_gp
#   Moto 2: moto2
#   Moto 3: moto3
#   Rali: rali
#   Sprint Cup (Nascar): nascar ou sprint_cup
#   Truck Series (Nascar): nascar2 ou truck_series
#   Nationwide Series (Nascar): nascar3 ou nationwide
#
# Uso: zzcorrida <f1|indy|gp2|truck|truck_sul|stock|rali>
# Uso: zzcorrida <moto|moto_gp|moto2|moto3>
# Uso: zzcorrida <nascar|sprint_cup|nascar2|truck_series|nascar3|nationwide>
# Ex.: zzcorrida truck
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2011-11-02
# Versão: 7
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2014-04-20 O site encerrou e sem um substituto equivalente.
zzcorrida ()
{
	zzzz -h corrida "$1" && return

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso corrida; return 1; }

	local corridas nome_corrida
	local url="http://tazio.uol.com.br/classificacoes"

	case "$1" in
		f1 | formula1)				corridas="f1"; nome_corrida="Fórmula 1";;
		indy | formula_indy)			corridas="indy"; nome_corrida="Fórmula Indy";;
		gp2)					corridas="gp2"; nome_corrida="GP2";;
		nascar | sprint_cup)			corridas="nascar"; nome_corrida="Sprint Cup";;
		nascar2 | truck_series)			corridas="nascar"; nome_corrida="Truck Series";;
		nascar3 | nationwide)			corridas="nascar"; nome_corrida="Nationwide Series";;
		truck | formula_truck)			corridas="formula-truck"; nome_corrida="Fórmula Truck";;
		truck_sul)				corridas="formula-truck"; nome_corrida="Fórmula Truck Sul-Americano";;
		rali)					corridas="rali"; nome_corrida="Rali";;
		stock | stock_car)			corridas="stock-car"; nome_corrida="Stock Car";;
		moto | moto_gp | moto2 | moto3)		corridas="moto"; nome_corrida=$(echo "Moto ${1#moto}" | tr -d '_' | tr 'gp' 'GP');;
		*)					zztool uso corrida; return 1;;
	esac

	zztool eco "${nome_corrida}"

	case "$1" in
		nascar | sprint_cup)
			$ZZWWWDUMP "$url/$corridas" | sed -n '/Pos.*Piloto/,/Data/p' |
			sed '1,/Data/!d;s/ Pontos/Pontos/' | sed 's/\[.*\]/        /;$d;s/^ *//g'
		;;
		nascar2 | truck_series)
			$ZZWWWDUMP "$url/$corridas" | sed '1,/Pos.*Piloto/ d' | sed '1,/Pos.*Piloto/ d' |
			sed -n '/Pos.*Piloto/,/^ *$/ p' |
			sed 's/ Pontos/Pontos/' | sed 's/\[.*\]/        /;$d;s/^ *//g'
		;;
		nascar3 | nationwide)
			$ZZWWWDUMP "$url/$corridas" | sed '1,/Pos.*Piloto/ d' |
			sed -n '/Pos.*Piloto/,/Pos.*Piloto/ p' |
			sed 's/ Pontos/Pontos/' | sed 's/\[.*\]/        /;$d;s/^ *//g'
		;;
		truck | formula_truck)
			$ZZWWWDUMP "$url/$corridas" | sed -n '/Pos.*Piloto/,/Pos.*Piloto/p' |
			sed 's/ Pontos/Pontos/;$d' | sed 's/\[.*\]/        /;s/^ *//g'
		;;
		truck_sul)
			$ZZWWWDUMP "$url/$corridas" | sed -n '/Pos.*Piloto/,/Data/p' |
			sed '2,/Pos.*Piloto/d;s/ Pontos/Pontos/;$d' | sed 's/\[.*\]/        /;s/^ *//g'
		;;
		moto | moto_gp)
			$ZZWWWDUMP "$url/$corridas" | sed -n '/Pos.*Piloto/,/^ *$/p' |
			sed '1p;2,/Pos.*Piloto/!d' | sed 's/ Pontos/Pontos/;$d' | sed 's/\[.*\]/        /;s/^ *//g'
		;;
		moto2)
			$ZZWWWDUMP "$url/$corridas" | sed '1,/Pos.*Piloto/ d' |
			sed -n '/Pos.*Piloto/,/Pos.*Piloto/ p' |
			sed 's/ Pontos/Pontos/;$d' | sed 's/\[.*\]/        /;s/^ *//g'
		;;
		moto3)
			$ZZWWWDUMP "$url/$corridas" | sed '1,/Pos.*Piloto/ d' | sed '1,/Pos.*Piloto/ d' |
			sed -n '/Pos.*Piloto/,/^ *Data / p' |
			sed 's/ Pontos/Pontos/;$d' | sed 's/\[.*\]/        /;s/^ *//g'
		;;
		*)
			$ZZWWWDUMP "$url/$corridas" | sed -n '/Pos.*Piloto/,$ p' |
			sed '/^ *Data/ q' | sed '/^ *Pos *Equipe/ q' |
			sed 's/ Pontos/Pontos/;$d' | sed 's/\[.*\]/        /;s/^ *//g'
		;;
	esac
}

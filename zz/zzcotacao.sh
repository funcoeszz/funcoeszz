# ----------------------------------------------------------------------------
# http://www.infomoney.com.br
# Busca cotações do dia de algumas moedas em relação ao Real (compra e venda).
# Uso: zzcotacao
# Ex.: zzcotacao
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-19
# Versão: 5
# Requisitos: zzzz zztool zzjuntalinhas zznumero zzpad zzsqueeze zztrim zzunescape zzxml
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzcotacao ()
{
	zzzz -h cotacao "$1" && return

	local moeda compra venda var

	zztool eco "Infomoney"
	zztool source "http://www.infomoney.com.br/mercados/cambio" |
	sed -n '/<thead/,/thead>/p;/<tbody/,/tbody>/{ s/ *</</g;p;}' |
	zzjuntalinhas -i '<tr>' -f '</tr>' |
	zzxml --untag |
	zzsqueeze |
	zztrim |
	zzunescape --html |
	awk ' BEGIN {OFS="|"}
	{
		if ( NR == 1 ) print $1, $2, $3, $4
		if ( NR >  1 ) {
			if (NF == 4) print $1, $2, $3, $4
			if (NF == 5) print $1 " " $2, $3, $4, $5
		}
	}' |
	while IFS='|' read -r moeda compra venda var
	do
		if test 'Moeda' = "$moeda"
		then
			printf "$(zzpad 17 ' ')\t$(zzpad 6 $compra)\t$(zzpad 6 $venda)\t$(zzpad 6 $var | sed 's/%/&&/')\n"
		else
			printf "$(zzpad 17 $moeda)\t$(zznumero -f '%.3f' $compra)\t$(zznumero -f '%.3f' $venda)\t$(zznumero -f '%.3f' $var)\n"
		fi
	done
}

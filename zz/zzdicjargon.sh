# ----------------------------------------------------------------------------
# http://catb.org/jargon/
# Dicionário de jargões de informática, em inglês.
# Uso: zzdicjargon palavra(s)
# Ex.: zzdicjargon vi
#      zzdicjargon all your base are belong to us
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-02-22
# Versão: 1
# Licença: GPL
# Requisitos: zztrim
# ----------------------------------------------------------------------------
zzdicjargon ()
{
	zzzz -h dicjargon "$1" && return

	local achei achei2 num mais
	local url='http://catb.org/jargon/html'
	local cache=$(zztool cache dicjargon)
	local padrao=$(echo "$*" | sed 's/ /-/g')

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso dicjargon; return 1; }

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWLIST "$url/go01.html" |
			sed '
				/^ *[0-9][0-9]*\. /!d
				s@.*/html/@@
				/^[A-Z0]\//!d' > "$cache"
	fi

	achei=$(grep -i "$padrao" $cache)
	num=$(echo "$achei" | zztool num_linhas)

	test -n "$achei" || return

	if test $num -gt 1
	then
		mais=$achei
		achei2=$(echo "$achei" | grep -w "$padrao" | sed 1q)
		test -n "$achei2" && achei="$achei2" && num=1
	fi

	if test $num -eq 1
	then
		$ZZWWWDUMP -width=72 "$url/$achei" |
			sed '1,/_\{9\}/d;/_\{9\}/,$d;/^$/d' | zztrim -l
		test -n "$mais" && zztool eco '\nTermos parecidos:'
	else
		zztool eco 'Achei mais de um! Escolha qual vai querer:'
	fi

	test -n "$mais" && echo "$mais" | sed 's/..// ; s/\.html$//'
}

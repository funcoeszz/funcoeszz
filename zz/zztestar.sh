# ----------------------------------------------------------------------------
# Testa a validade do número no tipo de categoria selecionada.
# Nada é ecoado na saída padrão, apenas deve-se analisar o código de retorno.
# Pode-se ecoar a saída de erro usando a opção -e antes da categoria.
#
#  Categorias:
#   ano                      =>  Ano válido
#   ano_bissexto | bissexto  =>  Ano Bissexto
#   exp | exponencial        =>  Número em notação científica
#   numero | numero_natural  =>  Número Natural ( inteiro positivo )
#   numero_sinal | inteiro   =>  Número Inteiro ( positivo ou negativo )
#   numero_fracionario       =>  Número Fracionário ( casas decimais )
#   numero_real              =>  Número Real ( casas decimais possíveis )
#   complexo                 =>  Número Complexo ( a+bi )
#   dinheiro                 =>  Formato Monetário ( 2 casas decimais )
#   bin | binario            =>  Número Binário ( apenas 0 e 1 )
#   octal | octadecimal      =>  Número Octal ( de 0 a 7 )
#   hexa | hexadecimal       =>  Número Hexadecimal ( de 0 a 9 e A até F )
#   ip | ip4 | ipv4          =>  Endereço de rede IPV4
#   ip6 | ipv6               =>  Endereço de rede IPV6
#   mac                      =>  Código MAC Address válido
#   data                     =>  Data com formatação válida ( dd/mm/aaa )
#   hora                     =>  Hora com formatação válida ( hh:mm )
#
#   Obs.: ano, ano_bissextto e os
#         números naturais, inteiros e reais sem separador de milhar.
#
# Uso: zztestar [-e] categoria número
# Ex.: zztestar ano 1999
#      zztestar ip 192.168.1.1
#      zztestar hexa 4ca9
#      zztestar numero_real -45,678
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2016-03-14
# Versão: 3
# Requisitos: zzzz zztool
# Tags: número, teste
# ----------------------------------------------------------------------------
zztestar ()
{
	zzzz -h testar "$1" && return

	local erro

	# Devo mostrar a mensagem de erro?
	test '-e' = "$1" && erro=1 && shift

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso testar; return 1; }

	case "$1" in
		ano) zztool ${erro:+-e} testa_ano "$2" ;;

		ano_bissexto | bissexto)
			# Testa se $2 é um ano bissexto
			#
			# A year is a leap year if it is evenly divisible by 4
			# ...but not if it's evenly divisible by 100
			# ...unless it's also evenly divisible by 400
			# http://timeanddate.com
			# http://www.delorie.com/gnu/docs/gcal/gcal_34.html
			# http://en.wikipedia.org/wiki/Leap_year
			#
			local y=$2
			test $((y%4)) -eq 0 && test $((y%100)) -ne 0 || test $((y%400)) -eq 0
			test $? -eq 0 && return 0

			test -n "$erro" && zztool erro "Ano bissexto inválido '$2'"
			return 1
		;;

		exp | exponencial)
			# Testa se $2 é um número em notação científica
			echo "$2" | sed 's/^-\([.,]\)/-0\1/;s/^\([.,]\)/0\1/' |
			grep '^[+-]\{0,1\}[0-9]\{1,\}\([,.][0-9]\{1,\}\)\{0,1\}[eE][+-]\{0,1\}[0-9]\{1,\}$' >/dev/null && return 0

			test -n "$erro" && zztool erro "Número exponencial inválido '$2'"
			return 1
		;;

		numero | numero_natural) zztool ${erro:+-e} testa_numero "$2" ;;

		numero_sinal | inteiro)
			# Testa se $2 é um número (pode ter sinal: -2 +2)
			echo "$2" | grep '^[+-]\{0,1\}[0-9]\{1,\}$' >/dev/null && return 0

			test -n "$erro" && zztool erro "Número inteiro inválido '$2'"
			return 1
		;;

		numero_fracionario)
			# Testa se $2 é um número fracionário (1.234 ou 1,234)
			# regex: \d+[,.]\d+
			echo "$2" | grep '^[0-9]\{1,\}[,.][0-9]\{1,\}$' >/dev/null && return 0

			test -n "$erro" && zztool erro "Número fracionário inválido '$2'"
			return 1
		;;

		numero_real)
			# Testa se $2 é um número real (1.234; 1,234; -56.789; 123)
			# regex: [+-]?\d+([,.]\d+)?
			echo "$2" | sed 's/^-\([.,]\)/-0\1/;s/^\([.,]\)/0\1/' |
			grep '^[+-]\{0,1\}[0-9]\{1,\}\([,.][0-9]\{1,\}\)\{0,1\}$' >/dev/null && return 0

			test -n "$erro" && zztool erro "Número real inválido '$2'"
			return 1
		;;

		complexo)
			# Testa se $2 é um número complexo (3+5i ou -9i)
			# regex: ((\d+([,.]\d+)?)?[+-])?\d+([,.]\d+)?i
			echo "$2" | sed 's/^-\([.,]\)/-0\1/;s/^\([.,]\)/0\1/' |
			grep '^\(\([+-]\{0,1\}[0-9]\{1,\}\([,.][0-9]\{1,\}\)\{0,1\}\)\{0,1\}[+-]\)\{0,1\}[0-9]\{1,\}\([,.][0-9]\{1,\}\)\{0,1\}i$' >/dev/null && return 0

			test -n "$erro" && zztool erro "Número complexo inválido '$2'"
			return 1
		;;

		dinheiro)
			# Testa se $2 é um valor monetário (1.234,56 ou 1234,56)
			# regex: (  \d{1,3}(\.\d\d\d)+  |  \d+  ),\d\d
			echo "$2" | grep '^[+-]\{0,1\}\([0-9]\{1,3\}\(\.[0-9][0-9][0-9]\)\{1,\}\|[0-9]\{1,\}\),[0-9][0-9]$' >/dev/null && return 0

			test -n "$erro" && zztool erro "Valor inválido '$2'"
			return 1
		;;

		bin | binario)
			# Testa se $2 é um número binário
			echo "$2" | grep '^[01]\{1,\}$' >/dev/null && return 0

			test -n "$erro" && zztool erro "Número binário inválido '$2'"
			return 1
		;;

		octal | octadecimal)
			# Testa se $2 é um número octal
			echo "$2" | grep '^[0-7]\{1,\}$' >/dev/null && return 0

			test -n "$erro" && zztool erro "Número octal inválido '$2'"
			return 1
		;;

		hexa | hexadecimal)
			# Testa se $2 é um número hexadecimal
			echo "$2" | grep '^[0-9A-Fa-f]\{1,\}$' >/dev/null && return 0

			test -n "$erro" && zztool erro "Número hexadecimal inválido '$2'"
			return 1
		;;

		ip | ip4 | ipv4)
			# Testa se $2 é um número IPV4 (nnn.nnn.nnn.nnn)
			local nnn="\([0-9]\|[1-9][0-9]\|1[0-9][0-9]\|2[0-4][0-9]\|25[0-5]\)" # 0-255
			echo "$2" | grep "^$nnn\.$nnn\.$nnn\.$nnn$" >/dev/null && return 0

			test -n "$erro" && zztool erro "Número IP inválido '$2'"
			return 1
		;;

		ip6 | ipv6)
			# Testa se $2 é um número IPV6 (hhhh:hhhh:hhhh:hhhh:hhhh:hhhh:hhhh:hhhh)
			echo "$2" |
			awk -F : '
			{
				if ( $0 ~ /^:[^:]/ )      { exit 1 }
				if ( $0 ~ /:::/  )        { exit 1 }
				if ( $0 ~ /[^:]:$/ )      { exit 1 }
				if ( NF<8 && $0 !~ /::/ ) { exit 1 }
				if ( $0 ~ /::.+::/ )      { exit 1 }
				if ( NF>8 )               { exit 1 }
				if ( NF<=8 ) {
					for (i=1; i<=NF; i++) {
						if (length($i)>4)  { exit 1 }
						if (length($i)>0 && $i !~ /^[0-9A-Fa-f]+$/) { exit 1 }
					}
				}
			}' && return 0

			test -n "$erro" && zztool erro "Número IPV6 inválido '$2'"
			return 1
		;;

		mac)
			# Testa se $2 tem um formato de MAC válido
			# O MAC poderá ser nos formatos 00:00:00:00:00:00, 00-00-00-00-00-00 ou 0000.0000.0000
			echo "$2" | egrep '^([0-9A-Fa-f]{2}-){5}[0-9A-Fa-f]{2}$' >/dev/null && return 0
			echo "$2" | egrep '^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$' >/dev/null && return 0
			echo "$2" | egrep '^([0-9A-Fa-f]{4}\.){2}[0-9A-Fa-f]{4}$' >/dev/null && return 0

			test -n "$erro" && zztool erro "MAC address inválido '$2'"
			return 1
		;;

		data) zztool ${erro:+-e} testa_data "$2" ;;

		hora)
			# Testa se $2 é uma hora (hh:mm)
			echo "$2" | grep "^\(0\{0,1\}[0-9]\|1[0-9]\|2[0-3]\):[0-5][0-9]$" >/dev/null && return 0

			test -n "$erro" && zztool erro "Hora inválida '$2'"
			return 1
		;;

		*)
			# Qualquer outra opção retorna erro
			test -n "$erro" && zztool erro "Opção '$1' inválida"
			return 1
		;;
	esac
}

# ----------------------------------------------------------------------------
# Contabiliza total de bytes, caracteres, palavras ou linhas de um arquivo.
# Ou exibe tamanho da maior linha em bytes, caracteres ou palavras.
# Opcionalmente exibe as maiores linhas, desse arquivo.
# Também aceita receber dados pela entrada padrão (stdin).
# É uma emulação do comando wc, que não contabiliza '\r' e '\n'.
#
# Opções:
#   -c  total de bytes
#   -m  total de caracteres
#   -l  total de linhas
#   -w  total de palavras
#   -C, -L, -W  maior linha em bytes, caracteres ou palavras respectivamente
#   -p Exibe a maior linha em bytes, caracteres ou palavras,
#      usado junto com as opções -C, -L e -W.
#
#    Se as opções forem omitidas adota -l -w -c por padrão.
#
# Uso: zzwc [-c|-C|-m|-l|-L|-w|-W] [-p] arquivo
# Ex.: echo "12345"       | zzwc -c     # 5
#      printf "abcde"     | zzwc -m     # 5
#      printf "abc\123"   | zzwc -l     # 2
#      printf "xz\n789\n" | zzwc -L     # 3
#      printf "wk\n456"   | zzwc -M -p  # 456
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2016-03-10
# Versão: 1
# Licença: GPL
# Tags: contagem, emulação
# ----------------------------------------------------------------------------
zzwc ()
{
	zzzz -h wc "$1" && return

	local tb tc tl tw mb mc mw p conteudo saida linha

	# Opções de linha de comando
	while test "${1#-}" != "$1"
	do
		case "$1" in
			-c) tb=0  ;;
			-m) tc=0  ;;
			-l) tl=0  ;;
			-w) tw=0  ;;
			-p) p=1   ;;
			-C) mb=0  ;;
			-L) mc=0  ;;
			-W) mw=0  ;;
			--) shift; break ;;
			-*) zztool -e uso wc; return 1 ;;
			* ) break ;;
		esac
		shift
	done

	if test -z "${tb}${tc}${tl}${tw}${mb}${mc}${mw}"
	then
		tb=0; tl=0; tw=0
	fi

	conteudo=$(zztool file_stdin -- "$@" | sed '${ s/$/ /; }')

	# Linhas
	if test -n "$tl"
	then
		tl=$(echo "$conteudo" | zztool num_linhas)
		saida="$tl"
	fi

	# Palavras
	if test -n "$tw"
	then
		tw=$(echo "$conteudo" | wc -w | tr -d -c '[0-9]')
		test -n "$saida" && saida="$saida|$tw" || saida="$tw"
	fi

	# Caracteres
	if test -n "$tc"
	then
		tc=$(echo "$conteudo" | sed 's/././g' | tr -d '\r\n' | wc -c)
		tc=$((tc-1))
		test -n "$saida" && saida="$saida|$tc" || saida="$tc"
	fi

	# Bytes
	if test -n "$tb"
	then
		tb=$(echo "$conteudo" | tr -d '\r\n' | wc -c)
		tb=$((tb-1))
		test -n "$saida" && saida="$saida|$tb" || saida="$tb"
	fi

	# Saida do resultado dos linhas, palavras, caracteres e/ou bytes.
	if test -n "$saida"
	then
		echo "$saida" | tr '|' '\t'
	fi

	# Exibição do tamanho ou da(s) linha(s) mais longa(s)
	if test -n "${mb}${mc}${mw}"
	then
		maior=$(
		echo "$conteudo" |
		while read linha
		do
			printf "%s" "$linha" |
			if test -n "$mb"
			then
				wc -c
			elif test -n "$mc"
			then
				sed 's/[^[:cntrl:]]/./g' | awk 'BEGIN {FS=""} { print NF }'
			elif test -n "$mw"
			then
				wc -w
			fi
		done |
		awk -v end_sed="$p" '
			{ linha[NR]=$1 ; maior=(maior<$1?$1:maior) }
			END {
				if (length(end_sed)) {
					for (i=1;i<=NR;i++) {
						if (linha[i]==maior) printf i "p;"
					}
				}
				else { print maior }
			}'
		)

		if test -n "$p"
		then
			echo "$conteudo" | sed -n "$maior"
		else
			echo "$maior"
		fi
	fi
}

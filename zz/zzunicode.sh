# ----------------------------------------------------------------------------
# Mostra a tabela Unicode com todos os caracteres imprimíveis.
# Opções:
#   -n: Exibe o nome do caractere.
#   -c <número>: Define a divisão da lista em colunas.
#
# Uso: zzunicode [-n|-c <número>] [número]
# Ex.: zzunicode           # Exibe a lista de todas as classes de caracretes
#      zzunicode -n 42     # Exibe os caracteres com código e nome
#      zzunicode -c 4 24   # Exibe os caracteres em 4 colunas
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2018-10-13
# Versão: 2
# Licença: GPL
# Requisitos: zzcolunar zzlimpalixo zztrim zzunescape
# Tags: internet, texto, tabela
# ----------------------------------------------------------------------------
zzunicode ()
{
	zzzz -h unicode "$1" && return

	local cache=$(zztool cache unicode)
	local url="https://unicode-table.com/"
	local nome=0
	local bloco coluna

	# Lista dos vários tipos de caracteres unicode num arquivo padrão csv
	if ! test -s "$cache"
	then
		zztool source "$url" |
		awk -F '["><]'  '/data-end/ && /data-begin/ && !/control-character/ {print $7 ";"$5 ";" $11 ";" $9 }' |
		zztrim > "$cache"
	fi

	if test $# -eq 0
	then
		awk -F ';' '{ printf "%3d - %s a %s - %s\n", NR, $1, $2, $3}' "$cache"
		return
	fi

	# Opções de linha de comando
	while test "${1#-}" != "$1"
	do
		case "$1" in
			-n | --nome   ) nome=1; shift;;
			-c | --coluna ) nome=0; coluna=$2; shift; shift;;
			-*) zztool -e uso unicode; return 1;;
			*) break;;
		esac
	done

	# Selecionando o bloco dos classes de caracteres unicode
	if zztool testa_numero $1 && test $1 -le 278
	then
		bloco=$(sed -n "$1 {s|.*;|en/blocks/|;p;}" "$cache")
		zztool eco $(sed -n "$1 {s/;[^;]*$//;s/.*;//;p;}" "$cache")
	else
		zztool -e uso unicode
		return 1
	fi

	zztool source "${url}${bloco}" |
	sed -n '/class="symbols-grid__symbol"/{s/^ *//;s/ *$//;s/<div [^>]*>//g;s/<\/div>//g;s/U+//;p;};/data-template/{s/^ *//;s/ *$//;p;}' |
	zzunescape --html |
	sed 's/","url":.*//;s/.*"title":"/title:/' |
	zzlimpalixo |
	if test "$nome" -eq 1
	then
		awk '/title:/ { sub(/title:/,""); nome=$0; next }; { print $2 "\t" $1 "\t" nome }'
	else
		awk '!/title:/ { print $2 "\t" $1 }'
	fi |
	if test -n "$coluna"
	then
		zzcolunar -w 15 $coluna
	else
		cat -
	fi
}

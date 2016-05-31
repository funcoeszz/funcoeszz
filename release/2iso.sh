#!/usr/bin/env bash
# 2008-07-23
# Aurelio Jargas
#
# Gera a versão ISO-8859-1 (latin-1) das Funções ZZ

cd $(dirname "$0") || exit 1

# Cadê o arquivo de entrada?
if test -z "$1"
then
	echo "Uso: $0 arquivo"
	exit 1
fi

infile="$1"                                      # funcoeszz-13.2.sh
outfile=$(echo "$1" | sed 's/\.sh$/-iso.sh/')    # funcoeszz-13.2-iso.sh

# Tudo certo?
if ! test -f "$infile"
then
	echo "$infile not found"
	exit 1
fi

# Desliga a variável global ZZUTF, usada por várias funções
sed 's/^ZZUTF=1/ZZUTF=0/' "$infile" |

	# Define a codificação em $ZZWWW*, zzglobo e zznome
	# ou zztool [source|dump|post|list] [-i|-o] [charset]
	sed 's/\([=-]\)UTF-8/\1ISO-8859-1/g' |

	# Converte o código das ZZ para latin-1
	iconv -c -f UTF-8 -t ISO-8859-1 > "$outfile"

# Torna executável
chmod +x "$outfile"

# Mostra que fez
ls -l "$infile" "$outfile"

#!/usr/bin/env bash
# 2008-07-23
# Aurelio Jargas
#
# Gera a versão ISO-8859-1 (latin-1) das Funções ZZ

cd $(dirname "$0") || exit 1

infile="funcoeszz-13.2.sh"
outfile="funcoeszz-13.2-iso.sh"

# Tudo certo?
if ! test -f "$infile"
then
	echo "$infile not found"
	exit 1
fi

cp "$infile" _tmp

# Desliga a variável global ZZUTF, usada por várias funções
"$infile" trocapalavra 'ZZUTF=1' 'ZZUTF=0' _tmp

# Define a codificação em $ZZWWW*, zzgoogle e zzbabelfish
"$infile" trocapalavra '=UTF-8' '=ISO-8859-1' _tmp

# Converte o código das ZZ para latin-1
iconv -c -f UTF-8 -t ISO-8859-1 _tmp > "$outfile"

# Torna executável
chmod +x "$outfile"

# Mostra que fez
ls -l "$infile" "$outfile"

rm _tmp

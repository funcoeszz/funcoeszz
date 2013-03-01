#!/bin/bash
# 2013-02-28
# Aurelio Jargas
#
# Gera a versão tudo-em-um para o público

cd $(dirname "$0") || exit 1

core="../funcoeszz"
zzdir="../zz"
version=$(grep '^ZZVERSAO=' "$core" | cut -d = -f 2)
output_file="funcoeszz-$version.sh"

echo "Generating funcoeszz version '$version'"
echo

# Generate
ZZDIR="$zzdir" ZZOFF='' "$core" --tudo-em-um > "$output_file"
chmod +x "$output_file"

ls -l "$output_file"

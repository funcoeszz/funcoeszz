#!/bin/sh
# missing.sh - Show functions not yet tested

# Go to tests folder
cd $(dirname "$0")

# List of all functions
base="\
zzajuda
zztool
zzzz"
other=$(ls -1 ../zz/ | sed 's/\.sh$//; s|.*/||')
all=$(printf "$base\n$other" | sort)

# List of already tested functions
tested=$(ls -1 zz*.sh | sed 's/\.sh$//' | sort)

# Who's not tested?
for zz_func in $all
do
	echo "$tested" | grep "^$zz_func$" > /dev/null || echo "$zz_func"
done

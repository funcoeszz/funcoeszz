#!/bin/sh
# missing.sh - Show functions not yet tested

# Go to tests folder
cd $(dirname "$0")

# List of all functions
all=$(ls -1 ../zz/ | sed 's/\.sh$//; s|.*/||' | sort)

# List of already tested functions
tested=$(ls -1 zz*.sh | sed 's/\.sh$//' | sort)

# Who's not tested?
for zz_func in $all
do
	echo "$tested" | grep "^$zz_func$" > /dev/null || echo "$zz_func"
done

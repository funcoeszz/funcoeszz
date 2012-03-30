#!/bin/bash
# 2012-03-29
# Aurelio Jargas
#
# Given a list of functions, show if some required functions are missing.
# If no output, there are no missing requirements.
#
# Usage:
#     $ ./missing-requires.sh zzcarnaval
#     zzdata
#     zzpascoa
#     $ ./missing-requires.sh zzcarnaval zzdata
#     zzpascoa
#     $ ./missing-requires.sh zzcarnaval zzdata zzpascoa
#     $


cd $(dirname "$0") || exit 1
cd ../zz

grep_var() {  # $1 está presente em $2?
	test "${2#*$1}" != "$2"
}

for zzfunc  # in $@
do
	# echo "*** $zzfunc"  # debug

	# List the requires for this function
	grep '^# Requisitos:' "$zzfunc" |
		sed 's/^# Requisitos: //' |
		tr ' ' '\n' |
		grep "^zz" |

		# Any of these are missing in the original list?
		while read required
		do
			grep_var " $required " " $* " || echo "$required"
		done
done |
sort |
uniq


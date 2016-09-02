#$ zzsheldon | grep -E '(Episode -|Sheldon:)' > /dev/null;     echo $?	#→ 0
#$ zzsheldon -t | grep -E 'Sheldon:' > /dev/null; echo $?	#→ 0
$ zzsheldon  | sed 's/^/|/;s/$/|/'
$ zzsheldon -t | sed 's/^/|/;s/$/|/'

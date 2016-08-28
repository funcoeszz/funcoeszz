$ zzsheldon | grep -E '^(Episode -|Sheldon:)' > /dev/null;     echo $?	#→ 0
$ zzsheldon -f | grep -E '^(Episódio -|Sheldon:)' > /dev/null; echo $?	#→ 0

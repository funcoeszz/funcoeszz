$ zzcbn --lista | grep -E '^[a-z-]+ *=> ' > /dev/null;     echo $?	#→ 0
$ zzcbn -c juca-kfouri | grep '^[A-Z]' > /dev/null;        echo $?	#→ 0
$ zzcbn -c walter-maierovitch | grep '^[A-Z]' > /dev/null; echo $?	#→ 0

$ zztv | sed '2,${s/ .*//;s/[0-9]/9/g;}' | uniq
Agora
99:99
$ zztv fox | sed '2s/.*/DATA/;3,${s/ .*//;s/[0-9]/9/g;}' | uniq
Fox
DATA
99:99
$ zztv canais | sed 's/ .*//;s/[0-9A-Z]/Z/g' | uniq
ZZZ
$

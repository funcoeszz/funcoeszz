$ zzdicesperanto -d pt -p eo função | grep -E -w '(funkcio|ofico)' | sort
funkcio
ofico
$

$ zzdicesperanto -p en trabalho | grep -E -w '(job|employment)' | sort
employment
job
$

$ zzdicesperanto -p de novo | grep -E -w '(weiter|neue)' | sort
neue
weiter
$

$ zzdicesperanto -d de Frieden | grep -E -w '[Pp]aco'
paco
Paco
$

$ zzdicesperanto -p de vitória | grep -E -w '(Sieg|Triumph)' | sort
Sieg
Triumph
$

$ zzdicesperanto saudade | grep -E -w '(nostalgio|saŭdado)' | sort
nostalgio
saŭdado
$

$ zzdicesperanto esperança | grep  -w 'espero' | uniq
espero
$

$ zzdicesperanto -d en never | grep  -w 'neniam'
neniam
$

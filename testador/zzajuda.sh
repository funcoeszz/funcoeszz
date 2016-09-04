# Preparação
$ PAGER='cat -'
$
$ zzajuda | grep -E -o '^(zz|Uso:|Ex.:)'
$
$ zzajuda | grep -E -o '^(zz|Uso:|Ex.:)' | uniq -c | sort | uniq | sed 's/^ *//'
1 Ex.:
1 Uso:
1 zz
$ zzajuda --lista | grep -E -o '^(zz|Uso:|Ex.:)' | uniq | sed 's/^ *//'	#→ zz

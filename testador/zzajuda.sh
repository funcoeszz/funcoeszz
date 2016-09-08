# Preparação
$ PAGER='cat -'
$
$ zzajuda | grep -E -o '^(zzz*|Uso:|Ex.:)' | uniq -c | sort | uniq | sed 's/^ *//'
1 Ex.:
1 Uso:
1 zz
1 zzzz
$ zzajuda --lista | grep -E -o '^(zz|Uso:|Ex.:)' | uniq | sed 's/^ *//'	#→ zz

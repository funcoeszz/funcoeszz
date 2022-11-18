$ zzmaiores | tr 0-9 9
99	clitest
99	zznumero.sh
99	zzdatafmt.sh
99	zztestar.sh
99	zzansi9html.out.html
99	zztimer.sh
99	zzf9.sh
99	zzdata.sh
99	zzconjugar.sh
99	zzascii.sh
$ zzmaiores -n 3 | tr 0-9 9
99	clitest
99	zznumero.sh
99	zzdatafmt.sh
$ zzmaiores -n 3 zza* | tr 0-9 9
99	zzansi9html.out.html
99	zzascii.sh
9	zzarrumacidade.sh
$ zzmaiores -n 3 -- zza* | tr 0-9 9
99	zzansi9html.out.html
99	zzascii.sh
9	zzarrumacidade.sh
$ zzmaiores -x
Opção inválida -x
$

# Quando usa -f, a lista de arquivos vem com um ./ na frente e usa bytes
# em vez de kb...

$ zzmaiores -n 3 | tr 0-9 9
99	clitest
99	zznumero.sh
99	zzdatafmt.sh
$ zzmaiores -n 3 -f | tr 0-9 9
99999	./clitest
99999	./zzdatafmt.sh
99999	./zznumero.sh
$

# Teste da opção recursiva. Note que o path usado como argumento é
# replicado na saída, como prefixo para todos os itens. A pasta em si (o
# total) aparece como primeiro item.

$ zzmaiores -n 3 -r ../testador | tr 0-9 9
9999	../testador
99	../testador/clitest
99	../testador/zznumero.sh
$

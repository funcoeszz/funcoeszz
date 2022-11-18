$ zzmaiores | sed '/clitest/d' | head -n 9 | cut -f 2
zznumero.sh
zzdatafmt.sh
zztestar.sh
zzansi2html.out.html
zztimer.sh
zzf1.sh
zzdata.sh
zzconjugar.sh
zzascii.sh
$ zzmaiores -n 3 | cut -f 2
clitest
zznumero.sh
zzdatafmt.sh
$ zzmaiores -n 3 zza* | cut -f 2
zzansi2html.out.html
zzascii.sh
zzarrumacidade.sh
$ zzmaiores -n 3 -- zza* | cut -f 2
zzansi2html.out.html
zzascii.sh
zzarrumacidade.sh
$

# preparativos
$ printf '\033[32m verde \033[m\n' > _tmp1
$ zzcores > _tmp2
$

$ zzansi2html _tmp1
<pre style="background:#000;color:#FFF"><div style="display:inline">
<span style="color:#0F0;font-weight:normal;text-decoration:none"> verde </div><div style="display:inline">
</pre>
$ zzansi2html _tmp2  #→ --file zzansi2html.out.html

# faxina
$ rm -f _tmp[12]
$

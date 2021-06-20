# preparativos
$ printf '\033[32m verde \033[m\n' > _tmp1
$ printf '\033[32m\033[K verde \033[m\033[K\r\r\n' > _tmp2
$ zzcores > _tmp3
$

$ zzansi2html _tmp1
<pre style="background:#000;color:#FFF"><div style="display:inline">
<span style="color:#0F0;font-weight:normal;text-decoration:none"> verde </div><div style="display:inline">
</pre>
$ zzansi2html _tmp1
<pre style="background:#000;color:#FFF"><div style="display:inline">
<span style="color:#0F0;font-weight:normal;text-decoration:none"> verde </div><div style="display:inline">
</pre>
$ zzansi2html _tmp3  #=> --file zzansi2html.out.html

# faxina
$ rm -f _tmp[123]
$

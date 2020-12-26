# Preparativos
$ cut -f 1 zzunescape.in.txt | sed '1d;6d;19d;165,168d' > _tmp1
$ cut -f 2 zzunescape.in.txt | sed '1d;6d;19d;165,168d' > _tmp2
$ cut -f 3 zzunescape.in.txt | sed '1d;6d;19d;165,168d' > _tmp3
$ cut -f 4 zzunescape.in.txt | sed '1d;6d;19d;165,168d' > _tmp4
$

# Todos, exceto espaços
$ zzcodchar --dec  _tmp1             #=> --file _tmp2
$ zzcodchar --hex  _tmp1             #=> --file _tmp3
$ zzcodchar --html _tmp1             #=> --file _tmp4

# Espaços
$ echo "X M L" | zzcodchar -s --xml  #=> X&nbsp;M&nbsp;L
$ echo "H H H" | zzcodchar -s --hex  #=> H&#xA0;H&#xA0;H
$ echo "0 0 0" | zzcodchar -s --dec  #=> 0&#160;0&#160;0
$ echo "     " | zzcodchar -s --html #=> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

# Aspas duplas
$ echo '" " "' | zzcodchar --html    #=> &quot; &quot; &quot;
$ echo '" " "' | zzcodchar --hex     #=> &#x22; &#x22; &#x22;
$ echo '" " "' | zzcodchar --dec     #=> &#34; &#34; &#34;

# Aspas simples
$ echo "'''''" | zzcodchar --html    #=> &apos;&apos;&apos;&apos;&apos;

# Faxina
$ rm -f _tmp[1-4]
$

# Preparativos

$ cut -f 1 zzunescape.in.txt > _tmp1
$ cut -f 2 zzunescape.in.txt > _tmp2
$ cut -f 3 zzunescape.in.txt > _tmp3
$ cut -f 4 zzunescape.in.txt > _tmp4
$

# Preparativos - XML

$ printf '&#34;&#x22;&quot; '	 > _tmp5
$ printf '&#38;&#x26;&amp; '	>> _tmp5
$ printf '&#39;&#x27;&apos; '	>> _tmp5
$ printf '&#60;&#x3C;&lt; '	>> _tmp5
$ printf '&#62;&#x3E;&gt;'	>> _tmp5
$

# HTML

$ zzunescape	--html	_tmp2	#→ --file _tmp1
$ zzunescape	--html	_tmp3	#→ --file _tmp1
$ zzunescape	--html	_tmp4	#→ --file _tmp1

# XML

$ zzunescape	--xml	_tmp5	#→ """ &&& ''' <<< >>>

# Faxina

$ rm -f _tmp[1-5]
$

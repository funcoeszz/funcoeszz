#!/usr/bin/env bash

cut -f 1 unescape.txt > _tmp1
cut -f 2 unescape.txt > _tmp2
cut -f 3 unescape.txt > _tmp3
cut -f 4 unescape.txt > _tmp4

echo "\
&#34;&#x22;&quot; \
&#38;&#x26;&amp; \
&#39;&#x27;&apos; \
&#60;&#x3C;&lt; \
&#62;&#x3E;&gt;" > _tmp5   # xml

values=2
tests=(
--html	_tmp2	a	_tmp1
--html	_tmp3	a	_tmp1
--html	_tmp4	a	_tmp1

--xml	_tmp5	t	"\"\"\" &&& ''' <<< >>>"
)
. _lib

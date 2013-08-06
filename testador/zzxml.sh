#!/usr/bin/env bash
debug=0
values=5

cat > _tmp1 <<EOS
<xml>
<section>
	<title>Título</title>
	<img src="foo.png" />
	<para>
		Meu parágrafo, com <strong>negrito</strong> e <em>itálico</em>.
	</para>
	<escape>&quot;&amp;&apos;&lt;&gt;</escape>
</section>
</xml>
EOS

tests=(
--tidy	_tmp1	''	''	''	a	xml.out

# tag única (sem fecha tag)
--tag	img	_tmp1	''	''	t	'<img src="foo.png" />'

# tag de uma linha
--tag	title	_tmp1	''	''	t	'<title>Título</title>'
--tag	title	--untag	_tmp1	''	t	'Título'

# tag multilinha
--tag	para	_tmp1	''	''	t	'<para> 		Meu parágrafo, com <strong>negrito</strong> e <em>itálico</em>. 	</para>'
--tag	para	--untag	_tmp1	''	t	' 		Meu parágrafo, com negrito e itálico. 	'
--tag	para	--untag	--unescape _tmp1	t	' 		Meu parágrafo, com negrito e itálico. 	'

# unescape
--tag	escape	--unescape _tmp1	''	t	"<escape>\"&'<></escape>"
# untag ocorre antes do unescape, por isso o <> não é afetado
--tag	escape	--unescape --untag	_tmp1	t	"\"&'<>"
)
. _lib

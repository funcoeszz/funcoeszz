# Formatar o XML

$ zzxml --tidy zzxml.in.xml    #→ --file zzxml.out.xml

# Tag única (sem fecha tag)

$ zzxml --tag img zzxml.in.xml
<img src="foo.png" />
$

# Tag de uma linha

$ zzxml --tag title         zzxml.in.xml     #→ <title>Título</title>
$ zzxml --tag title --untag zzxml.in.xml     #→ Título

# Tag multilinha

$ zzxml --tag para zzxml.in.xml
<para> 		Meu parágrafo, com <strong>negrito</strong> e <em>itálico</em>. 	</para>
$ zzxml --tag para --untag zzxml.in.xml
 		Meu parágrafo, com negrito e itálico. 	
$ zzxml --tag para --untag --unescape zzxml.in.xml
 		Meu parágrafo, com negrito e itálico. 	
$

# Unescape

$ zzxml --tag escape zzxml.in.xml
<escape>&quot;&amp;&apos;&lt;&gt;</escape>
$ zzxml --tag escape --unescape zzxml.in.xml
<escape>"&'<></escape>
$

# Untag ocorre antes do unescape, por isso o <> não é afetado

$ zzxml --tag escape --unescape --untag zzxml.in.xml
"&'<>
$


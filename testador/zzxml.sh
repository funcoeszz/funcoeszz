# Erros

$ zzxml --foo zzxml.in.xml
Opção inválida --foo
$

#----------------------------------------------------------------------
# --tidy: Formata o XML, uma tag por linha

$ zzxml --tidy zzxml.in.xml
<xml>
<section>
<title>
Título
</title>
<img src="foo.png" />
<para>
 		Meu parágrafo, com 
<strong>
negrito
</strong>
 e 
<em>
itálico
</em>
. 	
</para>
<escape>
&quot;&amp;&apos;&lt;&gt;
</escape>
</section>
</xml>
$


#----------------------------------------------------------------------
# Tag única (sem fecha tag)

$ zzxml --tag img zzxml.in.xml
<img src="foo.png" />
$ zzxml --tag img --untag zzxml.in.xml

$

#----------------------------------------------------------------------
# Tag de uma linha

$ zzxml --tag title zzxml.in.xml
<title>
Título
</title>
$

$ zzxml --tag title --untag zzxml.in.xml

Título

$

#----------------------------------------------------------------------
# Tag multilinha

$ zzxml --tag para zzxml.in.xml
<para>
 		Meu parágrafo, com 
<strong>
negrito
</strong>
 e 
<em>
itálico
</em>
. 	
</para>
$

$ zzxml --tag para --untag zzxml.in.xml

 		Meu parágrafo, com 

negrito

 e 

itálico

. 	

$

$ zzxml --tag para --untag --unescape zzxml.in.xml

 		Meu parágrafo, com 

negrito

 e 

itálico

. 	

$

#----------------------------------------------------------------------
# Unescape

$ zzxml --tag escape zzxml.in.xml
<escape>
&quot;&amp;&apos;&lt;&gt;
</escape>
$

$ zzxml --tag escape --unescape zzxml.in.xml
<escape>
"&'<>
</escape>
$

#----------------------------------------------------------------------
# Untag ocorre antes do unescape, por isso o <> não é afetado

$ zzxml --tag escape --unescape --untag zzxml.in.xml

"&'<>

$

# Preparando arquivo de nome incomun
$ cat zzxml.in.xml > "-_tmp1"
$

# Erros

$ zzxml --foo zzxml.in.xml
Opção inválida --foo
$

#----------------------------------------------------------------------
# --list: Lista todas as tags XML encontradas

$ zzxml --list zzxml.in.xml
xml
section
title
img
para
strong
em
escape
$

$ zzxml --list -- -_tmp1
xml
section
title
img
para
strong
em
escape
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
# --indent: Formata o XML, com indent (implica --tidy)

$ zzxml --indent zzxml.in.xml     #→ --file zzxml.out.indent.xml

#----------------------------------------------------------------------
# --indent com um XML sem quebras de linha

$ zzxml --tidy zzxml.in.xml | tr -d '\n' | zzxml --indent  #→ --file zzxml.out.indent.xml

#----------------------------------------------------------------------
# --notag NOME: Remove uma tag e seu conteúdo (implica --tidy)

$ zzxml --notag 'para' zzxml.in.xml
<xml>
<section>
<title>
Título
</title>
<img src="foo.png" />
<escape>
&quot;&amp;&apos;&lt;&gt;
</escape>
</section>
</xml>
$

$ zzxml --notag 'para' -- -_tmp1
<xml>
<section>
<title>
Título
</title>
<img src="foo.png" />
<escape>
&quot;&amp;&apos;&lt;&gt;
</escape>
</section>
</xml>
$

#----------------------------------------------------------------------
# Combina --notag NOME com --indent (em qualquer ordem)

$ zzxml --notag 'para' --indent zzxml.in.xml
<xml>
	<section>
		<title>
			Título
		</title>
		<img src="foo.png" />
		<escape>
			&quot;&amp;&apos;&lt;&gt;
		</escape>
	</section>
</xml>
$ zzxml --indent --notag 'para' zzxml.in.xml
<xml>
	<section>
		<title>
			Título
		</title>
		<img src="foo.png" />
		<escape>
			&quot;&amp;&apos;&lt;&gt;
		</escape>
	</section>
</xml>
$

#----------------------------------------------------------------------
# --notag NOME chamado múltiplas vezes

$ zzxml --notag 'para' --notag 'escape' --notag 'title' zzxml.in.xml
<xml>
<section>
<img src="foo.png" />
</section>
</xml>
$

$ zzxml --notag 'para' --notag 'escape' --notag 'title' -- -_tmp1
<xml>
<section>
<img src="foo.png" />
</section>
</xml>
$

#----------------------------------------------------------------------
# --untag sozinho remove todas as tags e deixa o conteúdo

$ zzxml --untag zzxml.in.xml
	Título
		Meu parágrafo, com negrito e itálico.
	&quot;&amp;&apos;&lt;&gt;
$

#----------------------------------------------------------------------
# --untag=NOME remove apenas a tags NOME, deixando o seu conteúdo

$ zzxml --untag=para zzxml.in.xml
<xml>
<section>
	<title>Título</title>
	<img src="foo.png" />
	
		Meu parágrafo, com <strong>negrito</strong> e <em>itálico</em>.
	
	<escape>&quot;&amp;&apos;&lt;&gt;</escape>
</section>
</xml>
$

#----------------------------------------------------------------------
# --untag=NOME chamado múltiplas vezes

$ zzxml --untag=para --untag=escape --untag=title zzxml.in.xml
<xml>
<section>
	Título
	<img src="foo.png" />
	
		Meu parágrafo, com <strong>negrito</strong> e <em>itálico</em>.
	
	&quot;&amp;&apos;&lt;&gt;
</section>
</xml>
$

#----------------------------------------------------------------------
# Tag única (sem fecha tag)

$ zzxml --tag 'img' zzxml.in.xml
<img src="foo.png" />
$ zzxml --tag 'img' --untag zzxml.in.xml
$

#----------------------------------------------------------------------
# Tag de uma linha

$ zzxml --tag 'title' zzxml.in.xml
<title>
Título
</title>
$

$ zzxml --tag 'title' --untag zzxml.in.xml
Título
$

#----------------------------------------------------------------------
# Tag multilinha

$ zzxml --tag 'para' zzxml.in.xml
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

$ zzxml --tag 'para' --untag zzxml.in.xml
		Meu parágrafo, com 
negrito
 e 
itálico
.	
$

$ zzxml --tag 'para' --untag --unescape zzxml.in.xml
		Meu parágrafo, com 
negrito
 e 
itálico
.	
$

#----------------------------------------------------------------------
# --tag NOME chamado múltiplas vezes

$ zzxml --tag escape --tag title --tag strong zzxml.in.xml
<title>
Título
</title>
<strong>
negrito
</strong>
<escape>
&quot;&amp;&apos;&lt;&gt;
</escape>
$

#----------------------------------------------------------------------
# STDIN e simula zzfeed

$ cat zzxml.in.xml zzxml.in.xml | zzxml --tag title --untag --unescape
Título
Título
$

#----------------------------------------------------------------------
# Chamadas aninhadas

$ cat zzxml.in.xml | zzxml --tag xml | zzxml --tag para | zzxml --tag strong
<strong>
negrito
</strong>
$

#
#----------------------------------------------------------------------
# Precedência de --untag=NOME sobre --tag NOME.
$ zzxml --untag='em' --tag 'em' zzxml.in.xml
$

# Precedência de --notag NOME sobre --untag=NOME.
#----------------------------------------------------------------------
$ zzxml --untag='em' --tag 'para' --notag 'em' zzxml.in.xml
<para>
		Meu parágrafo, com 
<strong>
negrito
</strong>
 e 
.	
</para>
$

# Precedência de --notag NOME sobre --tag NOME.
#----------------------------------------------------------------------
$ zzxml --tag 'strong' --notag 'para' zzxml.in.xml
$

#----------------------------------------------------------------------
# Unescape

$ zzxml --tag 'escape' zzxml.in.xml
<escape>
&quot;&amp;&apos;&lt;&gt;
</escape>
$

$ echo 'Apenas <div>algumas <span><center>Tags</center> justapostas</span></div>' | zzxml --tag center
<center>
Tags
</center>
$

$ echo 'Apenas <div>algumas <span><center>Tags</center> justapostas</span></div>' | zzxml --tag span
<span>
<center>
Tags
</center>
 justapostas
</span>
$

$ echo 'Apenas <div>algumas <span><center>Tags</center> justapostas</span></div>' | zzxml --notag center --tag div
<div>
algumas 
<span>
 justapostas
</span>
</div>
$

$ echo 'Apenas <div>algumas <span><center>Tags</center> justapostas</span></div>' | zzxml --indent
Apenas 
<div>
	algumas 
	<span>
		<center>
			Tags
		</center>
		justapostas
	</span>
</div>
$

$ zzxml --tag 'escape' --unescape zzxml.in.xml
<escape>
"&'<>
</escape>
$

#----------------------------------------------------------------------
# Untag ocorre antes do unescape, por isso o <> não é afetado

$ zzxml --tag 'escape' --unescape --untag zzxml.in.xml
"&'<>
$

# Limpeza
$ rm -f ./-_tmp1
$

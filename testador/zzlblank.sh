$ sed -n 3,8p zzxml.in.xml | zzlblank
<title>Título</title>
<img src="foo.png" />
<para>
    Meu parágrafo, com <strong>negrito</strong> e <em>itálico</em>.
</para>
<escape>&quot;&amp;&apos;&lt;&gt;</escape>
$

$ cat zzxml.out.indent.xml | sed '1d;$d' | zzlblank
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
$

$ cat zzxml.out.indent.xml | sed -n '3,20p' | zzlblank
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
$

$ cat zzxml.out.indent.xml | sed -n '3,20p' | zzlblank -t
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
$

$ cat zzxml.out.indent.xml | sed -n '6,20p' | zzlblank 12
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
$

# Tomando emprestado os arquivos zzxml.in.xml e zzxml.out.xml
# Preparando arquivo de nome incomun
$ cat zzxml.out.xml > "-_tmp1"
$

# Alinhando a esquerda com -l ou sem argumento
$ zzalinhar zzxml.in.xml | sed 's/$/|/'
<xml>                                                          |
<section>                                                      |
<title>Título</title>                                          |
<img src="foo.png" />                                          |
<para>                                                         |
Meu parágrafo, com <strong>negrito</strong> e <em>itálico</em>.|
</para>                                                        |
<escape>&quot;&amp;&apos;&lt;&gt;</escape>                     |
</section>                                                     |
</xml>                                                         |
$

$ zzalinhar -l zzxml.out.xml | sed 's/$/|/'
<xml>                    |
<section>                |
<title>                  |
Título                   |
</title>                 |
<img src="foo.png" />    |
<para>                   |
Meu parágrafo, com       |
<strong>                 |
negrito                  |
</strong>                |
e                        |
<em>                     |
itálico                  |
</em>                    |
.                        |
</para>                  |
<escape>                 |
&quot;&amp;&apos;&lt;&gt;|
</escape>                |
</section>               |
</xml>                   |
$

# Alinhar a direita
$ zzalinhar -r zzxml.out.xml
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

$ zzalinhar -r -- -_tmp1
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

# Centralizar
$ zzalinhar -c zzxml.out.xml | sed 's/$/|/'
          <xml>          |
        <section>        |
         <title>         |
         Título          |
        </title>         |
  <img src="foo.png" />  |
         <para>          |
   Meu parágrafo, com    |
        <strong>         |
         negrito         |
        </strong>        |
            e            |
          <em>           |
         itálico         |
          </em>          |
            .            |
         </para>         |
        <escape>         |
&quot;&amp;&apos;&lt;&gt;|
        </escape>        |
       </section>        |
         </xml>          |
$

# Justificar
$ sed 's/[<>]/ X /g;s|/| _ |g;' zzxml.in.xml | zztrim -H | zzalinhar -j
X                                       xml                                       X
X                                     section                                     X
X        title         X         Título         X         _         title         X
X                img                src="foo.png"                _                X
X                                      para                                       X
Meu parágrafo, com  X strong X negrito X  _ strong X  e  X em X itálico X  _ em X .
X                         _                         para                          X
X     escape      X      &quot;&amp;&apos;&lt;&gt;      X      _      escape      X
X                        _                        section                         X
X                         _                          xml                          X
$

# Limpeza
$ rm -f ./-_tmp1
$
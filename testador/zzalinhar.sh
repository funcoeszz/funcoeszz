# Tomando emprestado os arquivos zzxml.in.xml e zzxml.out.xml
# Alinhando a esquerda com -l ou sem argumento
$ zzalinhar zzxml.in.xml
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
$

$ zzalinhar -l zzxml.out.xml
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

# Centralizar
$ zzalinhar -c zzxml.out.xml 
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

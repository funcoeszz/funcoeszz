Testador das Funções ZZ
=======================

É preciso garantir que todas as funções estejam sempre funcionando corretamente. Esta não é uma tarefa fácil, já que são mais de 150 funções ao todo, e muitas delas dependem de informações obtidas em websites, que estão em constante mudança.

O testador automático das Funções ZZ testa o funcionamento de cada função e avisa caso algo esteja errado. Já estão cadastrados mais de 3.000 testes!



Como usar
---------

Todos os arquivos de testes são identificados pelo nome da função e a extensão `.sh`, ou seja, `zz*.sh`. O script chamado `run` é quem executa os testes, basta informar qual arquivo você quer testar:

```
$ ./run zztac.sh
OK: 5 of 5 tests passed
$
```

Se tudo estiver funcionando, todos os testes serão bem sucedidos e aparecerá essa mensagem de OK. Caso o testador encontre algum erro, mostrará uma mensagem de falha:

```
$ ./run zzarrumacidade.sh
--------------------------------------------------
[FAILED #12, line 15] zzarrumacidade "SAMPA"
@@ -1 +1 @@
-São Paulo
+S?o Paulo
--------------------------------------------------

FAIL: 1 of 66 tests failed
$
```

Ops, o teste número 12 falhou. Deu algum problema com a acentuação (sempre ela…).

Note que a falha é mostrada usando o formato do comando `diff`, onde a linha que inicia com `-` era o resultado esperado, e a linha iniciada com `+` foi o resultado incorreto obtido.

> Nota: Os testes só funcionam em sistemas com codificação **UTF-8**.


Testar várias funções
---------------------

Para testar múltiplas funções de uma só vez, basta informar os arquivos:

```
$ ./run zzbyte.sh zzcidade.sh zzhora.sh zzseq.sh zztac.sh
Testing file zzbyte.sh
Testing file zzcidade.sh
Testing file zzhora.sh
Testing file zzseq.sh
Testing file zztac.sh

     ok  fail  skip
     58     -     -    zzbyte.sh
      6     -     -    zzcidade.sh
     83     -     -    zzhora.sh
     73     -     -    zzseq.sh
      5     -     -    zztac.sh

OK: 225 of 225 tests passed
$
```



Testar TODAS as funções
-----------------------

Quer realmente ajudar a manter as funções sempre impecáveis, funcionando numa grande variedade de ambientes? Rode em sua máquina o teste completo, de todas as funções. Basta chamar o script sem argumentos:

```
$ ./run
Testing file zzalfabeto.sh
Testing file zzansi2html.sh
Testing file zzarrumacidade.sh
Testing file zzarrumanome.sh
Testing file zzascii.sh
Testing file zzbeep.sh
Testing file zzbicho.sh
Testing file zzbissexto.sh
Testing file zzblist.sh
...
$
```

Testar todas as funções vai levar alguns minutos, então relaxe.


Um teste falhou, o que faço agora?
----------------------------------

Se aparecer algum erro, por favor [abra um issue](https://github.com/funcoeszz/funcoeszz/issues/new) e cole nele o resultado do testador. Também informe qual a versão do seu sistema operacional e qualquer informação adicional que julgar útil para resolvermos o problema.

Se você manja de shell script, que tal **você mesmo** arregaçar as mangas e arrumar a função? O [código das funções](https://github.com/funcoeszz/funcoeszz/tree/master/zz) é bem amigável: é alinhado e comentado. Experimente, será divertido! Veja [as  instruções](https://github.com/funcoeszz/funcoeszz/blob/master/README.md), ou fale com o [@oreio](https://twitter.com/oreio).



Para adicionar um teste novo
----------------------------

Você não precisa ser programador para adicionar um teste novo. O arquivo de testes é bem simples: é uma cópia literal da própria linha de comando! Veja exemplos de arquivos de testes:

[/testador/zzvira.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zzvira.sh):

```
$ zzvira 'Inverte tudo'
odut etrevnI
$ zzvira -X 'De pernas pro ar'
ɹɐ oɹd sɐuɹǝd ǝp
$
```

[/testador/zzalfabeto.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zzalfabeto.sh):

```
$ zzalfabeto --militar ABC
Alpha
Bravo
Charlie
$ zzalfabeto --portugal ABC
Aveiro
Bragança
Coimbra
$
```

Só isso. É a linha de comando normal com o prompt `$ ` e o resultado logo a seguir, exatamente como aparece no terminal. E lembre de "fechar" o último resultado com um prompt vazio.

**Quer contribuir com as Funções ZZ?** Então crie um arquivo de testes para uma função que ainda não está sendo testada (coitadinha!). Use o script `missing.sh` para ver a lista de funções ainda não testadas:

```
$ ./missing.sh
zzajuda
zzaleatorio
zzbolsas
zzbraille
zzbrasileirao
zzcbn
zzchecamd5
zzcinemark15h
zzcineuci
...
$
```

Além de testar o uso normal, tente encontrar exemplos de uso peculiares (e até bizarros), que podem disparar bugs na função. Por exemplo: informar uma letra em vez de um número, informar datas inválidas, opções inválidas, coisas assim. E se a pobre função não aguentar seus testes e falhar, [abra um issue](https://github.com/funcoeszz/funcoeszz/issues/new)!

### Exemplo: criar testes para a zzfoo

Um exemplo rápido de como criar um arquivo de testes para a função fictícia `zzfoo`, direto pelo seu terminal:

```
prompt$ touch zzfoo.sh   # Crie o arquivo de testes (extensão .sh)
prompt$ PS1='$ '         # Mude seu prompt para o formato $
$ zzfoo                  # Use a função normalmente na linha de comando
Uso: zzfoo número
$ zzfoo 1
bar
$ zzfoo 2
bar
bar
$ zzfoo X
Número inválido 'X'
$
```

OK, já temos quatro testes, está bom pra começar. Agora selecione estas linhas com o mouse, copie e depois cole dentro do arquivo de testes `zzfoo.sh`. Salve o arquivo e rode os testes:

```
$ ./run zzfoo.sh
OK: 4 of 4 tests passed
$
```



Testes avançados
----------------

Há um formato especial para embutir "inline" o resultado do comando, ou seja, na mesma linha do próprio comando. Basta usar o marcador `#→` no final do comando e colocar o resultado logo após.

```
$ echo "foo"             #→ foo
$ echo $((10 + 2))       #→ 12
```

Isso é o equivalente a:

```
$ echo "foo"
foo
$ echo $((10 + 2))
12
$
```

A vantagem de usar esse formato é que fica mais fácil de enxergar o resultado quando há uma série de testes que retornem valores simples, de uma única linha:

```
$ zzarrumacidade "SP"         #→ São Paulo
$ zzarrumacidade "RJ"         #→ Rio de Janeiro
$ zzarrumacidade "BH"         #→ Belo Horizonte
$ zzarrumacidade "BSB"        #→ Brasília
$ zzarrumacidade "RIO"        #→ Rio de Janeiro
$ zzarrumacidade "SAMPA"      #→ São Paulo
$ zzarrumacidade "FLORIPA"    #→ Florianópolis
```

Agora, o bom mesmo, é que também é possível usar "opções" neste formato, para mudar a maneira como o teste será executado e avaliado.

```
$ head /etc/passwd            #→ --lines 10
```

Com `--lines`, o teste passará se o resultado do comando tiver exatamente o número de linhas informado. Use esta opção quando o texto do resultado for variável e imprevisível, porém o seu número de linhas é sempre constante. Exemplos: [zzlinuxnews.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zzlinuxnews.sh), [zzsecurity.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zzsecurity.sh).

```
$ tac /etc/passwd | tac       #→ --file /etc/passwd
```

Com `--file`, o teste passará se o resultado do comando for exatamente igual ao conteúdo do arquivo informado. Use testes desse tipo quando o resultado for um texto estruturado, ou em um formato específico, que seja mais cômodo guardar num arquivo externo. Exemplos: [zzcores.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zzcores.sh), [zztabuada.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zztabuada.sh), [zzunicode2ascii.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zzunicode2ascii.sh).

```
$ echo $((2 + 10))            #→ --regex ^\d+$
```

Com `--regex`, o teste passará se a(s) linha(s) do resultado casar com a [expressão regular](http://aurelio.net/regex/) informada (padrão super-poderoso `Perl`). Use testes desse tipo quando o resultado for variável, mas com um padrão conhecido, que você pode casar com uma regex. Exemplos: [zzdado.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zzdado.sh), [zzipinternet.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zzipinternet.sh), [zzsenha.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zzsenha.sh).

```
$ pwd                         #→ --eval echo $PWD
```

Com `--eval`, o teste passará se o resultado do comando for exatamente igual ao resultado do comando informado. É útil principalmente para expandir o valor de variáveis com guardam o resultado, ou parte dele. Exemplos: [zzmaiusculas.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zzmaiusculas.sh), [zzdata.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zzdata.sh), [zzgravatar.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zzgravatar.sh).


Para ver rapidamente os exemplos já utilizados destas opções, use o grep nos arquivos de testes atuais:

```
grep -- --regex testador/zz*.sh
```


Dicas
-----

Se além do resultado, você também quiser testar o código de retorno (status code) de um comando, basta colocar um `echo $?` no final:

```
$ grep ^root /etc/passwd; echo $?
root:*:0:0:System Administrator:/var/root:/bin/sh
0
$
```

Esta tática é usada dezenas de vezes em [zztool.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zztool.sh). Se quiser testar somente o código, ignorando o resultado, basta silenciar o comando:

```
$ grep ^root /etc/passwd > /dev/null; echo $?
0
$
```

O mesmo teste, no formato inline, fica:

```
$ grep ^root /etc/passwd > /dev/null; echo $?   #→ 0
```

Pode usar variáveis à vontade, filtrar o resultado com outros comandos, enfim, usar a linha de comando em todo seu potencial.

```
$ isso='root'
$ aquilo='RAPADURA'
$ grep ^root /etc/passwd | sed "s/$isso/$aquilo/" | cut -d : -f 1-5 | tr : '\t'
RAPADURA	*	0	0	System Administrator
$
```

Se precisar de arquivos temporários, basta criá-los. O padrão do testador é usar os nomes _tmp1, _tmp2, ... Lembre-se de removê-los no final dos testes. Veja um exemplo nos testes da zzunicode2ascii:

```
$ cut -f 1 zzunicode2ascii.in.txt > _tmp1
$ cut -f 2 zzunicode2ascii.in.txt > _tmp2
$ zzunicode2ascii _tmp1   #→ --file _tmp2
$ rm -f _tmp[12]
```


clitest
-------

O script `run` é apenas um wrapper pequeno, para facilitar a chamada do testador de verdade, que faz todo o trabalho pesado: `clitest` (*command line tester*).

O `clitest` é um projeto separado, também criado pelo Aurelio Jargas e também escrito em shell script. Para mais informações sobre o funcionamento do testador, acesse:

* <https://github.com/aureliojargas/clitest>



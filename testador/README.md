Testador das Funções ZZ
=======================

É preciso garantir que todas as funções estejam sempre funcionando corretamente. Esta não é uma tarefa fácil, já que são mais de 150 funções ao todo, e muitas delas dependem de informações obtidas em websites, que estão em constante mudança.

O testador automático das Funções ZZ testa o funcionamento de cada função e avisa caso algo esteja errado. Já estão cadastrados mais de 3.000 testes!



Como usar
---------

Todos os arquivos de testes são identificados pelo nome da função e a extensão `.sh`, ou seja, `zz*.sh`. O script chamado `run` é quem executa os testes, basta informar qual arquivo você quer testar:

```
$ ./run zztac.sh
OK! All 3 tests have passed.
$
```

Se tudo estiver funcionando, todos os testes serão bem sucedidos e aparecerá essa mensagem de OK. Caso o testador encontre algum erro, mostrará uma mensagem de falha:

```
$ ./run zzarrumacidade.sh
--------------------------------------------------
[FAILED #12] zzarrumacidade "SAMPA"
@@ -1 +1 @@
-São Paulo
+S?o Paulo
--------------------------------------------------

FAIL: 1 of 66 tests have failed.
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

==================================================
 58 ok            zzbyte.sh
  6 ok            zzcidade.sh
 83 ok            zzhora.sh
 73 ok            zzseq.sh
  3 ok            zztac.sh
==================================================

YOU WIN! PERFECT! All 223 tests have passed.
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

Se aparecer algum erro, por favor [abra um issue](https://github.com/aureliojargas/funcoeszz/issues/new) e cole nele o resultado do testador. Também informe qual a versão do seu sistema operacional e qualquer informação adicional que julgar útil para resolvermos o problema.

Se você manja de shell script, que tal **você mesmo** arregaçar as mangas e arrumar a função? O [código das funções](https://github.com/aureliojargas/funcoeszz/tree/master/zz) é bem amigável: é alinhado e comentado. Experimente, será divertido! Veja [as  instruções](https://github.com/aureliojargas/funcoeszz/blob/master/README.md), ou fale com o [@oreio](https://twitter.com/oreio).



Para adicionar um teste novo
----------------------------

Você não precisa ser programador para adicionar um teste novo. O arquivo de testes é bem simples: é uma cópia literal da própria linha de comando! Veja exemplos de arquivos de testes:

[/testador/zzvira.sh](https://github.com/aureliojargas/funcoeszz/tree/master/testador/zzvira.sh):

```
$ zzvira 'Inverte tudo'
odut etrevnI
$ zzvira -X 'De pernas pro ar'
ɹɐ oɹd sɐuɹǝd ǝp
$
```

[/testador/zzalfabeto.sh](https://github.com/aureliojargas/funcoeszz/tree/master/testador/zzalfabeto.sh):

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

Além de testar o uso normal, tente encontrar exemplos de uso peculiares (e até bizarros), que podem disparar bugs na função. Por exemplo: informar uma letra em vez de um número, informar datas inválidas, opções inválidas, coisas assim. E se a pobre função não aguentar seus testes e falhar, [abra um issue](https://github.com/aureliojargas/funcoeszz/issues/new)!

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
OK! All 4 tests have passed.
$
```







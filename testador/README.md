Testador das Funções ZZ
=======================

É preciso garantir que todas as funções estejam sempre funcionando corretamente. Esta não é uma tarefa fácil, já que são mais de 150 funções ao todo, e muitas delas dependem de informações obtidas em websites, que estão em constante mudança.

O testador automático das Funções ZZ testa o funcionamento de cada função e avisa caso algo esteja errado.



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


Um teste falhou, o que faço agora?
----------------------------------

Se aparecer algum erro, por favor [abra um ticket](https://github.com/aureliojargas/funcoeszz/issues/new) e cole nele o resultado do testador. Também informe qual a versão do seu sistema operacional e qualquer informação adicional que julgar útil para resolvermos o problema.

Se você manja de shell script, que tal **você mesmo** arregaçar as mangas e arrumar a função? O código das funções é bem alinhado e comentado, elas estão na pasta [../zz/](https://github.com/aureliojargas/funcoeszz/tree/master/zz). Experimente, será divertido! Se precisar de instruções, [é aqui](https://github.com/aureliojargas/funcoeszz/blob/master/README.md).



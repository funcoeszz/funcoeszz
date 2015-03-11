# Contribuições

Que tal ajudar a melhorar as Funções ZZ?

## Avisar sobre algum problema

Se uma função não está funcionando como deveria, avise-nos!

* [Abrir um ticket](https://github.com/funcoeszz/funcoeszz/issues/new) aqui no GitHub para explicar o problema.
* Quanto mais detalhes você conseguir nos informar, melhor!
* Qual o seu sistema: Ubuntu, Debian, Mac, Cygwin, …?
* Cole a mensagem de erro, ou um exemplo de execução incorreta da função em sua máquina.

## Corrigir um problema (patch)

Se você sabe programar, patches são muito bem-vindos.
O código das funções é bem amigável: é alinhado e comentado.
Experimente, será divertido!

* [Faça um fork](https://help.github.com/articles/fork-a-repo/) do repositório
* Corrija a função
* Confira/atualize [os testes](https://github.com/funcoeszz/funcoeszz/tree/master/testador) da função
* Confira se seu código segue o [Coding Style](https://github.com/funcoeszz/funcoeszz/wiki/Coding-Style)
* Envie-nos um [Pull Request](https://help.github.com/articles/using-pull-requests/)

## Criar testes novos

Você não precisa ser programador para adicionar um teste novo.

O arquivo de testes é bem simples: é uma cópia literal da própria linha de comando! Veja um exemplo:

[/testador/zzvira.sh](https://github.com/funcoeszz/funcoeszz/tree/master/testador/zzvira.sh):

```
$ zzvira 'Inverte tudo'
odut etrevnI
$ zzvira -X 'De pernas pro ar'
ɹɐ oɹd sɐuɹǝd ǝp
$
```

Simples, não? Basta criar um arquivo novo ou adicionar testes novos em um arquivo já existente, eles ficam na [pasta testador](https://github.com/funcoeszz/funcoeszz/tree/master/testador).
 Veja instruções completas no arquivo [testador/README.md](https://github.com/funcoeszz/funcoeszz/blob/master/testador/README.md).

## Criar uma função nova

* https://github.com/funcoeszz/funcoeszz/wiki/Criar-funcao-nova

## Entre em contato

* Na dúvida, [abra um ticket](https://github.com/funcoeszz/funcoeszz/issues/new) e vamos conversar!
* Também estamos no twitter: [@Funcoes_ZZ](https://twitter.com/Funcoes_ZZ).


TODO-now

## branch: core-sempre-grava-on-off

isolar arvore suja atual em uma PR, só pra sempre gerar os arquivos .on e .off, mesmo na versão tudo em um.
- adaptar zzzz
- fazer vários testes que fazem diff direto nos arquivos .on e .off
  (adaptar os testes atuais da branch zzzz-listar-on-off-all)

## ZZOFF só vale pro core

teste pra mostra que isso é inócuo atualmente
    ZZOFF=zzdata zzdata -h

Um problema do zzzz --listar novo, usando ZZOFF é o seguinte:
    ZZOFF="zzdata" zzzz
isso antigamente era inócuo, pois a função já carregada na shell só levava em conta  `$ZZTMP.off`, então o que vale era o conteúdo da ZZOFF no momento em que o core foi executado pela última vez.
    ZZOFF=zzdata zzdata -h
note que isso funciona, pois a zzdata já está carregada na shell atual e não leva em conta a ZZOFF recém-setada. Neste caso, listar a `zzdata` na saída da `zzzz` como uma função desativada é mentira.
esse conceito atual da .on e .off é interessante no sentido de trazer a mesma informação pra todos os modos de execução das ZZ (via `source`, `./te1.sh` e `funcoeszz-git`), sendo que tudo é atualizado cada vez que se roda o core, é ele quem manda. Na minha proposta atual a ZZOFF manda mais, aí ficou meio esquisito. Procurar tentar manter isso de o core gerar a informacao oficial. Talvez ter o `.funcoeszz` no home ainda é a melhor opção. VIde `help-ng.txt`. Reforçando: o que vale é o valor da ZZOFF **na hora de chamar o core**.

## Makefile

makefile ou shell script pra rodar localmente o que acontece no CI
- botar shellcheck tb

## Outros

branch alternativa a zzzz-listar-on-off-all, porém usando os arquivos .on e .off
- RESOLVIDO: não tem .on e .off na versão tudo em um (precisa ZZDIR pra gerar eles)

rationale: é o core quem decide on e off, não ZZOFF/ZZON.

Um problema do zzzz --listar novo, usando ZZOFF é o seguinte:
    ZZOFF="zzdata" zzzz
isso antigamente era inócuo, pois a função já carregada na shell só levava em conta  `$ZZTMP.off`, então o que vale era o conteúdo da ZZOFF no momento em que o core foi executado pela última vez.
    ZZOFF=zzdata zzdata -h
note que isso funciona, pois a zzdata já está carregada na shell atual e não leva em conta a ZZOFF recém-setada. Neste caso, listar a `zzdata` na saída da `zzzz` como uma função desativada é mentira.
esse conceito atual da .on e .off é interessante no sentido de trazer a mesma informação pra todos os modos de execução das ZZ (via `source`, `./te1.sh` e `funcoeszz-git`), sendo que tudo é atualizado cada vez que se roda o core, é ele quem manda. Na minha proposta atual a ZZOFF manda mais, aí ficou meio esquisito. Procurar tentar manter isso de o core gerar a informacao oficial. Talvez ter o `.funcoeszz` no home ainda é a melhor opção. VIde `help-ng.txt`. Reforçando: o que vale é o valor da ZZOFF **na hora de chamar o core**.

Outro problema da zzzz --listar é que não posso usar ela no core (deveria!). Fica valendo somente pra zzzz sem argumentos e pra eventual make-release.sh se for pra tirar do core.




o caso de uso que quebra qualquer solução simples que experimento é o de o cara fazer um source funcoeszz e remover/mover o arquivo funcoeszz. Uma vez carregadas na shell, o arquivo original não é mais necessário, mas dependemos dele (ou desse arquivo extra de ajudas) pra poder mostrar o help. Se não precisasse suportar esse caso de uso, e o ZZPATH fosse sempre conhecido, poderia sempre extrair a ajuda dali, sem arquivo extra nenhum.

ZZPATH só importa pra quem usa o tudo-em-um e inclui as funções na shell atual com o source. Pra quem chama funcoeszz diretamente não precisa. Quem usa a versão git, hoje já deve obrigatoriamente ter ZZDIR setado pra funcionar. Porém, se adicionarmos o lance dos symlinks, ZZDIR deixa de ser um requisito.



chamou o comando `funcoeszz`:
- pode ser o tudo-em-um ou o core
- tudo-em-um poderia definir alguma variável especial pra se identificar como tal

- se for o core
  - ZZPATH não serve pra nada
  - *deve* ter ZZDIR setado, senão não acha as funções
    - dá pra tentar inferir pelo path do core + zz
- se for tudo-em-um
  - ZZDIR não serve pra nada
  - ZZPATH é necessário pra extrair a ajuda


- se não carregou nada, é porque não é


ideia: ao gerar o --tudo-em-um, embutir os textos de ajuda de alguma forma nesse arquivo, eliminando a necessidade de guardar num txt ou extrair dele depois. Aí podia criar a zzajuda bombada com um case gigante (escape hell, não, usa heredoc com aspas simples).

o rationale é: o modo normal das funções é o com ZZDIR. o tudo-em-um é um xunxo gerado por um script, e pode ter mágicas exclusivas.
- obter ajuda
- obter a lista de funcoes ligadas
as funções normais em zz/* não deveriam ter nenhum código pra lidar com o te1.

ZZTUDOEMUM=1

## listar funcoes ligadas

ls ZZDIR
te1: set (pode ter falso positivo, mas podem ser eliminados comparando se há zzajuda pra cada funcao listada) ou algo hardcoded na geracao do tudo em um (ZZON?)

## Como descobrir ZZDIR

if ZZDIR, done
else if $0 == funcoeszz, ZZDIR=dirname $0/zz
if $0 == zz* and $0 is symlink, ZZDIR=symlink.resolve()/zz

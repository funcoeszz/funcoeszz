# Testes para o script principal `funcoeszz`

Para executar estes testes, faça `./run funcoeszz.md`

> Note que a variável `$zz_root` já vem definida com o path absoluto para o diretório raiz do clone local do repositório das Funções ZZ. Isso é feito via `clitest --pre-flight` no script `./run`.

## Chamado com -h, --help

Mostra o texto de ajuda.

```console
$ $zz_root/funcoeszz --help

Uso: funcoeszz <função> [<parâmetros>]

Lista de funções:
    funcoeszz zzzz
    funcoeszz zzajuda --lista

Ajuda:
    funcoeszz zzajuda
    funcoeszz zzcores -h
    funcoeszz zzcalcula -h

Instalação:
    funcoeszz zzzz --bashrc
    source ~/.bashrc
    zz<TAB><TAB>

Saiba mais:
    http://funcoeszz.net

$
```

## Chamado com -v, --version

Mostra a versão das Funções ZZ.

```console
$ $zz_root/funcoeszz --version | sed 's/\(ZZ v\).*/\1XXX/'
Funções ZZ vXXX
$
```

> O comando `sed` está trocando a versão por XXX para evitar ter que atualizar este teste toda vez que se atualiza a versão.

## Chamado com uma opção inválida

```console
$ $zz_root/funcoeszz -X
Opção inválida '-X' (tente --help)
$
```

## Chamado com qualquer outro argumento

Neste caso, este argumento é considerado um nome de função ZZ, e essa função será chamada. Note que é possível informar o nome da função com ou sem o prefixo `zz`:

```console
$ $zz_root/funcoeszz zzcalcula 10+5
15
$ $zz_root/funcoeszz calcula 10+5
15
$
```

Se não for encontrada uma função com o nome informado, um erro é mostrado:

```console
$ $zz_root/funcoeszz zz404
Função inexistente 'zz404' (tente --help)
$ $zz_root/funcoeszz 404
Função inexistente 'zz404' (tente --help)
$
```

## Sem argumentos

Chamado sem argumentos, nada é mostrado na saída. Porém, todas as funções são carregadas e os textos de ajuda são processados. Não serve pra nada fazer isso :)

```console
$ $zz_root/funcoeszz
$
```

## Sem argumentos, porém usando `source`

Ao usar o comando `source` do Bash, todas as Funções ZZ são carregadas na shell atual, e podem então serem chamadas diretamente pelo nome.

```console
$ ZZDIR=$zz_root/zz source $zz_root/funcoeszz
$ zzcalcula 10+5
15
$
```

> Note que a variável `ZZDIR` é necessária neste caso, caso contrário o script principal `funcoeszz` não sabe onde encontrar os arquivos com as funções.

## ZZOFF para desativar funções

A variável `ZZOFF` pode ser definida com uma lista de nomes de Funções ZZ (separadas por espaços em branco). As funções dessa lista serão ignoradas durante o carregamento de todas as funções, é como se não existissem.

Este teste verifica se a `ZZOFF` está funcionando quando chama-se o script principal normalmente, como um executável:

```console
$ unset zzcalcula
$ ZZOFF=zznaoexiste $zz_root/funcoeszz zzcalcula 10+5
15
$ ZZOFF=zzcalcula $zz_root/funcoeszz zzcalcula 10+5
Função inexistente 'zzcalcula' (tente --help)
$
```

Este teste é para a chamada normal do script principal via `source`:

```console
$ unset zzcalcula zzmaiusculas
$ ZZOFF=zzcalcula ZZDIR=$zz_root/zz source $zz_root/funcoeszz
$ zzcalcula 10+5 2>&1 | sed 's/.*zzcalcula/zzcalcula/'
zzcalcula: command not found
$ zzmaiusculas funciona
FUNCIONA
$
```

## Opção --tudo-em-um

Quando se usa a opção `--tudo-em-um`, uma cópia do arquivo principal `funcoeszz` é gerada, porém com todas as funções das pasta `zz` embutidas dentro dele. Este arquivo gerado é o que usamos quando queremos lançar uma versão nova das Funções ZZ.

Gerar o arquivo é fácil, basta usar a opção e mais nada:

```console
$ $zz_root/funcoeszz --tudo-em-um > tudo-em-um
$
```

Será que todas todas as funções disponíveis foram de fato inseridas no arquivo gerado?

```console
$ ls -1 $zz_root/zz/ | sed 's/\.sh$//' | sort > originais.txt
$ grep '^zz.* ()$' tudo-em-um | cut -d ' ' -f 1 | sort > incluidas.txt
$ diff originais.txt incluidas.txt
$
```

Será que a ajuda está funcionando?

```console
$ bash tudo-em-um zzcalcula -h | grep '^Uso:' | wc -l
1
$
```

Ao gerar a versão tudo-em-um, se existir a variável `ZZOFF`, ela deve ser respeitada: as funções listadas ali não devem fazer parte do arquivo gerado.

```console
$ ZZOFF="zzcalcula zzxml" $zz_root/funcoeszz --tudo-em-um > tudo-em-um-off
$ grep '^zz.* ()$' tudo-em-um-off | cut -d ' ' -f 1 | sort > incluidas.txt
$ diff originais.txt incluidas.txt | grep '^<'
< zzcalcula
< zzxml
$
```

Remove todos os arquivos criados pelos testes:

```console
$ rm tudo-em-um tudo-em-um-off originais.txt incluidas.txt
$
```

## Testes da geração dos arquivos `.on` e `.off`

Toda vez que o core é chamado, ele computa a lista de todas as funções disponíveis e a lista das funções possivelmente desligadas pelo usuário via variável `ZZOFF`. É com base nessas listas que o core decide se deve carregar ou não cada função, bem como gerar seu texto de ajuda.

São gerados dois arquivos:

- `$ZZTMP.on` - Lista de todas as funções ligadas
- `$ZZTMP.off` - Lista de todas as funções desligadas

> IMPORTANTE: Na versão tudo-em-um, estes arquivos são criados, porém estão sempre vazios. Isso acontece porque a variável `ZZDIR` é requisito para a obtenção da lista de funções disponíveis, e essa variável não existe na versão tudo-em-um.

Os testes seguintes chamam o core de maneiras diferentes, com e sem `ZZOFF`, para assegurar-se de que estes arquivos estão sendo gerados como esperado.

> Note: São exatamente os mesmos testes em cada subtópico, a única diferença é chamar {core,tudo-em-um} via {direta,bash,source}.

### Setup inicial

Para que os testes não alterem o conteúdo dos arquivos `.on` e `.off` já existentes, todos eles serão executados em uma pasta `ZZTMPDIR` nova, exclusiva dos testes.

```console
$ ZZTMP_ORIG="$ZZTMP"
$ ZZTMPDIR_ORIG="$ZZTMPDIR"
$ my_tmp="$zz_root/testador/tmp.$$"
$ mkdir "$my_tmp"
$ export ZZTMP="$my_tmp/zz"
$ export ZZTMPDIR="$my_tmp"
$
```

Gera a versão tudo-em-um com todas as funções, para ser usada em alguns testes:

```console
$ ZZOFF='' $zz_root/funcoeszz --tudo-em-um > "$my_tmp/tudo-em-um.sh"
$ chmod +x "$my_tmp/tudo-em-um.sh"
$
```

Obtendo a lista completa de funções na pasta zz. Note que não é feito um `sort` nessa lista, pois no core também é usada a ordem original retornada pelo `ls`.

```console
$ ls -1 $zz_root/zz/ | sed 's/\.sh$//' > todas.txt
$
```

### Chamando o core diretamente

Quando `ZZOFF` não está definida:

- O arquivo `.on` lista todas as funções disponíveis
- O arquivo `.off` é vazio

```console
$ ZZOFF='' ZZDIR=$zz_root/zz $zz_root/funcoeszz
$ diff todas.txt $ZZTMP.on
$ cat $ZZTMP.off
$ rm $ZZTMP.{on,off}
$
```

Quando `ZZOFF` está definida:

- O arquivo `.on` não lista as funções desligadas
- O arquivo `.off` lista o conteúdo de `ZZOFF`, porém higienizado:
  - em ordem alfabética
  - sem linhas duplicadas
  - sempre com o prefixo zz
  - sem funções não existentes

```console
$ ZZOFF='zzxml cores data data 404' ZZDIR=$zz_root/zz $zz_root/funcoeszz
$ diff todas.txt $ZZTMP.on | grep '^[<>]'
< zzcores
< zzdata
< zzxml
$ cat $ZZTMP.off
zzcores
zzdata
zzxml
$ rm $ZZTMP.{on,off}
$
```

### Chamando o core como argumento pro bash

Sem `ZZOFF`:

```console
$ ZZOFF='' ZZDIR=$zz_root/zz bash $zz_root/funcoeszz
$ diff todas.txt $ZZTMP.on
$ cat $ZZTMP.off
$ rm $ZZTMP.{on,off}
$
```

Com `ZZOFF`:

```console
$ ZZOFF='zzxml cores data data 404' ZZDIR=$zz_root/zz bash $zz_root/funcoeszz
$ diff todas.txt $ZZTMP.on | grep '^[<>]'
< zzcores
< zzdata
< zzxml
$ cat $ZZTMP.off
zzcores
zzdata
zzxml
$ rm $ZZTMP.{on,off}
$
```

### Chamando o core com o comando `source`

Sem `ZZOFF`:

```console
$ ZZOFF='' ZZDIR=$zz_root/zz source $zz_root/funcoeszz
$ diff todas.txt $ZZTMP.on
$ cat $ZZTMP.off
$ rm $ZZTMP.{on,off}
$
```

Com `ZZOFF`:

```console
$ ZZOFF='zzxml cores data data 404' ZZDIR=$zz_root/zz source $zz_root/funcoeszz
$ diff todas.txt $ZZTMP.on | grep '^[<>]' | head
< zzcores
< zzdata
< zzxml
$ cat $ZZTMP.off
zzcores
zzdata
zzxml
$ rm $ZZTMP.{on,off}
$
```

### Chamando o tudo-em-um diretamente

Agora na versão tudo-em-um, é diferente. Ela não usa os arquivos `.on` e `.off`, e tudo o que faz é **sempre gerá-los com conteúdo vazio**.

A versão tudo-em-um possui seu próprio mecanismo para desligar funções baseadas na `ZZOFF`, e isso já foi testado previamente aqui neste arquivo, no tópico "Opção --tudo-em-um".

> Nota: Em todos os testes seguintes da tudo-em-um, a variável `ZZDIR` é zerada, para evitar influência dessa variável nos testes, caso o usuário já a tenha definida e exportada em sua shell atual.

Sem `ZZOFF`:

```console
$ ZZOFF='' ZZDIR='' "$my_tmp/tudo-em-um.sh"
$ cat $ZZTMP.on
$ cat $ZZTMP.off
$ rm $ZZTMP.{on,off}
$
```

Com `ZZOFF`:

```console
$ ZZOFF='zzxml cores data data 404' ZZDIR='' "$my_tmp/tudo-em-um.sh"
$ cat $ZZTMP.on
$ cat $ZZTMP.off
$ rm $ZZTMP.{on,off}
$
```

### Chamando o tudo-em-um como argumento pro bash

Sem `ZZOFF`:

```console
$ ZZOFF='' ZZDIR='' bash "$my_tmp/tudo-em-um.sh"
$ cat $ZZTMP.on
$ cat $ZZTMP.off
$ rm $ZZTMP.{on,off}
$
```

Com `ZZOFF`:

```console
$ ZZOFF='zzxml cores data data 404' ZZDIR='' bash "$my_tmp/tudo-em-um.sh"
$ cat $ZZTMP.on
$ cat $ZZTMP.off
$ rm $ZZTMP.{on,off}
$
```

### Chamando o tudo-em-um com o comando `source`

> Note que é obrigatório definir a variável `ZZPATH` quando se chama a versão tudo-em-um com o comando `source`, para ela saber de sua própria localização.

Sem `ZZOFF`:

```console
$ echo "ZZOFF='' ZZDIR='' ZZPATH='$my_tmp/tudo-em-um.sh' source '$my_tmp/tudo-em-um.sh'" > foo
$ source foo
$ cat $ZZTMP.on
$ cat $ZZTMP.off
$ rm $ZZTMP.{on,off}
$
```

Com `ZZOFF`:

```console
$ ZZOFF='zzxml cores data data 404' ZZDIR='' ZZPATH="$my_tmp/tudo-em-um.sh" source "$my_tmp/tudo-em-um.sh"
$ cat $ZZTMP.on
$ cat $ZZTMP.off
$ rm $ZZTMP.{on,off}
$
```

### Faxina

```console
$ ZZTMP="$ZZTMP_ORIG"
$ ZZTMPDIR="$ZZTMPDIR_ORIG"
$ unset ZZTMP_ORIG
$ unset ZZTMPDIR_ORIG
$ rm todas.txt
$ rm "$my_tmp"/tudo-em-um.sh
$ rm "$my_tmp"/zz*
$ rmdir "$my_tmp"
$
```

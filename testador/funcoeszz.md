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

A variável `$ZZOFF` pode ser definida com uma lista de nomes de Funções ZZ (separadas por espaços em branco). As funções dessa lista serão ignoradas durante o carregamento de todas as funções, é como se não existissem.

Este teste verifica se a `$ZZOFF` está funcionando quando chama-se o script principal normalmente, como um executável:

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

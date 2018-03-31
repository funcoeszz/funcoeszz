## Funções ZZ

Funções ZZ é uma coletânea com mais de 180 miniaplicativos de utilidades diversas, prontos para serem usados na linha de comando de sistemas tipo UNIX (Linux, BSD, Cygwin, Mac OS X, entre outros).

- Website: http://funcoeszz.net
- GitHub: https://github.com/funcoeszz/funcoeszz
- Grupo: http://br.groups.yahoo.com/group/zztabtab/
- Twitter: https://twitter.com/Funcoes_ZZ


## Lista de colaboradores

https://github.com/funcoeszz/funcoeszz/contributors


## Como contribuir

Forka nóis e pulla! :)

https://github.com/funcoeszz/funcoeszz/blob/master/CONTRIBUTING.md


## Instalação das Funções ZZ - Versão oficial

A versão oficial das Funções ZZ é [gerada à partir deste repositório](https://github.com/funcoeszz/funcoeszz/tree/master/release) e é lançada de tempos em tempos. Ela traz todas as funções dentro de um único arquivo, e é rápida de carregar em sua shell.

Para instalá-la, basta baixar o arquivão das funções e rodar o comando de instalação. As instruções estão lá no site:

- http://funcoeszz.net/download/


## Instalação das Funções ZZ - Versão beta

A versão beta das Funções ZZ roda direto deste repositório do GitHub, com cada função isolada em seu próprio arquivo, dentro da [pasta zz](https://github.com/funcoeszz/funcoeszz/tree/master/zz). É o código mais recente das funções, porém tem um processo de instalação e configuração mais manual, e por serem centenas de arquivos separados, a carga inicial em sua shell demorará mais do que a versão oficial. 

Baixe o repositório para sua máquina:

    $ git clone https://github.com/funcoeszz/funcoeszz.git ~/funcoeszz
    $ cd ~/funcoeszz

Rode o comando seguinte para adicionar o carregamento das Funções ZZ no final de seu `~/.bashrc`:

    $ ./funcoeszz zzzz --bashrc
    Feito!
    As Funções ZZ foram instaladas no /Users/aurelio/.bashrc

Confira que as linhas foram adicionadas, e perceba que o PATH atual do script fica na variável `$ZZPATH`.

    $ tail -4 ~/.bashrc
    # Instalacao das Funcoes ZZ (www.funcoeszz.net)
    export ZZOFF=""  # desligue funcoes indesejadas
    export ZZPATH="$HOME/funcoeszz/funcoeszz"  # script
    export ZZDIR="$HOME/funcoeszz/zz"    # pasta zz/
    source "$ZZPATH"

Confira o arquivo `~/.bashrc`( ou equivalente ), e edite conforme esse modelo adequando as suas configurações se for necessário, de preferência mantendo essa disposição.

Agora sim, você pode usar as Funções ZZ em toda a sua glória. Abra um novo terminal e divirta-se!

    $ zzcalcula 10+5
    15

    $ zzbissexto 2016
    2016 é bissexto

    $ zzmaiusculas tá funcionando
    TÁ FUNCIONANDO

Quando quiser atualizar os arquivos para a versão mais recente, basta um `git pull`.

## Execução via Docker

A imagem oficial das Funções ZZ é a [funcoeszz/zz](https://hub.docker.com/r/funcoeszz/zz/).

Primeiro, baixe-a para a sua máquina:

```
docker pull funcoeszz/zz
```

Agora basta rodar o contêiner e informar qual função você quer usar, junto com seus parâmetros:

```console
$ docker run --rm funcoeszz/zz horariodeverao
16/10/2016
19/02/2017

$ docker run --rm funcoeszz/zz senha 30
pipj74x30fEbzbx0rcPEwukL2WKjCA

$ docker run --rm funcoeszz/zz maiusculas tá funcionando
TÁ FUNCIONANDO
```

**Desenvolvedor:** Para instruções sobre como construir esta imagem, ou como rodar outro tipo de comandos dentro do contêiner, [veja esta wiki](https://github.com/funcoeszz/funcoeszz/wiki/Docker)

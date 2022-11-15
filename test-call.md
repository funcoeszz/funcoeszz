## caso 1: tudo-em-um

.bashrc:
source $HOME/funcoeszz

vai tar tudo pronto na shell, como funções
inclusive help sem arquivo temporário

alternativamente, pode chamar `funcoeszz zzcores` ou `bash funcoeszz zzcores`

> Esse é o comportamente atual e é o release.

## caso 2: zzs no PATH

> pra quem usa a versão github
> pra quem não usa bash como shell (zzTABTAB funciona)

.bashrc:
export PATH="$HOME/zz:$PATH"

chama sempre `zzcores` direto, sem `source`
fazer `source` de uma única função não tem sentido, tem as dependências

## caso 2 otimizado

mesmo que o NixOS faz, al chamara qualquer zz*, carrega todas as função e daí executa o comando.

pode fazer igual ao grep/fgrep/egrep, se usar symlink pro `funcoeszz` ele assume outra identidade.


Setup

    $ echo '#!/bin/bash' > ~/bin/x
    $ echo 'echo "\$0:$0"' >> ~/bin/x
    $ echo 'echo "\$@:$@"' >> ~/bin/x
    $ echo 'echo "which x : $(which x)"' >> ~/bin/x
    $ echo 'echo "which \$0: $(which $0)"' >> ~/bin/x
    $ chmod +x ~/bin/x

Calling via PATH or absolute (igual)

    $ x -h
    $0:/Users/oreio/bin/x
    $@:-h
    which x : /Users/oreio/bin/x
    which $0: /Users/oreio/bin/x
    $ ~/bin/x -h
    $0:/Users/oreio/bin/x
    $@:-h
    which x : /Users/oreio/bin/x
    which $0: /Users/oreio/bin/x

Calling via PATH or absolute - bash (muda $0)

    $ bash x -h
    $0:x
    $@:-h
    which x : /Users/oreio/bin/x
    which $0: /Users/oreio/bin/x
    $ bash ~/bin/x -h
    $0:/Users/oreio/bin/x
    $@:-h
    which x : /Users/oreio/bin/x
    which $0: /Users/oreio/bin/x

Calling via PATH, absolute or ./ - source (same)

- Note that `$0==bash` in the command line
- and `$0==script_name.sh` when `source` command is inside a script

    $ source x -h
    $0:/Users/oreio/bin/clitest
    $@:-h
    which x : /Users/oreio/bin/x
    which $0: /Users/oreio/bin/clitest
    $ source ~/bin/x -h
    $0:/Users/oreio/bin/clitest
    $@:-h
    which x : /Users/oreio/bin/x
    which $0: /Users/oreio/bin/clitest
    $ cd ~/bin; source ./x -h; cd - >/dev/null
    $0:/Users/oreio/bin/clitest
    $@:-h
    which x : /Users/oreio/bin/x
    which $0: /Users/oreio/bin/clitest

Calling via ./

    $ cd ~/bin
    $ ./x -h
    $0:./x
    $@:-h
    which x : /Users/oreio/bin/x
    which $0: ./x
    $ bash ./x -h
    $0:./x
    $@:-h
    which x : /Users/oreio/bin/x
    which $0: ./x
    $ cd - > /dev/null

x is a function

    $ x2() { printf '%s\n%s\n%s\n%s\n' "\$0:$0" "\$@:$@" "which x2: $(which x2)" "which \$0: $(which x2)"; }
    $ x2
    $0:/Users/oreio/bin/clitest
    $@:
    which x2:
    which $0:

Try 2

## $0

- When called via `source`, `$0==clitest` !!!
- Note that `$0==bash` in the real command line
- and `$0==script_name.sh` when `source` command is inside a script

    $ echo 'printf %24s%s\\\\n "" "$0"' > ~/bin/x
    $ x -h
                            /Users/oreio/bin/x
    $ ~/bin/x -h
                            /Users/oreio/bin/x
    $ bash x -h
                            x
    $ bash ~/bin/x -h
                            /Users/oreio/bin/x
    $ source x -h
                            /Users/oreio/bin/clitest
    $ source ~/bin/x -h
                            /Users/oreio/bin/clitest
    $ cd ~/bin
    $ ./x -h
                            ./x
    $ bash ./x -h
                            ./x
    $ source ./x -h
                            /Users/oreio/bin/clitest
    $ cd - > /dev/null

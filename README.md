## Funções ZZ

Funções ZZ é uma coletânea com mais de 130 miniaplicativos de utilidades diversas, prontos para serem usados na linha de comando de sistemas tipo UNIX (Linux, BSD, Cygwin, Mac OS X, entre outros).

- Website: [http://funcoeszz.net](http://funcoeszz.net)
- GitHub: [https://github.com/funcoeszz/funcoeszz](https://github.com/funcoeszz/funcoeszz)
- Grupo: [http://br.groups.yahoo.com/group/zztabtab/](http://br.groups.yahoo.com/group/zztabtab/)


## Lista de colaboradores

https://github.com/funcoeszz/funcoeszz/contributors


## Como contribuir

Forka nóis e pulla! :)

- [Fork, Branch, Track, Squash and Pull Request](http://gun.io/blog/how-to-github-fork-branch-and-pull-request/)
- [Send pull requests](http://help.github.com/send-pull-requests/)

Mas antes, por favor dê uma lida nas [páginas do Wiki](https://github.com/funcoeszz/funcoeszz/wiki/_pages), especialmente a [Coding Style](https://github.com/funcoeszz/funcoeszz/wiki/Coding-Style).

Se precisar de ajuda com o git, leia:

- [Guia pra quem manja de SVN](https://git.wiki.kernel.org/index.php/GitSvnCrashCourse)
- [Git Reference](http://gitref.org) — Guia rápido, com exemplos
- [The Git Parable](http://tom.preston-werner.com/2009/05/19/the-git-parable.html) — Entenda a filosofia por trás do git


## Instalação das Funções ZZ (versão de desenvolvimento)

Baixe o repositório para sua máquina:

    $ git clone git://github.com/funcoeszz/funcoeszz.git ~/funcoeszz
    $ cd ~/funcoeszz

Rode o comando seguinte para adicionar o carregamento das Funções ZZ no final de seu `~/.bashrc`:

    $ ./funcoeszz zzzz --bashrc
    Feito!
    As Funções ZZ foram instaladas no /Users/aurelio/.bashrc

Confira que as linhas foram adicionadas, e perceba que o PATH atual do script fica na variável `$ZZPATH`.

    $ tail -4 ~/.bashrc
    # Instalacao das Funcoes ZZ (www.funcoeszz.net)
    export ZZOFF=""  # desligue funcoes indesejadas
    export ZZPATH="/Users/aurelio/funcoeszz/funcoeszz"  # script
    source "$ZZPATH"

Você precisa adicionar "na mão" mais uma linha lá no `~/.bashrc`, antes do comando `source`, para indicar onde está a pasta com as funções:

    export ZZDIR="/Users/aurelio/funcoeszz/zz"

Agora sim, você pode usar as Funções ZZ em toda a sua glória. Abra um novo terminal e divirta-se!

    $ zzcalcula 10+5
    15
    
    $ zzbissexto
    2012 é bissexto
    
    $ zzmaiusculas tá funcionando
    TÁ FUNCIONANDO

Quando quiser atualizar os arquivos para a versão mais recente, basta um `git pull`.

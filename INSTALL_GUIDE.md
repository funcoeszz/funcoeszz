**Instalando funções ZZ passo-a-passo**
-----

Funções ZZ é uma coletânea com 178 miniaplicativos de utilidades diversas, acessíveis e prontos para serem usados na linha de comando de sistemas tipo UNIX (Linux, BSD, Mac OS X, Cygwin, entre outros).
Entre as funções estão placar de jogos de futebol, calculadoras, resultado da Mega Sena, cartaz de cinemas, etc.
Durante o processo de instalação pode ser que alguns erros apareçam, as vezes impossibilitando a instalação das funções, ou até causando o mal funcionamento de algumas funções. Para evitar esses problemas é aconcelhavel que instale alguns programas adicionais e que mantenha seu sistema atualizado.
Este guia tem por finalidade abordar algumas situações que surgem durante a instalação das Funções ZZ na sua maquina.

**PASSO 1**: <br/>
-----
Digite o comando

`~$ git clone git://github.com/funcoeszz/funcoeszz.git  ~/funcoeszz`

Para baixar o repositório para o seu PC.
Talvez seja necessário instalar o git, caso ele não esteja instalado, basta digitar o comando: 

`~$ sudo apt-get install git`

Ainda assim pode ser que apareça um erro do tipo `404  Not Found`. Não se desespere. Em seu terminal digite o comando:

` ~$ sudo apt update`

Agora sim você pode instalar o git para que assim consiga baixar o repositório das funcõesZZ.
<br/>

**PASSO 2**: <br/>
-----
Rode o comando seguinte para adicionar o carregamento das Funções ZZ no final de seu ~/.bashrc:
```cosole
$ ./funcoeszz zzzz --bashrc
Feito!
As Funções ZZ foram instaladas no /home/facomp/.bashrc
```
<br/>

**PASSO 3** <br/>
-----
Você precisa adicionar "na mão" mais uma linha lá no ~/.bashrc, antes do comando `source "$ZZPATH"`, para indicar onde está a pasta com as funções, digite:

`export ZZDIR="/home/facomp/funcoeszz/zz"`

Feito isso, feche o terminal e abra-o novamente para executar as funçõesZZ:
```console
$ zzcalcula 10+5
15

$ zzbissexto 2016
2016 é bissexto

$ zzmaiusculas tá funcionando
TÁ FUNCIONANDO
```

-----
_Obs.:_ Talvez seja necessário instalar alguns programas adicionais para que algumas funções funcione corretamente, então o comando a seguir irá mostrar quais desses programas faltam ser instalados:

`~$ zzzz --teste`

Mesmo após a instalação dos programas restantes, caso alguma função não execute de forma correta, você pode solucionar este problema instalando a funçõesZZ pelo próprio terminal: 

`~$ sudo apt install funcoeszz`


Agora sim, você pode usar as Funções ZZ em toda a sua glória. Abra um novo terminal e divirta-se!

**Lembrando que é recomendado instalar as funçõesZZ atravéz do repositório que foi apresentado no post acima, pois no GitHub as funções são atualizadas frequentemente diferente do site.**


 - Website: http://funcoeszz.net
  -  GitHub: https://github.com/funcoeszz/funcoeszz
   - Grupo: http://br.groups.yahoo.com/group/zztabtab/
   - Twitter: https://twitter.com/Funcoes_ZZ
 

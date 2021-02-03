$ zzzz -h

zzzz
Mostra informações sobre as funções, como versão e localidade.
Opções: --atualiza  baixa a versão mais nova das funções
        --teste     testa se a codificação e os pré-requisitos estão OK
        --bashrc    instala as funções no ~/.bashrc
        --tcshrc    instala as funções no ~/.tcshrc
        --zshrc     instala as funções no ~/.zshrc
        --listar X  lista as funções (X pode ser todas|ligadas|desligadas)
Uso: zzzz [--atualiza|--teste|--bashrc|--tcshrc|--zshrc|--listar X]
Ex.: zzzz
     zzzz --teste
     zzzz --listar ligadas

$

# Testa a opção --teste

$ zzzz --teste | sed 's/\.\.\. .*/.../;/Atenção/,/^Talvez/d;/^ *$/d'
Procurando o comando awk...
Procurando o comando bc...
Procurando o comando cat...
Procurando o comando chmod...
Procurando o comando clear...
Procurando o comando cp...
Procurando o comando cpp...
Procurando o comando curl...
Procurando o comando cut...
Procurando o comando diff...
Procurando o comando du...
Procurando o comando find...
Procurando o comando fmt...
Procurando o comando grep...
Procurando o comando iconv...
Procurando o comando links...
Procurando o comando lynx...
Procurando o comando mktemp...
Procurando o comando mv...
Procurando o comando od...
Procurando o comando ps...
Procurando o comando rm...
Procurando o comando sed...
Procurando o comando sleep...
Procurando o comando sort...
Procurando o comando tail...
Procurando o comando tr...
Procurando o comando uniq...
Procurando o comando unzip...
Verificando a codificação do sistema...
Verificando a codificação das Funções ZZ...
$

# Testa saída da zzzz sem argumentos

$ zzzz | grep '(' | tr -d 0-9 | sed 's/) .*/) .../'
( script) ...
(  pasta) ...
( versão) ...
(  cores) ...
(    tmp) ...
(browser) ...
( bashrc) ...
(  zshrc) ...
(   site) ...
((  funções disponíveis ))
$

# Lista de funções desligadas só aparece no final, não nas disponíveis.
# Nestes testes foi criada uma pasta ZZTMPDIR alternativa para gerar os
# arquivos .on e .off sem bagunçar os "oficiais".

$ zzzz_tmp="/tmp/testador-zzzz-$$"
$ mkdir "$zzzz_tmp"
$ ZZTMPDIR="$zzzz_tmp" ZZOFF="zzdata zzcores" ../funcoeszz
$ cat "$zzzz_tmp/zz.off"
zzcores
zzdata
$ ZZTMP="$zzzz_tmp/zz" zzzz | tail -n 2
(( 2 funções desativadas ))
cores, data
$ ZZTMP="$zzzz_tmp/zz" zzzz | sed -n '/disponíveis/,/^$/ p' | grep -E '\b(cores|data),'
$ rm "$zzzz_tmp"/zz*
$ rmdir "$zzzz_tmp"
$ unset zzzz_tmp
$

# As variáveis de ambiente devem ser respeitadas

$ ZZCOR=0         zzzz | grep '( *cores)'
(  cores) não
$ ZZCOR=1         zzzz | grep '( *cores)' | tr -d '\033' | sed 's/\[[0-9;]*m//g'
(  cores) sim
$ ZZDIR=/xxx      zzzz | grep '( *pasta)'
(  pasta) /xxx
$ ZZPATH=/xxx     zzzz | grep '( *script)'
( script) /xxx
$ ZZBROWSER=lynx  zzzz | grep '( *browser)'
(browser) lynx
$ ZZBROWSER=links zzzz | grep '( *browser)'
(browser) links
$ ZZBROWSER=w3m   zzzz | grep '( *browser)'
(browser) w3m
$ ZZBROWSER=xxx   zzzz | grep '( *browser)'
(browser) xxx
$

### Testes da opção --listar

# Setup inicial

$ ZZTMP_ORIG="$ZZTMP"
$ ZZTMPDIR_ORIG="$ZZTMPDIR"
$ zz_root='..'
$ zzzz_tmp="/tmp/testador-zzzz-$$"
$ mkdir "$zzzz_tmp"
$ export ZZTMP="$zzzz_tmp/zz"
$ export ZZTMPDIR="$zzzz_tmp"
$

# Obtendo a lista completa de funções na pasta zz

$ ls -1 $zz_root/zz/ | sed 's/\.sh$//' | sort > ls.txt
$

# Testes chamando o core diretamente
#
# Note como:
# - '--listar desligadas' é diretamente relacionada à ZZOFF
# - as funções em ZZOFF podem ter ou não o prefixo zz
# - a saída do comando é ordenada alfabeticamente

$ ZZOFF='' $zz_root/funcoeszz zzzz --listar desligadas
$ ZZOFF='data cores' $zz_root/funcoeszz zzzz --listar desligadas
zzcores
zzdata
$ ZZOFF='zzdata zzcores' $zz_root/funcoeszz zzzz --listar desligadas
zzcores
zzdata
$ ZZOFF='zzdata zzcores' $zz_root/funcoeszz zzzz --listar ligadas > ligadas.txt
$ ZZOFF='zzdata zzcores' $zz_root/funcoeszz zzzz --listar todas > todas.txt
$ diff ls.txt todas.txt
$ diff ls.txt ligadas.txt | grep '^[<>]'
< zzcores
< zzdata
$

# Testes usando `source` no core
# Quando não há funções desligadas: ls zz/* == todas == ligadas

$ ZZOFF='' source $zz_root/funcoeszz
$ zzzz --listar todas > todas.txt
$ zzzz --listar ligadas > ligadas.txt
$ zzzz --listar desligadas  # saída vazia
$ diff ls.txt todas.txt
$ diff ls.txt ligadas.txt
$

# Testes usando `source` no core
# Com funções desligadas, as listas ligadas/desligadas mudam

$ ZZOFF='zzdata zzcores' source $zz_root/funcoeszz
$ zzzz --listar todas > todas.txt
$ zzzz --listar ligadas > ligadas.txt
$ zzzz --listar desligadas
zzcores
zzdata
$ diff ls.txt todas.txt
$ diff ls.txt ligadas.txt | grep '^[<>]'
< zzcores
< zzdata
$

# Testes chamando o script tudo-em-um

$ $zz_root/funcoeszz --tudo-em-um > te1.sh
$ ZZOFF='zzdata zzcores' bash te1.sh zzzz --listar todas > todas.txt
$ ZZOFF='zzdata zzcores' bash te1.sh zzzz --listar ligadas > ligadas.txt
$ ZZOFF='zzdata zzcores' bash te1.sh zzzz --listar desligadas
zzcores
zzdata
$ diff ls.txt todas.txt
$ diff ls.txt ligadas.txt | grep '^[<>]'
< zzcores
< zzdata
$

# Testes usando `source` no script tudo-em-um

$ $zz_root/funcoeszz --tudo-em-um > te1.sh
$ ZZOFF='zzdata zzcores' ZZPATH='te1.sh' source te1.sh
$ zzzz --listar todas > todas.txt
$ zzzz --listar ligadas > ligadas.txt
$ zzzz --listar desligadas
zzcores
zzdata
$ diff ls.txt todas.txt
$ diff ls.txt ligadas.txt | grep '^[<>]'
< zzcores
< zzdata
$

# Faxina

$ ZZTMP="$ZZTMP_ORIG"
$ ZZTMPDIR="$ZZTMPDIR_ORIG"
$ unset ZZTMP_ORIG
$ unset ZZTMPDIR_ORIG
$ unset zz_root
$ rm {ls,todas,ligadas}.txt te1.sh
$ rm "$zzzz_tmp"/zz*
$ rmdir "$zzzz_tmp"
$

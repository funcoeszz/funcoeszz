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

# Lista de funções desligadas só aparece no final, não nas disponíveis

$ ZZOFF="zzdata zzcores" zzzz | tail -n 2
(( 2 funções desativadas ))
cores, data
$ ZZOFF="zzdata zzcores" zzzz | sed -n '/disponíveis/,/^$/ p' | grep -E '\b(cores|data),'
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

# Obtendo a lista completa de funções na pasta zz

$ zz_root='..'
$ ls -1 $zz_root/zz/ | sed 's/\.sh$//' | sort > ls.txt
$

# Quando não há funções desligadas: ls zz/* == todas == ligadas

$ ZZOFF='' zzzz --listar todas > todas.txt
$ diff ls.txt todas.txt
$ ZZOFF='' zzzz --listar ligadas > ligadas.txt
$ diff todas.txt ligadas.txt
$ ZZOFF='' zzzz --listar desligadas
$

# Com funções desligadas, as listas ligadas/desligadas mudam

$ ZZOFF='zzdata zzcores' zzzz --listar todas > todas.txt
$ diff ls.txt todas.txt
$ ZZOFF='zzdata zzcores' zzzz --listar ligadas > ligadas.txt
$ diff todas.txt ligadas.txt | grep '^[<>]'
< zzcores
< zzdata
$ ZZOFF='zzdata zzcores' zzzz --listar desligadas
zzcores
zzdata
$

# No modo tudo-em-um, contamos apenas com ZZPATH (sem ZZDIR)

$ ZZOFF='' $zz_root/funcoeszz --tudo-em-um > te1.sh
$ ZZOFF='zzdata zzcores' ZZDIR='' ZZPATH="$PWD/te1.sh" bash te1.sh zzzz --listar ligadas > ligadas.txt
$ diff ls.txt ligadas.txt | grep '^[<>]'
< zzcores
< zzdata
$ rm te1.sh
$

# Ainda no modo tudo-em-um, porém agora sem ZZDIR nem ZZPATH. Para obter
# a lista de todas as funções, vemos quais funções nomeadas `zz*` estão
# definidas na shell atual (não é perfeito, mas quebra um galho).

$ ZZOFF='zzdata zzcores' ZZDIR='' ZZPATH='' zzzz --listar ligadas > ligadas.txt
$ diff ls.txt ligadas.txt | grep '^[<>]'
< zzcores
< zzdata
$

# Faxina

$ unset zz_root
$ rm {ls,todas,ligadas}.txt
$

$ limpa='s/[0-9]/9/g; s/Coluna .*/Coluna .../'
$

# Ignora nomes inválidos

$ zzpalpite FOO
$ zzpalpite quina FOO | sed "$limpa"
quina:
 99 99 99 99 99
$

# Operação normal, informando uma ou mais loterias

$ zzpalpite quina | sed "$limpa"
quina:
 99 99 99 99 99
$ zzpalpite quina federal | sed "$limpa"
quina:
 99 99 99 99 99

federal:
 99999
$

# Sem argumentos, mostra todas as loterias

$ zzpalpite | sed "$limpa"
quina:
 99 99 99 99 99

megasena:
 99 99 99 99 99 99

duplasena:
 99 99 99 99 99 99

lotomania:
 99 99 99 99 99
 99 99 99 99 99
 99 99 99 99 99
 99 99 99 99 99
 99 99 99 99 99
 99 99 99 99 99
 99 99 99 99 99
 99 99 99 99 99
 99 99 99 99 99
 99 99 99 99 99

lotofacil:
 99 99 99 99 99
 99 99 99 99 99
 99 99 99 99 99

federal:
 99999

timemania:
 99 99 99 99 99
 99 99 99 99 99

loteca:
 Jogo 99: Coluna ...
 Jogo 99: Coluna ...
 Jogo 99: Coluna ...
 Jogo 99: Coluna ...
 Jogo 99: Coluna ...
 Jogo 99: Coluna ...
 Jogo 99: Coluna ...
 Jogo 99: Coluna ...
 Jogo 99: Coluna ...
 Jogo 99: Coluna ...
 Jogo 99: Coluna ...
 Jogo 99: Coluna ...
 Jogo 99: Coluna ...
 Jogo 99: Coluna ...
$

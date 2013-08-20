# Preparativos

$ file='DSC00077.JPG'
$ touch $file
$

# Erros

$ zznomefoto                                  #→ --regex ^Uso:
$ zznomefoto   -n                             #→ --regex ^Uso:
$ zznomefoto   -n   -d                        #→ --regex ^Uso:
$ zznomefoto   -n   -d   1   -i               #→ --regex ^Uso:
$ zznomefoto   -n   -d   1   -i   1           #→ --regex ^Uso:
$ zznomefoto   -n   -d   1   -i   1   _fake_  #→ Não consegui ler o arquivo _fake_
$ zznomefoto   -n                     _fake_  #→ Não consegui ler o arquivo _fake_
$ zznomefoto   -n   -d   A            $file   #→ Número inválido para a opção -d: A
$ zznomefoto   -n   -d   -3           $file   #→ Número inválido para a opção -d: -3
$ zznomefoto   -n        -i   A       $file   #→ Número inválido para a opção -i: A
$ zznomefoto   -n        -i   -3      $file   #→ Número inválido para a opção -i: -3

# Sem parâmetros

$ zznomefoto   -n                     $file   #→ [-n] DSC00077.JPG -> DSC001.JPG

# Números

$ zznomefoto   -n   -d   1            $file   #→ [-n] DSC00077.JPG -> DSC1.JPG
$ zznomefoto   -n   -d   4            $file   #→ [-n] DSC00077.JPG -> DSC0001.JPG
$ zznomefoto   -n   -d   10           $file   #→ [-n] DSC00077.JPG -> DSC0000000001.JPG
$ zznomefoto   -n            -i   99  $file   #→ [-n] DSC00077.JPG -> DSC099.JPG
$ zznomefoto   -n   -d   10  -i   99  $file   #→ [-n] DSC00077.JPG -> DSC0000000099.JPG
$ zznomefoto   -n   -d   1   -i 9999  $file   #→ [-n] DSC00077.JPG -> DSC9999.JPG

# Prefixo

$ zznomefoto   -n   -p   ''                  $file   #→ [-n] DSC00077.JPG -> DSC001.JPG
$ zznomefoto   -n   -p   'Praia_'            $file   #→ [-n] DSC00077.JPG -> Praia_001.JPG
$ zznomefoto   -n   -p   'Praia_'   -d   4   $file   #→ [-n] DSC00077.JPG -> Praia_0001.JPG
$ zznomefoto   -n   -p   'Praia_'   -i   4   $file   #→ [-n] DSC00077.JPG -> Praia_004.JPG

# Faxina

$ rm -f $file
$

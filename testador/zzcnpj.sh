#!/usr/bin/env bash
debug=0
values=1
tests=(
123456780001	r "CNPJ inv.lido \(deve ter 14 d.gitos\)"
123456780001000	r "CNPJ inv.lido \(deve ter 14 d.gitos\)"
12345678000100	r "CNPJ inv.lido \(deveria terminar em 95\)"
12345678000195	r "CNPJ v.lido"
12.345.678/0001-95	r "CNPJ v.lido"
'12 345 678 0001 95'	r "CNPJ v.lido"
'z1_23	4=5*6@7+8?00a0195'	r "CNPJ v.lido"
''		r "[0-9]{2}\.[0-9]{3}\.[0-9]{3}/[0-9]{4}-[0-9]{2}"
)
. _lib

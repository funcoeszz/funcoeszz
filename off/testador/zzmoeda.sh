$ limpa='s/[0-9][0-9]*/9/g; s/-//g'
$

# Saída normal, mostrando apenas uma moeda
#
#         Compra     Venda        Variação
# CLP     509,3400    509,5400    -6,26  -1,21 %    19h35   Peso Chile

$ zzmoeda chile | sed "$limpa"
        Compra     Venda        Variação
CLP     9,9    9,9    9,9  9,9 %    9h9   Peso Chile
$

# Com opção -t e procurando por uma string ao mesmo tempo
#
#         Compra     Venda        Variação
# ARS     5,5200      5,5500      0,01   0,18 %     18h03   Peso Argentino Argentina
# CLP     509,3400    509,5400    -6,26  -1,21 %    19h35   Peso Chile
# COP     1.876,7400  1.877,1900  -2,71  -0,14 %    19h54   Peso Colômbia
# CUP     1,0000      1,0000      0,00   0,00 %     01h00   Peso Cuba
# MXN     12,6100     12,6130     -0,14  -1,07 %    20h49   Peso México
# DOP     42,0000     42,2000     0,00   0,00 %     19h14   Peso República dominicana
# UYU     21,1500     21,4000     0,00   0,00 %     18h50   Peso Uruguai
# PHP     43,4600 43,4900 -0,36 -0,82 % 16h38   Peso Filipinas

$ zzmoeda -t peso | sed "$limpa"
        Compra     Venda        Variação
ARS     9,9      9,9      9,9   9,9 %     9h9   Peso Argentino Argentina
CLP     9,9    9,9    9,9  9,9 %    9h9   Peso Chile
COP     9.9,9  9.9,9  9,9  9,9 %    9h9   Peso Colômbia
CUP     9,9      9,9      9,9   9,9 %     9h9   Peso Cuba
MXN     9,9     9,9     9,9  9,9 %    9h9   Peso México
DOP     9,9     9,9     9,9   9,9 %     9h9   Peso República dominicana
UYU     9,9     9,9     9,9   9,9 %     9h9   Peso Uruguai
PHP     9,9 9,9 9,9 9,9 % 9h9   Peso Filipinas
$

# Sem argumentos, mostra as moedas principais (são 152 em 2013-08-08)

$ zzmoeda | sed '4,150 d' | sed "$limpa"
        Compra     Venda        Variação
DOLCM   9,9 9,9 9,9 9,9 % 9h9   Dólar Comercial
DOLTR   9,9 9,9 9,9 9,9 % 9h9   Dólar Turismo
KES     9,9    9,9    9,9   9,9 % 9h9   Xelim Quênia
SOS     9.9,9 9.9,9 9,9   9,9 % 9h9   Xelim Somália
TZS     9.9,9 9.9,9 9,9    9,9 %  9h9   Xelim Tanzânia
$

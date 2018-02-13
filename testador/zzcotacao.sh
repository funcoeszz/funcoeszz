$ zzcotacao | sed 's/[0-9],[0-9]\{3\}/9.999/g;s|  n/d|9.999|g;s/[+_]/ /g;s/-/ /g;s/[0-9],[0-9]\{2\}/9.99/g;5q'
Infomoney
                    Compra   Venda   Var(%)
Dolar Comercial      9.999   9.999    9.99
Dolar Turismo        9.999   9.999    9.99
Dolar PTAX800        9.999   9.999    9.99
$

$ zzcotacao | sed -n '/UOL /,$ {s|[0-3][0-9]/[0-1][0-9]/[0-9]\{4\}|DATA|;s/[0-2][0-9]h[0-5][0-9]/HORA/ ;s/[0-9],[0-9]\{4\}/9.9999/g;s/[+_]/ /g;s/-/ /g;s/[0-9],[0-9]\{2\}/9.99/g;p;}'
UOL   Economia
DATA HORA
                    Compra   Venda   Var(%)
Dólar Comercial     9.9999  9.9999   9.99%
Dólar Turismo       9.9999  9.9999   9.99%
Euro                9.9999  9.9999   9.99%
Libra               9.9999  9.9999   9.99%
Pesos Argentino     9.9999  9.9999   9.99%
$

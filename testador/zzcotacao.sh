$ zzcotacao | sed 's/[0-9],[0-9]\{3\}/9.999/g;s|  n/d|9.999|g;s/[+_]/ /g;s/-/ /g;s/[0-9],[0-9]\{2\}/9.99/g;5q'
                    Compra   Venda   Var(%)
Dolar Comercial      9.999   9.999    9.99
Dolar Turismo        9.999   9.999    9.99
Dolar PTAX800        9.999   9.999    9.99
Euro                 9.999   9.999    9.99
$

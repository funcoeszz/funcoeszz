$ zzcotacao | sed 's/[0-9],[0-9]\{3,\}/9.999/g;s/0/9.999/g;s|  n/d|9.999|g;s/[+_]/ /g;s/-//g;s/[0-9],[0-9]\{2\}/9.99/g;9q' | sed 's/  *9.999/\t9.999/g'
Infomoney
                    Compra   Venda   Var(%)
Peso Argentino	9.999	9.999	9.999
Dólar Australiano	9.999	9.999	9.999
Dólar Canadense	9.999	9.999	9.999
Franco Suíço          9.99	9.999	9.999
Dólar Comercial	9.999	9.999	9.999
Dólar Turismo	9.999	9.999	9.999
Euro	9.999	9.999	9.999
$

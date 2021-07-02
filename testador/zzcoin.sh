$ zzcoin foo
Moeda desconhecida: foo
$ zzcoin | grep Bitcoin
BCH : Bitcoin Cash
BTC : Bitcoin
$ zzcoin BTC | sed 's/[0-9.]\{1,\}/9/g'
R$ 9,9
$ zzcoin ltc | sed 's/[0-9.]\{1,\}/9/g'
R$ 9,9
$

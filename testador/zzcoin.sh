$ zzcoin foo
Moeda desconhecida: foo
$ zzcoin | grep Bitcoin
BCH : Bitcoin Cash
BTC : Bitcoin
$ zzcoin BTC | sed 's/[0-9.]\{1,\}/9/g'
BTC: R$ 9,9
$ zzcoin ltc | sed 's/[0-9.]\{1,\}/9/g'
LTC: R$ 9,9
$ zzcoin btc ltc | sed 's/[0-9.]\{1,\}/9/g'
BTC: R$ 9,9
LTC: R$ 9,9
$

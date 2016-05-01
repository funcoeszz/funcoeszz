$ zzcoin                                   #→ --lines 103
$ zzcoin btc | sed 's/[0-9.]\{1,\}/9/g'    #→ R$ 9,9
$ zzcoin ltc | sed 's/[0-9.]\{1,\}/9/g'    #→ R$ 9,9
$ zztool source "https://www.mercadobitcoin.com.br/api/ticker/"
$ zztool source "https://www.mercadobitcoin.com.br/api/ticker_litecoin/"

# Os testes são válidos apenas se o terminal tiver uma largura mínima de 80 colunas.
$ zzbraille --s1 x --s2 y Ceguinho é a mãe.
 yy yx xx xy xx xy yx xx xy xy yy xx yy xy yy xx yx xy yy
 yy yy yy yx xx yy xy yx xx yx yy xx yy yy yy yy yx yx xx
 yy yx yy yy yy xx yy xy yy xy yy xx yy yy yy xy xy yy yx
 __ +-(C)(e)(g)(u)(i)(n)(h)(o) __(é) __(a) __(m)(ã)(e)(.)

$

$ zzbraille --s1 o --s2 . 0123456789
 .. .o .o o. o. oo oo o. oo oo o. .o
 .. .o oo .. o. .. .o .o o. oo oo o.
 .. oo .. .. .. .. .. .. .. .. .. ..
 __ ##(0)(1)(2)(3)(4)(5)(6)(7)(8)(9)

$

$ echo 'Good Morning, Vietnam!' | zzbraille --s1 v --s2 ' '
     v vv v  v  vv     v vv v  v  vv  v vv vv        v v   v v   v vv v  vv   
       vv  v  v  v           v vv  v v   v vv v        v  v   v vv  v       vv
     v    v  v         v v  v  v  v     v            v vv       v  v     v  v 
 __ +-(G)(o)(o)(d) __ +-(M)(o)(r)(n)(i)(n)(g)(,) __ +-(V)(i)(e)(t)(n)(a)(m)(!)

$

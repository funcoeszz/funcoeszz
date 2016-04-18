$ zzrepete 
Uso: zzrepete [-l | --linha] <repetições> <texto>
$ zzrepete abre alas
Número inválido para repetições: abre
$ zzrepete -5 Foo baR
Número inválido para repetições: -5
$ zzrepete 7 Foo baR
Foo baRFoo baRFoo baRFoo baRFoo baRFoo baRFoo baR
$ zzrepete -l 6 Foo" | " baR "_"
Foo |  baR _
Foo |  baR _
Foo |  baR _
Foo |  baR _
Foo |  baR _
Foo |  baR _
$ zzrepete 10 "Bar    Foo "
Bar    Foo Bar    Foo Bar    Foo Bar    Foo Bar    Foo Bar    Foo Bar    Foo Bar    Foo Bar    Foo Bar    Foo 
$ zzrepete -l 8 Bar     Foo
Bar Foo
Bar Foo
Bar Foo
Bar Foo
Bar Foo
Bar Foo
Bar Foo
Bar Foo
$ zzrepete 50 .
..................................................

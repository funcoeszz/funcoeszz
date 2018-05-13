$ zzvds | sed '1s/.*/OK/;2s/^$/Ok/;3,$s/.*/ok/'| uniq
OK
Ok
ok
$ zzvds 3 | sed '1s/.*/OK/;2s/^$/Ok/;3,$s/.*/ok/'| uniq
OK
Ok
ok
$ zzvds -h

zzvds
https://vidadesuporte.com.br
Mostra o texto das últimas tirinhas de Vida de Suporte.
Sem opção mostra a tirinha mais recente.
Se a opção for um número, mostra a tirinha que ocupa essa ordem
Se a opção for 0, mostra todas mais recentes

Uso: zzvds [número]
Ex.: zzvds    # Mostra a tirinha mais recente
     zzvds 5  # Mostra a quinta tirinha mais recente
     zzvds 0  # Mostra todas as tirinhas mais recentes

$

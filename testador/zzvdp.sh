$ zzvdp | sed '1s/.*/OK/;2s/^$/Ok/;3,$s/.*/ok/'| uniq
OK
Ok
ok
$ zzvdp 3 | sed '1s/.*/OK/;2s/^$/Ok/;3,$s/.*/ok/'| uniq
OK
Ok
ok
$ zzvdp -h

zzvdp
https://vidadeprogramador.com.br
Mostra o texto das últimas tirinhas de Vida de Programador.
Sem opção mostra a tirinha mais recente.
Se a opção for um número, mostra a tirinha que ocupa essa ordem
Se a opção for 0, mostra todas mais recentes

Uso: zzvdp [número]
Ex.: zzvdp    # Mostra a tirinha mais recente
     zzvdp 5  # Mostra a quinta tirinha mais recente
     zzvdp 0  # Mostra todas as tirinhas mais recentes

$

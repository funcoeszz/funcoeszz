$ zzdilbert -x #→ --regex ^Uso:
$ zzdilbert | awk '/-------/{print "OK";next};/:/{print "ok";next};{print "Ok"}' | awk '!line[$0]++'
OK
Ok
ok
$ zzdilbert -h

zzdilbert
http://dilbert.com/
Mostra o texto em inglês das últimas tirinhas de Dilbert.
Com a opção -t, faz a tradução para o português.

Uso: zzdilbert [-t|--traduzir]
Ex.: zzdilbert     # Mostra as tirinhas mais recentes
     zzdilbert -t  # Mostra as tirinhas mais recentes traduzidas


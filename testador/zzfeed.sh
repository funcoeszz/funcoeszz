# Sem argumentos

$ zzfeed
Uso: zzfeed [-n número] URL...
$ zzfeed -n 4
Uso: zzfeed [-n número] URL...
$

# Opção -n

$ zzfeed -n X http://aurelio.net/feed/; echo $?
Número inválido para a opção -n: X
1
$ zzfeed -n 0 http://aurelio.net/feed/; echo $?
0
$ zzfeed -n 4 http://aurelio.net/feed/  #→ --lines 4

# Via STDIN

$ zztool source http://aurelio.net/feed/ | zzfeed -n 4 -  #→ --lines 4


# Tipos de feed e codificações

$ i='RSS UTF-8'      zzfeed http://aurelio.net/feed/                        #→ --lines 10
$ i='RSS ISO-8859-1' zzfeed http://feeds.feedburner.com/NoticiasLinux       #→ --lines 10
$ i='RDF UTF-8'      zzfeed http://www.us-cert.gov/channels/techalerts.rdf  #→ --lines 10
$ i='RDF ISO-8859-1' zzfeed http://www.vivaolinux.com.br/index.rdf          #→ --lines 10

# Informa um site para obter o endereço de seus feeds

$ zzfeed aurelio.net
http://aurelio.net/feed/
$

# Múltiplos sites, cada lista de feed ganha um "cabeçalho"

$ zzfeed aurelio.net aurelio.net
* aurelio.net
http://aurelio.net/feed/

* aurelio.net
http://aurelio.net/feed/

$

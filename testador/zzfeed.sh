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
$ zzfeed -n 4 http://aurelio.net/feed/  #=> --lines 4

# Via STDIN

$ zztool source http://aurelio.net/feed/ | zzfeed -n 4 -  #=> --lines 4


# Tipos de feed e codificações

$ i='RSS UTF-8'      zzfeed http://aurelio.net/feed/                        #=> --lines 10
$ i='RSS ISO-8859-1' zzfeed http://feeds.feedburner.com/NoticiasLinux       #=> --lines 10
$ i='RDF UTF-8'      zzfeed http://www.us-cert.gov/channels/techalerts.rdf  #=> --lines 10
$ i='RDF ISO-8859-1' zzfeed http://www.vivaolinux.com.br/index.rdf          #=> --lines 10

# Informa um site para obter o endereço de seus feeds

$ zzfeed feedly.com
http://blog.feedly.com/feed/
$

# Múltiplos sites, cada lista de feed ganha um "cabeçalho"

$ zzfeed feedly.com feedly.com
* feedly.com
http://blog.feedly.com/feed/

* feedly.com
http://blog.feedly.com/feed/

$

# Site que a URL pro feed não contém o domínio: href="/feed/"

$ zzfeed aurelio.net
/feed/
$

# Site inexistente

$ zzfeed funcoeszz-not-found.net
$

# Site sem feeds

$ zzfeed google.com
$

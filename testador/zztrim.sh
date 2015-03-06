# Em todos os comandos, é usado sed e tr no final para tornar visíveis
# os espaços em branco, tabs (\t) e o fim de linha (~).

$ printa() { printf '\n \t \n\n \t foo \t \n\n \t \n\n'; }
$ mostra() { sed -n l | tr '$' '~'; }
$

# Texto original

$ printa | mostra
~
 \t ~
~
 \t foo \t ~
~
 \t ~
~
$

# Sem opções, remove todos os brancos

$ printa | zztrim | mostra
foo~
$

# Testa cada opção individualmente

$ printa | zztrim --top | mostra
 \t foo \t ~
~
 \t ~
~
$ printa | zztrim -t | mostra
 \t foo \t ~
~
 \t ~
~
$ printa | zztrim --bottom | mostra
~
 \t ~
~
 \t foo \t ~
$ printa | zztrim -b | mostra
~
 \t ~
~
 \t foo \t ~
$ printa | zztrim --left | mostra
~
~
~
foo \t ~
~
~
~
$ printa | zztrim -l | mostra
~
~
~
foo \t ~
~
~
~
$ printa | zztrim --right | mostra
~
~
~
 \t foo~
~
~
~
$ printa | zztrim -r | mostra
~
~
~
 \t foo~
~
~
~
$

# Horizontal e vertical

$ printa | zztrim --horizontal | mostra
~
~
~
foo~
~
~
~
$ printa | zztrim -H | mostra
~
~
~
foo~
~
~
~
$ printa | zztrim --vertical | mostra
 \t foo \t ~
$ printa | zztrim -V | mostra
 \t foo \t ~
$

# Combinação de opções

$ printa | zztrim -t -b -l -r | mostra
foo~
$ printa | zztrim -r -l -b -t | mostra
foo~
$ printa | zztrim -b -b -t -t -r -r -l -l | mostra
foo~
$ printa | zztrim --horizontal --vertical | mostra
foo~
$ printa | zztrim --horizontal -t -b | mostra
foo~
$ printa | zztrim --vertical -l -r | mostra
foo~
$ printa | zztrim -H -V | mostra
foo~
$ printa | zztrim -H -t -b | mostra
foo~
$ printa | zztrim -V -l -r | mostra
foo~
$ printa | zztrim -t -b -r | mostra  # só mantém o indent original
 \t foo~
$ printa | zztrim -V -r | mostra
 \t foo~
$

# Texto via argumentos

$ zztrim "  foo  "
foo
$ zztrim $(printa)
foo
$

# Opção inválida

$ echo | zztrim --foo          #→ Opção inválida --foo
$ zztrim --foo texto           #→ Opção inválida --foo
$ zztrim -l -r --foo texto     #→ Opção inválida --foo

# Teste com o arquivo externo

$ cat zztrim.in.txt | zztrim
Primeira linha com conteúdo
Linha com espaços só no começo


Linha com TABS só no começo
Aqui com espaços no começo e TAB ao final
TAB no começo e espaços no final




Espaços em ambos os lados






TABs em ambos os lados aqui
Espaços e TABs e ambos os lados agora
Outra linha com espaços e TABs nos dois lados
..só..
espaços em ambos os lados		 e TAB no meio
TABS em       ambos os lados        e espaços        no meio da frase
adsdlçlsdklçhsdf
Fim desse	 bloco .







Última linha sem espaços ou TABs nas extremidades.
$

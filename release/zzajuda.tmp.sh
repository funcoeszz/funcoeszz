
zzajuda) cat <<'EOT'
zzajuda
Mostra uma tela de ajuda com explicação e sintaxe de todas as funções.
Opções: --lista  lista de todas as funções, com sua descrição
        --uso    resumo de todas as funções, com a sintaxe de uso
Uso: zzajuda [--lista|--uso]
Ex.: zzajuda
     zzajuda --lista
EOT
;;

zzaleatorio) cat <<'EOT'
zzaleatorio
Gera um número aleatório.
Sem argumentos, comporta-se igual a $RANDOM.
Apenas um argumento, número entre 0 e o valor fornecido.
Com dois argumentos, número entre esses limites informados.

Uso: zzaleatorio [número] [número]
Ex.: zzaleatorio 10
     zzaleatorio 5 15
     zzaleatorio
EOT
;;

zzalfabeto) cat <<'EOT'
zzalfabeto
Central de alfabetos (romano, militar, radiotelefônico, OTAN, RAF, etc).
Obs.: Sem argumentos mostra a tabela completa, senão traduz uma palavra.

Tipos reconhecidos:

   --militar | --radio | --fone | --otan | --icao | --ansi
                                  Radiotelefônico internacional
   --romano | --latino            A B C D E F...
   --royal-navy | --royal         Marinha Real - Reino Unido, 1914-1918
   --signalese | --western-front  Primeira Guerra, 1914-1918
   --raf24                        Força Aérea Real - Reino Unido, 1924-1942
   --raf42                        Força Aérea Real - Reino Unido, 1942-1943
   --raf | --raf43                Força Aérea Real - Reino Unido, 1943-1956
   --us | --us41                  Militar norte-americano, 1941-1956
   --portugal | --pt              Lugares de Portugal
   --name | --names               Nomes de pessoas, em inglês
   --lapd                         Polícia de Los Angeles (EUA)
   --morse                        Código Morse
   --german                       Nomes de pessoas, em alemão
   --all | --todos                Todos os códigos lado a lado

Uso: zzalfabeto [--TIPO] [palavra]
Ex.: zzalfabeto --militar
     zzalfabeto --militar cambio
     zzalfabeto --us --german prossiga
EOT
;;

zzalinhar) cat <<'EOT'
zzalinhar
Alinha um texto a esquerda, direita, centro ou justificado.

As opções -l, --left, -e, --esquerda alinham as colunas a esquerda (padrão).
As opções -r, --right, -d, --direita alinham as colunas a direita.
As opções -c, --center, --centro centralizam as colunas.
A opção -j, --justify, --justificar faz o texto ocupar toda a linha.

As opções -w, --width, --largura seguido de um número,
determinam o tamanho da largura como base ao alinhamento.
Obs.: Onde a largura é maior do que a informada não é aplicado alinhamento.

Uso: zzalinhar [-l|-e|-r|-d|-c|-j] [-w <largura>] arquivo
Ex.: zzalinhar arquivo.txt
     zzalinhar -c -w 20 arquivo.txt
     zzalinhar -j arquivo.txt
     cat arquivo.txt | zzalinhar -r
EOT
;;

zzansi2html) cat <<'EOT'
zzansi2html
Converte para HTML o texto colorido do terminal (códigos ANSI).
Útil para mostrar a saída do terminal em sites e blogs, sem perder as cores.
Obs.: Exemplos de texto ANSI estão na saída das funções zzcores e zzecho.
Obs.: Use o comando script para guardar a saída do terminal em um arquivo.
Uso: zzansi2html [arquivo]
Ex.: zzecho --letra verde -s -p -N testando | zzansi2html
     ls --color /etc | zzansi2html > ls.html
     zzcores | zzansi2html > cores.html
EOT
;;

zzarrumacidade) cat <<'EOT'
zzarrumacidade
Arruma o nome da cidade informada: maiúsculas, abreviações, acentos, etc.

Uso: zzarrumacidade [cidade]
Ex.: zzarrumacidade SAO PAULO                     # São Paulo
     zzarrumacidade rj                            # Rio de Janeiro
     zzarrumacidade Floripa                       # Florianópolis
     echo Floripa | zzarrumacidade                # Florianópolis
     cat cidades.txt | zzarrumacidade             # [uma cidade por linha]
EOT
;;

zzarrumanome) cat <<'EOT'
zzarrumanome
Renomeia arquivos do diretório atual, arrumando nomes estranhos.
Obs.: Ele deixa tudo em minúsculas, retira acentuação e troca espaços em
      branco, símbolos e pontuação pelo sublinhado _.
Opções: -n  apenas mostra o que será feito, não executa
        -d  também renomeia diretórios
        -r  funcionamento recursivo (entra nos diretórios)
Uso: zzarrumanome [-n] [-d] [-r] arquivo(s)
Ex.: zzarrumanome *
     zzarrumanome -n -d -r .                   # tire o -n para renomear!
     zzarrumanome "DOCUMENTO MALÃO!.DOC"       # fica documento_malao.doc
     zzarrumanome "RAMONES - Don't Go.mp3"     # fica ramones-dont_go.mp3
EOT
;;

zzascii) cat <<'EOT'
zzascii
Mostra a tabela ASCII com todos os caracteres imprimíveis (32-126,161-255).
O formato utilizando é: <decimal> <hexa> <octal> <caractere>.
O número de colunas e a largura da tabela são configuráveis.
Uso: zzascii [colunas] [largura]
Ex.: zzascii
     zzascii 4
     zzascii 7 100
EOT
;;

zzbeep) cat <<'EOT'
zzbeep
Aguarda N minutos e dispara uma sirene usando o 'speaker'.
Útil para lembrar de eventos próximos no mesmo dia.
Sem argumentos, restaura o 'beep' para o seu tom e duração originais.
Obs.: A sirene tem 4 toques, sendo 2 tons no modo texto e apenas 1 no Xterm.
Uso: zzbeep [números]
Ex.: zzbeep 0
     zzbeep 1 5 15    # espere 1 minuto, depois mais 5, e depois 15
EOT
;;

zzbicho) cat <<'EOT'
zzbicho
Jogo do bicho.
Com um número como argumento indica o bicho e o grupo.
Se o for um número entre 1 e 25 seguido de "g", lista os números do grupo.
Sem argumento ou com apenas "g" lista todos os grupos de bichos.

Uso: zzbicho [numero] [g]
Ex.: zzbicho 123456
     zzbicho 14 g
     zzbicho g
EOT
;;

zzbissexto) cat <<'EOT'
zzbissexto
Diz se o ano informado é bissexto ou não.
Obs.: Se o ano não for informado, usa o atual.
Uso: zzbissexto [ano]
Ex.: zzbissexto
     zzbissexto 2000
EOT
;;

zzblist) cat <<'EOT'
zzblist
Mostra se o IP informado está em alguma blacklist.
Uso: zzblist IP
Ex.: zzblist 200.199.198.197
EOT
;;

zzbraille) cat <<'EOT'
zzbraille
Grafia Braille.
A estrutura básica do alfabeto braille é composta por 2 colunas e 3 linhas.
Essa estrutura é chamada de célula Braille
E a sequência numérica padronizada é como segue:
 1 4
 2 5
 3 6
Assim fica como um guia, para quem desejar implantar essa acessibilidade.

Com a opção --s1 muda o símbolo ● (relevo, em destaque, cheio)
Com a opção --s2 muda o símbolo ○ (plano, sem destaque, vazio)

Abaixo de cada célula Braille, aparece o caractere correspondente.
Incluindo especiais de maiúscula, numérico, espaço, multi-células.
+++++ : Maiúsculo
+-    : Capitalize
__    : Espaço
##    : Número
-( X ): Caractere especial que ocupa mais de uma célula Braille

Atenção: Prefira usar ! em texto dentro de aspas simples (')

Uso: zzbraille <texto> [texto]
Ex.: zzbraille 'Olá mundo!'
     echo 'Good Morning, Vietnam!' | zzbraille --s2 ' '
     zzbraille --s1 O --s2 'X' 'Um texto qualquer'
     zzbraille --s1 . --s2 ' ' Mensagem
EOT
;;

zzbrasileirao) cat <<'EOT'
zzbrasileirao
https://www.ogol.com.br
Mostra a tabela atualizada do Campeonato Brasileiro - Série A, B ou C.

Nomenclatura:
  P   - Pontos Ganhos
  J   - Jogos
  V   - Vitórias
  E   - Empates
  D   - Derrotas
  GP  - Gols Pró
  GC  - Gols Contra
  SG  - Saldo de Gols

Uso: zzbrasileirao [a|b|c]
Ex.: zzbrasileirao
     zzbrasileirao a
     zzbrasileirao b
     zzbrasileirao c
EOT
;;

zzbyte) cat <<'EOT'
zzbyte
Conversão entre grandezas de bytes (mega, giga, tera, etc).
Uso: zzbyte N [unidade-entrada] [unidade-saida]  # BKMGTPEZY
Ex.: zzbyte 2048                    # Quanto é 2048 bytes?  -- 2K
     zzbyte 2048 K                  # Quanto é 2048KB?      -- 2M
     zzbyte 7 K M                   # Quantos megas em 7KB? -- 0.006M
     zzbyte 7 G B                   # Quantos bytes em 7GB? -- 7516192768B
     for u in b k m g t p e z y; do zzbyte 2 t $u; done
EOT
;;

zzcalcula) cat <<'EOT'
zzcalcula
Calculadora.
Wrapper para o comando bc, que funciona no formato brasileiro: 1.234,56.
Obs.: Números fracionados podem vir com vírgulas ou pontos: 1,5 ou 1.5.
Use a opção --soma para somar uma lista de números vindos da STDIN.

Uso: zzcalcula operação|--soma
Ex.: zzcalcula 2,20 + 3.30          # vírgulas ou pontos, tanto faz
     zzcalcula '2^2*(4-1)'          # 2 ao quadrado vezes 4 menos 1
     echo 2 + 2 | zzcalcula         # lendo da entrada padrão (STDIN)
     zzseq 5 | zzcalcula --soma     # soma números da STDIN
EOT
;;

zzcalculaip) cat <<'EOT'
zzcalculaip
Calcula os endereços de rede e broadcast à partir do IP e máscara da rede.
Obs.: Se não especificada, será usada a máscara padrão (RFC 1918) ou 24.
Uso: zzcalculaip ip [netmask]
Ex.: zzcalculaip 127.0.0.1 24
     zzcalculaip 10.0.0.0/8
     zzcalculaip 192.168.10.0 255.255.255.240
     zzcalculaip 10.10.10.0
EOT
;;

zzcapitalize) cat <<'EOT'
zzcapitalize
Altera Um Texto Para Deixar Todas As Iniciais De Palavras Em Maiúsculas.
Use a opção -1 para converter somente a primeira letra de cada linha.
Use a opção -w para adicionar caracteres de palavra (Padrão: A-Za-z0-9áéí…)

Uso: zzcapitalize [texto]
Ex.: zzcapitalize root                             # Root
     zzcapitalize kung fu panda                    # Kung Fu Panda
     zzcapitalize -1 kung fu panda                 # Kung fu panda
     zzcapitalize quero-quero                      # Quero-Quero
     zzcapitalize água ênfase último               # Água Ênfase Último
     echo eu_uso_camel_case | zzcapitalize         # Eu_Uso_Camel_Case
     echo "i don't care" | zzcapitalize            # I Don'T Care
     echo "i don't care" | zzcapitalize -w \'      # I Don't Care
     cat arquivo.txt | zzcapitalize
EOT
;;

zzcaracoroa) cat <<'EOT'
zzcaracoroa
Exibe 'cara' ou 'coroa' aleatoriamente.
Uso: zzcaracoroa
Ex.: zzcaracoroa
EOT
;;

zzcarnaval) cat <<'EOT'
zzcarnaval
Mostra a data da terça-feira de Carnaval para qualquer ano.
Obs.: Se o ano não for informado, usa o atual.
Regra: 47 dias antes do domingo de Páscoa.
Uso: zzcarnaval [ano]
Ex.: zzcarnaval
     zzcarnaval 1999
EOT
;;

zzcep) cat <<'EOT'
zzcep
https://cep.guiamais.com.br
Busca o CEP de qualquer rua de qualquer cidade do país ou vice-versa.
Pode-se fornecer apenas o CEP, ou o endereço com estado.
Uso: zzcep <endereço estado| CEP>
Ex.: zzcep Rua Santa Ifigênia, São Paulo, SP
     zzcep 01310-000
EOT
;;

zzchavepgp) cat <<'EOT'
zzchavepgp
http://pgp.mit.edu
Busca a identificação da chave PGP, fornecido o nome ou e-mail da pessoa.
Uso: zzchavepgp nome|e-mail
Ex.: zzchavepgp Carlos Oliveira da Silva
     zzchavepgp carlos@dominio.com.br
EOT
;;

zzchecamd5) cat <<'EOT'
zzchecamd5
Checa o md5sum de arquivos baixados da net.
Nota: A função checa o arquivo no diretório corrente (./)
Uso: zzchecamd5 arquivo md5sum
Ex.: zzchecamd5 ./ubuntu-8.10.iso f9e0494e91abb2de4929ef6e957f7753
EOT
;;

zzcidade) cat <<'EOT'
zzcidade
Lista completa com todas as 5.500+ cidades do Brasil, com busca.
Obs.: Sem argumentos, mostra uma cidade aleatória.

Uso: zzcidade [palavra|regex]
Ex.: zzcidade              # mostra uma cidade qualquer
     zzcidade campos       # mostra as cidades com "Campos" no nome
     zzcidade '(SE)'       # mostra todas as cidades de Sergipe
     zzcidade ^X           # mostra as cidades que começam com X
EOT
;;

zzcinclude) cat <<'EOT'
zzcinclude
Acha as funções de uma biblioteca da linguagem C (arquivos .h).
Obs.: O diretório padrão de procura é o /usr/include.
Uso: zzcinclude nome-biblioteca
Ex.: zzcinclude stdio
     zzcinclude /minha/rota/alternativa/stdio.h
EOT
;;

zzcinemais) cat <<'EOT'
zzcinemais
http://www.cinemais.com.br
Busca horários das sessões dos filmes no site do Cinemais.
Sem argumento lista as cidades com os códigos dos cinemas.

Uso: zzcinemais [código cidade]
Ex.: zzcinemais 9
EOT
;;

zzcineuci) cat <<'EOT'
zzcineuci
http://www.ucicinemas.com.br
Exibe a programação dos cinemas UCI de sua cidade.
Se não for passado nenhum parâmetro, são listadas as cidades e cinemas.
Uso: zzcineuci [codigo_cinema]
Ex.: zzcineuci 14
EOT
;;

zzclassnum) cat <<'EOT'
zzclassnum
Classifica um número inteiro e positivo.

Uso: zzclassnum <número>
Ex.: zzclassnum 1999
EOT
;;

zzcnpj) cat <<'EOT'
zzcnpj
Cria, valida ou formata um número de CNPJ.
Obs.: O CNPJ informado pode estar formatado (pontos e hífen) ou não.
Uso: zzcnpj [-f|-F|-c|-q]  [cnpj]
Ex.: zzcnpj 12.345.678/0001-95    # valida o CNPJ informado
     zzcnpj 12345678000195        # com ou sem pontuação
     zzcnpj                       # gera um CNPJ válido (aleatório)
     zzcnpj -f 12345678000195     # formata, adicionando pontuação
     zzcnpj -F 12345678000195     # desformata, tirando pontuação
     zzcnpj -c 12345678000195     # consulta o cnpj, detalhando-o se existir
     zzcnpj -q 12345678000195     # apenas código de retorno, sem mensagens
EOT
;;

zzcodchar) cat <<'EOT'
zzcodchar
Codifica caracteres como entidades HTML e XML (&lt; &#62; ...).
Entende entidades (&gt;), códigos decimais (&#62;) e hexadecimais (&#x3E;).

Opções: --html/--xml  Codifica caracteres em códigos HTML/XML
        --hex         Codifica caracteres em códigos hexadecimais
        --dec         Codifica caracteres em códigos decimais
        -s            Com essa opção também codifica os espaços
        --listar      Mostra a listagem completa de codificação
                      Ou só a listagem da codificação escolhida

Uso: zzcodchar [-s] [--listar cod] [--html|--xml|--dec|--hex] [arquivo(s)]
Ex.: zzcodchar --html arquivo.xml
     zzcodchar --hex  arquivo.html
     cat arquivo.html | zzcodchar --dec
     zzcodchar --listar html     #  Listagem dos caracteres e códigos html
EOT
;;

zzcodq) cat <<'EOT'
zzcodq
Exibe a lista do Código Internacional Q e suas descrições.
Sem argumento só lista os código.
Com a opção --desc mostra a pergunta relacionada.
Com o código como argumento exibe sua descrição completa.

Uso: zzcodq [--desc | código Q]
Ex.: zzcodq           # Lista todos os códigos apenas.
     zzcodq --desc    # Lista todos os códigos com a pergunta associada.
     zzcodq qra       # Detalhes da pergunta e resposta para QRA
EOT
;;

zzcoin) cat <<'EOT'
zzcoin
Retorna a cotação de criptomoedas em Reais (Bitcoin, Litecoins, etc.).
Com o argumento -a ou --all mostra a cotação de todas as criptomoedas.

Uso: zzcoin [criptomoeda| -a | --all]
Ex.: zzcoin       # Lista todas as criptomoedas disponíveis
     zzcoin -a    # Cotação de todas as criptomoedas da lista
     zzcoin btc   # Cotação do Bitcoin
     zzcoin ltc   # Cotação do Litecoin
     zzcoin eth   # Cotação do Ethereum
EOT
;;

zzcolunar) cat <<'EOT'
zzcolunar
Transforma uma lista simples, em uma lista de múltiplas colunas.
É necessário informar a quantidade de colunas como argumento.

Mas opcionalmente pode informar o formato da distribuição das colunas:
-z:
  1  2  3
  4  5  6
  7  8  9
  10

-n: (padrão)
  1  5  9
  2  6  10
  3  7
  4  8

As opções -l, --left, -e, --esquerda alinham as colunas a esquerda (padrão).
As opções -r, --right, -d, --direita alinham as colunas a direita.
As opções -c, --center, --centro centralizam as colunas.
A opção -j justifica as colunas.

As opções -H ou --header usa a primeira linha como cabeçalho,
repetindo-a no início de cada coluna.

As opções -w, --width, --largura seguido de um número,
determinam a largura que as colunas terão.

A opção -s seguida de um TEXTO determina o separador de colunas,
se não for declarado assume por padrão um espaço simples.

Uso: zzcolunar [-n|-z] [-H] [-l|-r|-c|-j] [-w <largura>] <colunas> arquivo
Ex.: zzcolunar 3 arquivo.txt
     zzcolunar -c -w 20 5 arquivo.txt
     cat arquivo.txt | zzcolunar -z 4
     zzcolunar --header 3 arquivo.txt
EOT
;;

zzconfere) cat <<'EOT'
zzconfere
Confere os resultados de loterias.
quina, megasena, duplasena, lotomania, lotofácil e timemania.

Opções:
  quina:                Confere o concurso da Quina.
  megasena:             Confere o concurso da Megasena.
  duplasena:            Confere o concurso da Duplasena.
  lotomania:            Confere o concurso da Lotomania.
  lotofacil:            Confere o concurso da Lotofácil.
  timemania:            Confere o concurso da Timemania.
  sorte:                Confere o concurso do Dia da Sorte.
  -c <número>:          Consulta o concurso especificado em número.
  --apostas <arquivo>:  Arquivo onde estão as apostas feitas.

Se a opção -c não for usada, consulta o último concurso da loteria.

Se não for definido o arquivo de apostas, assume-se um arquivo com mesmo
nome da loteria com extensão ".txt" no diretório atual ou,
as apostas vierem como argumentos adicionais
com a quantidade mínima a cada loteria.

 Obs.: No arquivo usado deve haver uma aposta por linha apenas.

Uso: zzconfere  <loterias> [-c <número>] [--apostas <arquivo> | [num1] ... ]
Ex.: zzconfere megasena -c 1270
     zzconfere lotofácil --apostas /tmp/meus_palpites.txt
     zzconfere lotomania -c 550 numeros.csv
     zzconfere quina 07 12 15 28 33 45
EOT
;;

zzconjugar) cat <<'EOT'
zzconjugar
Conjuga verbo em todos os modos.
E pode-se filtrar pelo modo no segundo argumento:
 ind => Indicativo
 sub => Subjuntivo
 imp => Imperativo
 inf => Infinitivo

Ou apenas a definição do verbo se o segundo argumento for: def

Uso: zzconjugar verbo [ ind | sub | imp | inf | def ]
Ex.: zzconjugar correr
     zzconjugar comer sub
EOT
;;

zzconstantes) cat <<'EOT'
zzconstantes
Lista constantes matemáticas e físicas e unidades do SI.
Argumentos:
  -m: Apenas constantes matemáticas.
  -f: Apenas constantes físicas.
  -s: Unidades usadas no SI (Sistema Internacional de Unidades).
  -a: Dados astronômicos do Sol, Terra e Lua.
  -p: Unidades de Planck.

Obs.: Sem argumentos, mostra todas as listas.
      Se usar mais de um argumento considera apenas o último.

Uso: zzconstantes [-m|-f|-s|-a|-p]
Ex.: zzconstantes         # lista completa
     zzconstantes -f      # lista as constates físicas somente
     zzconstantes -m -a   # lista as dados astronômicos somente
EOT
;;

zzcontapalavra) cat <<'EOT'
zzcontapalavra
Conta o número de vezes que uma palavra aparece num arquivo.
Obs.: É diferente do grep -c, que não conta várias palavras na mesma linha.
Opções: -i  ignora a diferença de maiúsculas/minúsculas
        -p  busca parcial, conta trechos de palavras
Uso: zzcontapalavra [-i|-p] palavra arquivo(s)
Ex.: zzcontapalavra root /etc/passwd
     zzcontapalavra -i -p a /etc/passwd      # Compare com grep -ci a
     cat /etc/passwd | zzcontapalavra root
EOT
;;

zzcontapalavras) cat <<'EOT'
zzcontapalavras
Conta o número de vezes que cada palavra aparece em um texto.

Opções: -i       Trata maiúsculas e minúsculas como iguais, FOO = Foo = foo
        -n NÚM   Mostra apenas as NÚM palavras mais frequentes

Uso: zzcontapalavras [-i] [-n N] [arquivo(s)]
Ex.: zzcontapalavras arquivo.txt
     zzcontapalavras -i arquivo.txt
     zzcontapalavras -i -n 10 /etc/passwd
     cat arquivo.txt | zzcontapalavras
EOT
;;

zzconverte) cat <<'EOT'
zzconverte
Conversões de caracteres, temperatura, distância, ângulo, grandeza e escala.
 Opções:
  -p seguido de um número sem espaço:
     define a precisão dos resultados (casas decimais), o padrão é 2
  -e: Resposta expandida, mais explicativa.
     Obs: sem essa opção a resposta é curta, apenas o número convertivo.

Temperatura:
 cf = (C)elsius      => (F)ahrenheit  | fc = (F)ahrenheit  => (C)elsius
 ck = (C)elsius      => (K)elvin      | kc = (K)elvin      => (C)elsius
 fk = (F)ahrenheit   => (K)elvin      | kf = (K)elvin      => (F)ahrenheit

Distância:
 km = (K)Quilômetros => (M)ilhas      | mk = (M)ilhas      => (K)Quilômetros
 mj = (M)etros       => (J)ardas      | jm = (J)ardas      => (M)etros
 mp = (M)etros       => (P)és         | pm = (P)és         => (M)etros
 jp = (J)ardas       => (P)és         | pj = (P)és         => (J)ardas

Ângulo:
 gr = (G)raus        => (R)adianos    | rg = (R)adianos    => (G)raus
 ga = (G)raus        => Gr(A)dos      | ag = Gr(A)dos      => (G)raus
 ra = (R)adianos     => Gr(A)dos      | ar = Gr(A)dos      => (R)adianos

Número:
 db = (D)ecimal      => (B)inário     | bd = (B)inário     => (D)ecimal
 dc = (D)ecimal      => (C)aractere   | cd = (C)aractere   => (D)ecimal
 do = (D)ecimal      => (O)ctal       | od = (O)ctal       => (D)ecimal
 dh = (D)ecimal      => (H)exadecimal | hd = (H)exadecimal => (D)ecimal
 hc = (H)exadecimal  => (C)aractere   | ch = (C)aractere   => (H)exadecimal
 ho = (H)exadecimal  => (O)ctal       | oh = (O)ctal       => (H)exadecimal
 hb = (H)exadecimal  => (B)inário     | bh = (B)inário     => (H)exadecimal
 ob = (O)ctal        => (B)inário     | bo = (B)inário     => (O)ctal

Escala:
 Y => yotta      G => giga       d => deci       p => pico
 Z => zetta      M => mega       c => centi      f => femto
 E => exa        K => quilo      m => mili       a => atto
 P => peta       H => hecto      u => micro      z => zepto
 T => tera       D => deca       n => nano       y => yocto
 un => unidade

Uso: zzconverte [-p<número>] [-e] <código(s)> [<código>] número [número ...]
Ex.: zzconverte cf 5
     zzconverte dc 65
     zzconverte db 32 47 28
     zzconverte -p9 mp 3  # Converte metros em pés com 9 casas decimais
     zzconverte G u 32    # Converte 32 gigas em 32000000000000000 micros
     zzconverte f H 7     # Converte 7 femtos em 0.00000000000000007 hecto
     zzconverte T 4       # Converte 4 teras em 4000000000000 unidades
     zzconverte un M 3    # Converte 3 unidades em 0.000003 megas
EOT
;;

zzcores) cat <<'EOT'
zzcores
Mostra todas as combinações de cores possíveis no console.
Também mostra os códigos ANSI para obter tais combinações.
Uso: zzcores
Ex.: zzcores
EOT
;;

zzcorpuschristi) cat <<'EOT'
zzcorpuschristi
Mostra a data de Corpus Christi para qualquer ano.
Obs.: Se o ano não for informado, usa o atual.
Regra: 60 dias depois do domingo de Páscoa.
Uso: zzcorpuschristi [ano]
Ex.: zzcorpuschristi
     zzcorpuschristi 2009
EOT
;;

zzcotacao) cat <<'EOT'
zzcotacao
http://www.infomoney.com.br
Busca cotações do dia de algumas moedas em relação ao Real (compra e venda).
Uso: zzcotacao
Ex.: zzcotacao
EOT
;;

zzcpf) cat <<'EOT'
zzcpf
Cria, valida, formata ou retorna o(s) estado(s) de um número de CPF.
Obs.: O CPF informado pode estar formatado (pontos e hífen) ou não.
Uso: zzcpf [-f|-F|-e|-q] [cpf]
Ex.: zzcpf 123.456.789-09      # valida o CPF informado
     zzcpf 12345678909         # com ou sem pontuação
     zzcpf                     # gera um CPF válido (aleatório)
     zzcpf -f 12345678909      # formata, adicionando pontuação
     zzcpf -F 12345678909      # desformata, tirando pontuação
     zzcpf -e 12345678909      # estado(s) de um CPF Válido
     zzcpf -q 12345678909      # apenas código de retorno, sem mensagens
EOT
;;

zzcut) cat <<'EOT'
zzcut
Exibe partes selecionadas de linhas de cada ARQUIVO/STDIN na saída padrão.
É uma emulação do comando cut, com recursos adicionais.

Opções:
 -c LISTA    seleciona apenas estes caracteres.

 -d DELIM    usa DELIM em vez de TAB (padrão) como delimitador de campo.

 -f LISTA    seleciona somente estes campos; também exibe qualquer
             linha que não contenha o caractere delimitador.

 -s          não emite linhas que não contenham delimitadores.

 -D TEXTO    usa TEXTO como delimitador da saída
             o padrão é usar o delimitador de entrada.

 -v          Inverter o sentido, apagando as partes selecionadas.

 Obs.:  1) Se o delimitador da entrada for uma Expressão Regular,
           é recomendando declarar o delimitador de saída.
        2) Se o delimitador de entrada for ou possuir:
            - '\' (contra-barra), use '\\' (1 escape) para cada '\'.
            - '/' (barra), use '[/]' (lista em ER) para cada '/'.
        3) Se o delimitador de saída for ou possuir:
            - '\' (contra-barra), use '\\\\' (3 escapes) para cada '\'.
            - '/' (barra), use '\/' (1 escape) para cada '/'.

 Use uma, e somente uma, das opções -c ou -f.
 Cada LISTA é feita de um ou vários intervalos separados por vírgulas.
 Cada intervalo da lista exibe seu trecho, mesmo se for repetido.

 Cada intervalo pode ser:
   N     caractere ou campo na posição N, começando por 1.
   N-    Do caractere ou campo na posição N até o fim da linha.
   N-M   Do caractere ou campo na posição N até a posição M.
   -M    Do primeiro caractere ou campo até a posição M.
   -     Do primeiro caractere ou campo até ao fim da linha.
   N~M   Do caractere ou campo na posição N até o final indo em M saltos.
   ~M    Do começo até o fim da linha em M saltos de caracteres ou campos.
   d     Caractere "d", posicionar o delimitador na saida de caracteres.

Uso: zzcut <-c|-f> <número[s]|range> [-d <delimitador>] [-v]
Ex.: zzcut -c 5,2 arq.txt     # 5º caractere, seguido pelo 2º caractere
     zzcut -c 7-4,9- arq.txt  # 7º ao 4º e depois do 9º ao fim da linha
     zzcut -v -c 3-8 arq.txt  # Exclui do 3º ao 8º caractere
     zzcut -f 1,-,3  arq.txt  # 1º campo, toda linha e 3º campo
     zzcut -v -f 6-  arq.txt  # Exclui a partir do 6º campo
     zzcut -f 8,8,8 -d ";" arq.txt   # 8º campo 3 vezes. Delimitador ";"
     zzcut -f 10,6 -d: -D _ arq.txt  # 10º e 6º campos, novo delimitador _
     zzcut -c 1,d,10 -D: arq.txt     # 1º e 10º caracteres. Delimitador :
EOT
;;

zzdado) cat <<'EOT'
zzdado
Dado virtual.
Sem argumento, exibe um número aleatório entre 1 e 6.
Com o argumento -f ou --faces, pode mudar a quantidade de lados do dado.

Uso: zzdado
Ex.: zzdado
     zzdado -f 20
     zzdado --faces 12
EOT
;;

zzdata) cat <<'EOT'
zzdata
Calculadora de datas, trata corretamente os anos bissextos.
Você pode somar ou subtrair dias, meses e anos de uma data qualquer.
Você pode informar a data dd/mm/aaaa ou usar palavras como: hoje, ontem.
Usar a palavra dias informa número de dias desde o começo do ano corrente.
Ou os dias da semana como: domingo, seg, ter, qua, qui, sex, sab, dom.
Na diferença entre duas datas, o resultado é o número de dias entre elas.
Se informar somente uma data, converte para número de dias (01/01/1970 = 0).
Se informar somente um número (de dias), converte de volta para a data.
Esta função também pode ser usada para validar uma data.

Uso: zzdata [data [+|- data|número<d|m|a>]]
Ex.: zzdata                           # que dia é hoje?
     zzdata anteontem                 # que dia foi anteontem?
     zzdata dom                       # que dia será o próximo domingo?
     zzdata hoje + 15d                # que dia será daqui 15 dias?
     zzdata hoje - 40d                # e 40 dias atrás, foi quando?
     zzdata 31/12/2010 + 100d         # 100 dias após a data informada
     zzdata 29/02/2001                # data inválida, ano não-bissexto
     zzdata 29/02/2000 + 1a           # 28/02/2001 <- respeita bissextos
     zzdata 01/03/2000 - 11/11/1999   # quantos dias há entre as duas?
     zzdata hoje - 07/10/1977         # quantos dias desde meu nascimento?
     zzdata 21/12/2012 - hoje         # quantos dias para o fim do mundo?
EOT
;;

zzdataestelar) cat <<'EOT'
zzdataestelar
http://scifibrasil.com.br/data/
Calcula a data estelar, a partir de uma data e horário.

Sem argumentos calcula com a data e hora atual.

Com um argumento, calcula conforme descrito:
  Se for uma data válida, usa 0h 0min 0seg do dia.
  Se for um horário, usa a data atual.

Com dois argumentos sendo data seguida da hora.

Uso: zzdataestelar [[data|hora] | data hora]
Ex.: zzdataestelar
     zzdataestelar hoje
     zzdataestelar 25/01/2000
     zzdataestelar 13:47:26
     zzdataestelar 08/03/2010 14:25
EOT
;;

zzdatafmt) cat <<'EOT'
zzdatafmt
Muda o formato de uma data, com várias opções de personalização.
Reconhece datas em vários formatos, como aaaa-mm-dd, dd.mm.aaaa e dd/mm.
Obs.: Se você não informar o ano, será usado o ano corrente.

Use a opção -f para mudar o formato de saída (o padrão é DD/MM/AAAA):

     Código   Exemplo     Descrição
     --------------------------------------------------------------
     AAAA     2003        Ano com 4 dígitos
     AA       03          Ano com 2 dígitos
     A        3           Ano sem zeros à esquerda (1 ou 2 dígitos)
     MM       02          Mês com 2 dígitos
     M        2           Mês sem zeros à esquerda
     DD       01          Dia com 2 dígitos
     D        1           Dia sem zeros à esquerda
     --------------------------------------------------------------
     ANO      dois mil    Ano por extenso
     MES      fevereiro   Nome do mês
     MMM      fev         Nome do mês com três letras
     DIA      vinte um    Dia por extenso
     SEMANA   Domingo     Dia da semana por extenso
     SSS      Dom         Dia da semana com três letras

Use as opções de idioma para alterar os nomes dos meses. Estas opções também
mudam o formato padrão da data de saída, caso a opção -f não seja informada.
    --pt para português     --de para alemão
    --en para inglês        --fr para francês
    --es para espanhol      --it para italiano
    --ptt português textual incluindo os números
    --iso formato AAAA-MM-DD

Uso: zzdatafmt [-f formato] [data]
Ex.: zzdatafmt 2011-12-31                 # 31/12/2011
     zzdatafmt 31.12.11                   # 31/12/2011
     zzdatafmt 31/12                      # 31/12/2011     (ano atual)
     zzdatafmt -f MES hoje                # maio           (mês atual)
     zzdatafmt -f MES --en hoje           # May            (em inglês)
     zzdatafmt -f AAAA 31/12/11           # 2011
     zzdatafmt -f MM/DD/AA 31/12/2011     # 12/31/11       (BR -> US)
     zzdatafmt -f D/M/A 01/02/2003        # 1/2/3
     zzdatafmt -f "D de MES" 01/05/95     # 1 de maio
     echo 31/12/2011 | zzdatafmt -f MM    # 12             (via STDIN)
     zzdatafmt 31 de jan de 2013          # 31/01/2013     (entrada textual)
     zzdatafmt --de 19/03/2012            # 19. März 2012  (Das ist gut!)
EOT
;;

zzddd) cat <<'EOT'
zzddd
Busca o DDD de qualquer cidade do país ou vice-versa.
Pode-se fornecer apenas o DDD, cidade ou estado.

Usando o argumento -i a pesquisa altera para DDI,
podendo fornecer apenas o DDI ou o país.

Uso: zzddd <DDD | Cidade | Estado>
Ex.: zzddd 19
     zzddd Xique-Xique
     zzddd -i Brunei
     zzddd -i 75
EOT
;;

zzdiadasemana) cat <<'EOT'
zzdiadasemana
Mostra qual o dia da semana de uma data qualquer.
Com a opção -n mostra o resultado em forma numérica (domingo=1).
Obs.: Se a data não for informada, usa a data atual.
Uso: zzdiadasemana [-n] [data]
Ex.: zzdiadasemana
     zzdiadasemana 31/12/2010          # sexta-feira
     zzdiadasemana -n 31/12/2010       # 6
EOT
;;

zzdiasuteis) cat <<'EOT'
zzdiasuteis
Calcula o número de dias úteis entre duas datas, inclusive ambas.
Chamada sem argumentos, mostra os total de dias úteis no mês atual.
Obs.: Não leva em conta feriados.

Uso: zzdiasuteis [data-inicial data-final]
Ex.: zzdiasuteis                          # Fevereiro de 2013 tem 20 dias …
     zzdiasuteis 01/01/2011 31/01/2011    # 21
EOT
;;

zzdicantonimos) cat <<'EOT'
zzdicantonimos
http://www.antonimos.com.br/
Procura antônimos para uma palavra.
Uso: zzdicantonimos palavra
Ex.: zzdicantonimos bom
EOT
;;

zzdicasl) cat <<'EOT'
zzdicasl
http://www.dicas-l.unicamp.br
Procura por dicas sobre determinado assunto na lista Dicas-L.
Obs.: As opções do grep podem ser usadas (-i já é padrão).
Uso: zzdicasl [opção-grep] palavra(s)
Ex.: zzdicasl ssh
     zzdicasl -w vi
     zzdicasl -vEw 'windows|unix|emacs'
EOT
;;

zzdicbabylon) cat <<'EOT'
zzdicbabylon
http://www.babylon.com
Tradução de uma palavra em inglês para vários idiomas.
Francês, alemão, italiano, hebreu, espanhol, holandês e português.
Se nenhum idioma for informado, o padrão é o português.
Uso: zzdicbabylon [idioma] palavra   #idiomas: nl fr de he it pt es
Ex.: zzdicbabylon hardcore
     zzdicbabylon he tree
EOT
;;

zzdicesperanto) cat <<'EOT'
zzdicesperanto
http://glosbe.com
Dicionário de Esperanto em inglês, português e alemão.
Possui busca por palavra nas duas direções. O padrão é português-esperanto.

Uso: zzdicesperanto [-d pt|en|de|eo] [-p pt|en|de|eo] palavra
Ex.: zzdicesperanto esperança
     zzdicesperanto -d en job
     zzdicesperanto -d eo laboro
     zzdicesperanto -p en trabalho
EOT
;;

zzdicjargon) cat <<'EOT'
zzdicjargon
http://catb.org/jargon/
Dicionário de jargões de informática, em inglês.
Uso: zzdicjargon palavra(s)
Ex.: zzdicjargon vi
     zzdicjargon all your base are belong to us
EOT
;;

zzdicportugues) cat <<'EOT'
zzdicportugues
http://www.dicio.com.br
Dicionário de português.
Fornecendo uma "palavra" como argumento retorna seu significado e sinônimo.
Se for seguida do termo "def", retorna suas definições.

Uso: zzdicportugues palavra [def]
Ex.: zzdicportugues bolacha
     zzdicportugues comer def
EOT
;;

zzdicsinonimos) cat <<'EOT'
zzdicsinonimos
http://www.sinonimos.com.br/
Procura sinônimos para um termo.
Uso: zzdicsinonimos termo
Ex.: zzdicsinonimos deste modo
EOT
;;

zzdiffpalavra) cat <<'EOT'
zzdiffpalavra
Mostra a diferença entre dois textos, palavra por palavra.
Útil para conferir revisões ortográficas ou mudanças pequenas em frases.
Obs.: Se tiver muitas *linhas* diferentes, use o comando diff.
Uso: zzdiffpalavra arquivo1 arquivo2
Ex.: zzdiffpalavra texto-orig.txt texto-novo.txt
EOT
;;

zzdistro) cat <<'EOT'
zzdistro
Lista o ranking das distribuições no DistroWatch.
Sem argumentos lista dos últimos 6 meses
Se o argumento for 1, 3, 6 ou 12 é a ranking nos meses correspondente.
Se o argumento for 2002 até o ano passado, é a ranking final desse ano.
Se o primeiro argumento for -l, lista os links da distribuição no site.

Uso: zzdistro [-l] [meses|ano]
Ex.: zzdistro
     zzdistro 2010  # Ranking em 2010
     zzdistro 3     # Ranking dos últimos 3 meses.
     zzdistro       # Ranking dos últimos 6 meses, com os links.
EOT
;;

zzdividirtexto) cat <<'EOT'
zzdividirtexto
Divide um texto por uma quantidade máxima de palavras por linha.
Sem argumento a quantidade padrão é 15

Uso: zzdividirtexto [número]
Ex.: zzdividirtexto 10
     zzdividirtexto 3 Um texto para servir de exemplo no teste.
     cat arquivo.txt | zzdividirtexto
EOT
;;

zzdivisores) cat <<'EOT'
zzdivisores
Lista todos os divisores de um número inteiro e positivo, maior que 2.

Uso: zzdivisores <número>
Ex.: zzdivisores 1400
EOT
;;

zzdolar) cat <<'EOT'
zzdolar
http://www.infomoney.com.br
Busca a cotação do dia do dólar (comercial, turismo).
Uso: zzdolar
Ex.: zzdolar
EOT
;;

zzdominiopais) cat <<'EOT'
zzdominiopais
http://www.ietf.org/timezones/data/iso3166.tab
Busca a descrição de um código de país da internet (.br, .ca etc).
Uso: zzdominiopais [.]código|texto
Ex.: zzdominiopais .br
     zzdominiopais br
     zzdominiopais republic
EOT
;;

zzdos2unix) cat <<'EOT'
zzdos2unix
Converte arquivos texto no formato Windows/DOS (CR+LF) para o Unix (LF).
Obs.: Também remove a permissão de execução do arquivo, caso presente.
Uso: zzdos2unix arquivo(s)
Ex.: zzdos2unix frases.txt
     cat arquivo.txt | zzdos2unix
EOT
;;

zzecho) cat <<'EOT'
zzecho
Mostra textos coloridos, sublinhados e piscantes no terminal (códigos ANSI).
Opções: -f, --fundo       escolhe a cor de fundo
        -l, --letra       escolhe a cor da letra
        -p, --pisca       texto piscante
        -s, --sublinhado  texto sublinhado
        -N, --negrito     texto em negrito (brilhante em alguns terminais)
        -n, --nao-quebra  não quebra a linha no final, igual ao echo -n
Cores: preto vermelho verde amarelo azul roxo ciano branco
Obs.: \t, \n e amigos são sempre interpretados (igual ao echo -e).
Uso: zzecho [-f cor] [-l cor] [-p] [-s] [-N] [-n] [texto]
Ex.: zzecho -l amarelo Texto em amarelo
     zzecho -f azul -l branco -N Texto branco em negrito, com fundo azul
     zzecho -p -s Texto piscante e sublinhado
EOT
;;

zzencoding) cat <<'EOT'
zzencoding
Informa qual a codificação de um arquivo (ou texto via STDIN).

Uso: zzencoding [arquivo]
Ex.: zzencoding /etc/passwd          # us-ascii
     zzencoding index-iso.html       # iso-8859-1
     echo FooBar | zzencoding        # us-ascii
     echo Bênção | zzencoding        # utf-8
EOT
;;

zzenglish) cat <<'EOT'
zzenglish
http://www.dict.org
Busca definições em inglês de palavras da língua inglesa em DICT.org.
Uso: zzenglish palavra-em-inglês
Ex.: zzenglish momentum
EOT
;;

zzestado) cat <<'EOT'
zzestado
Lista os estados do Brasil e suas capitais.
Obs.: Sem argumentos, mostra a lista completa.

Opções: --sigla        Mostra somente as siglas
        --nome         Mostra somente os nomes
        --capital      Mostra somente as capitais
        --slug         Mostra somente os slugs (nome simplificado)
        --formato FMT  Você escolhe o formato de saída, use os tokens:
                       {sigla}, {nome}, {capital}, {slug}, \n , \t
        --python       Formata como listas/dicionários do Python
        --javascript   Formata como arrays do JavaScript
        --php          Formata como arrays do PHP
        --html         Formata usando a tag <SELECT> do HTML
        --xml          Formata como arquivo XML
        --url,--url2   Exemplos simples de uso da opção --formato

Uso: zzestado [opção]
Ex.: zzestado                      # [mostra a lista completa]
     zzestado --sigla              # AC AL AP AM BA …
     zzestado --html               # <option value="AC">AC - Acre</option> …
     zzestado --python             # siglas = ['AC', 'AL', 'AP', …
     zzestado --formato '{sigla},'             # AC,AL,AP,AM,BA,…
     zzestado --formato '{sigla} - {nome}\n'   # AC - Acre …
     zzestado --formato '{capital}-{sigla}\n'  # Rio Branco-AC …
EOT
;;

zzexcuse) cat <<'EOT'
zzexcuse
Da uma desculpa comum de desenvolvedor ( em ingles ).

Uso: zzexcuse
Ex.: zzexcuse
EOT
;;

zzextensao) cat <<'EOT'
zzextensao
Informa a extensão de um arquivo.
Obs.: Caso o arquivo não possua extensão, retorna vazio "".
Uso: zzextensao arquivo
Ex.: zzextensao /tmp/arquivo.txt       # resulta em "txt"
     zzextensao /tmp/arquivo           # resulta em ""
EOT
;;

zzf1) cat <<'EOT'
zzf1
Mostra a classificação de pilotos e construtores da F1.

Opções:
  -p: Mostra apenas a classificação por pilotos.
  -c: Mostra apenas a classificação por construtores.
  ano: Seleciona o ano da classificação.

Sem as opções -p e -c mostra ambos.
Sem escolher um ano espefífico, exibe o mais atual.

Uso: zzf1 [-p|-c] [ano]
Ex.: zzf1
     zzf1 -p        # Mais recente classificação de pilotos.
     zzf1 -c        # Mais recente classificação de construtores.
     zzf1 2017      # Classificação de pilotos e construtores em 2017.
     zzf1 -p 2015   # Classificação de pilotos em 2015.
EOT
;;

zzfatorar) cat <<'EOT'
zzfatorar
Fatora um número em fatores primos.
Com as opções:
  --bc: saída apenas da expressão, que pode ser usado no bc, awk ou etc.
  --no-bc: saída apenas do fatoramento.
   por padrão exibe tanto o fatoramento como a expressão.

Se o número for primo, é exibido a mensagem apenas.

Uso: zzfatorar [--bc | --no-bc] <número>
Ex.: zzfatorar 1458
     zzfatorar --bc 1296
EOT
;;

zzfeed) cat <<'EOT'
zzfeed
Leitor de Feeds RSS, RDF e Atom.
Se informar a URL de um feed, são mostradas suas últimas notícias.
Se informar a URL de um site, mostra a URL do(s) Feed(s).

Opções:
 -n para limitar o número de resultados (Padrão é 10).
 -u para simular navegador Mozilla/Firefox (alguns sites precisam disso).

Para uso via pipe digite dessa forma: "zzfeed -", mesma forma que o cat.

Uso: zzfeed [-n número] URL...
Ex.: zzfeed http://aurelio.net/feed/
     zzfeed -n 5 aurelio.net/feed/          # O http:// é opcional
     zzfeed aurelio.net funcoeszz.net       # Mostra URL dos feeds
     zzfeed -u funcoeszz.net                # UserAgent do lynx diferente
     cat arquivo.rss | zzfeed -             # Para uso via pipe
EOT
;;

zzferiado) cat <<'EOT'
zzferiado
Verifica se a data passada por parâmetro é um feriado ou não.
Caso não seja passado nenhuma data é pego a data atual.
Pode-se configurar a variável ZZFERIADO para os feriados regionais.
O formato é o dd/mm:descrição, por exemplo: 20/11:Consciência negra.
Uso: zzferiado -l [ano] | [data]
Ex.: zzferiado 25/12/2008
     zzferiado -l
     zzferiado -l 2010
EOT
;;

zzfilme) cat <<'EOT'
zzfilme
Busca informações sobre o filme desejado.

Uso: zzfilme FILME
Ex.: zzfilme matrix
     zzfilme 'matrix revolutions'
EOT
;;

zzfoneletra) cat <<'EOT'
zzfoneletra
Conversão de telefones contendo letras para apenas números.
Uso: zzfoneletra telefone
Ex.: zzfoneletra 2345-LINUX              # Retorna 2345-54689
     echo 5555-HELP | zzfoneletra        # Retorna 5555-4357
EOT
;;

zzfrenteverso2pdf) cat <<'EOT'
zzfrenteverso2pdf
Combina 2 arquivos, frentes.pdf e versos.pdf, em um único frenteverso.pdf.
Opções:
  -rf, --frentesreversas  informa ordem reversa no arquivo frentes.pdf.
  -rv, --versosreversos   informa ordem reversa no arquivo versos.pdf.
   -d, --diretorio        informa o diretório de entrada/saída. Padrão=".".
   -v, --verbose          exibe informações de debug durante a execução.
Uso: zzfrenteverso2pdf [-rf] [-rv] [-d diretorio]
Ex.: zzfrenteverso2pdf
     zzfrenteverso2pdf -rf
     zzfrenteverso2pdf -rv -d "/tmp/dir_teste"
EOT
;;

zzfutebol) cat <<'EOT'
zzfutebol
https://www.ogol.com.br
Mostra todos os jogos de futebol marcados para os próximos dias.
Ou os resultados de jogos recentes.
Além de mostrar os times que jogam, o script também mostra o dia,
o horário e por qual campeonato será ou foi o jogo.

Suporta um argumento que pode ser um dos dias da semana, como:
 hoje, amanhã, segunda, terça, quarta, quinta, sexta, sábado, domingo.

Ou um ou dois argumentos para ver resultados do jogos:
  resultado ou placar, que pode ser acompanhado de hoje, ontem, anteontem.

Nos casos dos dias, podem ser usadas datas no formato DD/MM/AAAA.

Um filtro com nome do campeonato, nome do time, ou horário de uma partida.

Uso: zzfutebol [resultado | placar ] [ argumento ]
Ex.: zzfutebol                 # Todas as partidas nos próximos dias.
     zzfutebol hoje            # Partidas que acontecem hoje.
     zzfutebol sabado          # Partidas que acontecem no sábado.
     zzfutebol libertadores    # Próximas partidas da Libertadores.
     zzfutebol resultado       # Placar dos jogos já ocorridos.
     zzfutebol placar ontem    # Placar dos jogos de ontem.
     zzfutebol placar espanhol # Placar dos jogos do Campeonato Espanhol.
EOT
;;

zzgeoip) cat <<'EOT'
zzgeoip
Localiza geograficamente seu IP de Internet ou um que seja informado.
Uso: zzgeoip [ip]
Ex.: zzgeoip
     zzgeoip 187.75.22.192
EOT
;;

zzglobo) cat <<'EOT'
zzglobo
Mostra a programação da Rede Globo do dia.
Uso: zzglobo
Ex.: zzglobo
EOT
;;

zzgravatar) cat <<'EOT'
zzgravatar
http://www.gravatar.com
Monta a URL completa para o Gravatar do email informado.

Opções: -t, --tamanho N      Tamanho do avatar (padrão 80, máx 512)
        -d, --default TIPO   Tipo do avatar substituto, se não encontrado

Se não houver um avatar para o email, a opção --default informa que tipo
de avatar substituto será usado em seu lugar:
    mm          Mistery Man, a silhueta de uma pessoa (não muda)
    identicon   Padrão geométrico, muda conforme o email
    monsterid   Monstros, muda cores e rostos
    wavatar     Rostos, muda características e cores
    retro       Rostos pixelados, tipo videogame antigo 8-bits
Veja exemplos em http://gravatar.com/site/implement/images/

Uso: zzgravatar [--tamanho N] [--default tipo] email
Ex.: zzgravatar fulano@dominio.com.br
     zzgravatar -t 128 -d mm fulano@dominio.com.br
     zzgravatar --tamanho 256 --default retro fulano@dominio.com.br
EOT
;;

zzhexa2str) cat <<'EOT'
zzhexa2str
Converte os bytes em hexadecimal para a string equivalente.
Uso: zzhexa2str [bytes]
Ex.: zzhexa2str 40 4d 65 6e 74 65 42 69 6e 61 72 69 61   # sem prefixo
     zzhexa2str 0x42 0x69 0x6E                           # com prefixo 0x
     echo 0x42 0x69 0x6E | zzhexa2str
EOT
;;

zzhora) cat <<'EOT'
zzhora
Faz cálculos com horários.
A opção -r torna o cálculo relativo à primeira data, por exemplo:
  02:00 - 03:30 = -01:30 (sem -r) e 22:30 (com -r)

Uso: zzhora [-r] hh:mm [+|- hh:mm] ...
Ex.: zzhora 8:30 + 17:25        # preciso somar dois horários
     zzhora 12:00 - agora       # quando falta para o almoço?
     zzhora -12:00 + -5:00      # horas negativas!
     zzhora 1000                # quanto é 1000 minutos?
     zzhora -r 5:30 - 8:00      # que horas ir dormir para acordar às 5:30?
     zzhora -r agora + 57:00    # e daqui 57 horas, será quando?
     zzhora 1:00 + 2:00 + 3:00 - 4:00 - 0:30   # cálculos múltiplos
EOT
;;

zzhoracerta) cat <<'EOT'
zzhoracerta
http://www.worldtimeserver.com
Mostra a hora certa de um determinado local.
Se nenhum parâmetro for passado, são listados as localidades disponíveis.
O parâmetro pode ser tanto a sigla quando o nome da localidade.
A opção -s realiza a busca somente na sigla.
Uso: zzhoracerta [-s] local
Ex.: zzhoracerta rio grande do sul
     zzhoracerta -s br
     zzhoracerta rio
     zzhoracerta us-ny
EOT
;;

zzhoramin) cat <<'EOT'
zzhoramin
Converte horas em minutos.
Obs.: Se não informada a hora, usa o horário atual para o cálculo.
Uso: zzhoramin [hh:mm]
Ex.: zzhoramin
     zzhoramin 10:53       # Retorna 653
     zzhoramin -10:53      # Retorna -653
EOT
;;

zzhorariodeverao) cat <<'EOT'
zzhorariodeverao
Mostra as datas de início e fim do horário de verão.
Obs.: Ano de 2008 em diante. Se o ano não for informado, usa o atual.
Regra: 3º domingo de outubro/fevereiro, exceto carnaval (4º domingo).
Uso: zzhorariodeverao [ano]
Ex.: zzhorariodeverao
     zzhorariodeverao 2009
EOT
;;

zzhoroscopo) cat <<'EOT'
zzhoroscopo
http://m.horoscopovirtual.bol.uol.com.br/horoscopo/
Consulta o horóscopo do dia.
Deve ser informado o signo que se deseja obter a previsão.

Signos: aquário, peixes, áries, touro, gêmeos, câncer, leão,
        virgem, libra, escorpião, sagitário, capricórnio

Uso: zzhoroscopo <signo>
Ex.: zzhoroscopo sagitário    # exibe a previsão para o signo de sagitário
EOT
;;

zzhowto) cat <<'EOT'
zzhowto
http://www.ibiblio.org
Procura documentos do tipo HOWTO.
Uso: zzhowto [--atualiza] palavra
Ex.: zzhowto apache
     zzhowto --atualiza
EOT
;;

zzhsort) cat <<'EOT'
zzhsort
Ordenar palavras ou números horizontalmente.
Opções:
  -r                              define o sentido da ordenação reversa.
  -d <sep>                        define o separador de campos na entrada.
  -D, --output-delimiter <sep>  define o separador de campos na saída.

O separador na entrada pode ser 1 ou mais caracteres ou uma ER.
Se não for declarado assume-se espaços em branco como separador.
Conforme padrão do awk, o default seria FS = "[ \t]+".

Se o separador de saída não for declarado, assume o mesmo da entrada.
Caso a entrada também não seja declarada assume-se como um espaço.
Conforme padrão do awk, o default é OFS = " ".

Se o separador da entrada é uma ER, é bom declarar o separador de saída.

Uso: zzhsort [-d <sep>] [-D | --output-delimiter <sep>] <Texto>
Ex.: zzhsort "isso está desordenado"            # desordenado está isso
     zzhsort -r -d ":" -D "-" "1:a:z:x:5:o"  # z-x-o-a-5-1
     cat num.txt | zzhsort -d '[\t:]' --output-delimiter '\t'
EOT
;;

zzimc) cat <<'EOT'
zzimc
Calcula o valor do IMC correspodente a sua estrutura corporal.

Uso: zzimc <peso_em_KG> <altura_em_metros>
Ex.: zzimc 108.5 1.73
EOT
;;

zziostat) cat <<'EOT'
zziostat
Monitora a utilização dos discos no Linux.

Opções:
  -n [número]    Quantidade de medições (padrão = 10; contínuo = 0)
  -t [número]    Mostra apenas os discos mais utilizados
  -i [segundos]  Intervalo em segundos entre as coletas
  -d [discos]    Mostra apenas os discos que começam com a string passada
                 O padrão é 'sd'
  -o [trwT]      Ordena os discos por:
                     t (tps)
                     r (read/s)
                     w (write/s)
                     T (total/s = read/s+write/s)

Obs.: Se não for usada a opção -t, é mostrada a soma da utilização
      de todos os discos.

Uso: zziostat [-t número] [-i segundos] [-d discos] [-o trwT]
Ex.: zziostat
     zziostat -n 15
     zziostat -t 10
     zziostat -i 5 -o T
     zziostat -d emcpower
EOT
;;

zzipinternet) cat <<'EOT'
zzipinternet
Mostra o seu número IP (externo) na Internet.
Uso: zzipinternet
Ex.: zzipinternet
EOT
;;

zzipv6) cat <<'EOT'
zzipv6
Consulta os endereços de rede de IPv6 e do comprimento do prefixo (subnet).
Obs.: Se não especificado, será usado o comprimento do prefixo de 64.
      O comprimento do prefixo é um número entre 1 e 128.

Uso: zzipv6 IPv6 [subnet]
Ex.: zzipv6 fe80::4fae:e655:afc3:7d20 56
     zzipv6 fe80:3cde:7d20:e655::afc3:/127
     zzipv6 4fae:afc3:0:0:fe80:e655:3cde:7d20
EOT
;;

zzit) cat <<'EOT'
zzit
Uma forma de ler o site Inovação Tecnológica.
Sem opção mostra o resumo da página principal.

Opções podem ser (ano)sub-temas e/ou número:

Sub-temas podem ser:
  eletronica, energia, espaco, informatica, materiais,
  mecanica, meioambiente, nanotecnologia, robotica, plantao.
 Que podem ser precedido do ano ao qual se quer listar

Se a opção for um número mostra a matéria selecionada,
seja da página principal ou de um sub-tema.

Uso: zzit [[ano] sub-tema] [número]
Ex.: zzit                 # Um resumo da página principal
     zzit espaco          # Um resumo do sub-tem espaço
     zzit 3               # Exibe a terceira matéria da página principal
     zzit mecanica 7      # Exibe a sétima matéria do sub-tema mecânica
     zzit 2003 energia    # Um resumo do sub-tema energia em 2003
     zzit 2012 plantao 2  # Exibe a 2ª matéria de 2012 no sub-tema plantao
EOT
;;

zzjoin) cat <<'EOT'
zzjoin
Junta as linhas de 2 ou mais arquivos, mantendo a sequência.
Opções:
 -o <arquivo> - Define o arquivo de saída.
 -m - Toma como base o arquivo com menos linhas.
 -M - Toma como base o arquivo com mais linhas.
 -<numero> - Toma como base o arquivo na posição especificada.
 -d - Define o separador entre as linhas dos arquivos juntados (padrão TAB).

Sem opção, toma como base o primeiro arquivo declarado.

Uso: zzjoin [-m | -M | -<numero>] [-o <arq>] [-d <sep>] arq1 arq2 [arqN] ...
Ex.: zzjoin -m arq1 arq2 arq3      # Base no arquivo com menos linhas
     zzjoin -2 arq1 arq2 arq3      # Base no segundo arquivo
     zzjoin -o out.txt arq1 arq2   # Juntando para o arquivo out.txt
     zzjoin -d ":" arq1 arq2       # Juntando linhas separadas por ":"
EOT
;;

zzjquery) cat <<'EOT'
zzjquery
Exibe a descrição da função jQuery informada.

Opções:
  --categoria[s]: Lista as Categorias da funções.
  --lista: Lista todas as funções.
  --lista <categoria>: Listas as funções dentro da categoria informada.

Caso não seja passado o nome, serão exibidas informações acerca do $().
Se usado o argumento -s, será exibida somente a sintaxe.
Uso: zzjquery [-s] função
Ex.: zzjquery gt
     zzjquery -s gt
EOT
;;

zzjuntalinhas) cat <<'EOT'
zzjuntalinhas
Junta várias linhas em uma só, podendo escolher o início, fim e separador.

Melhorias em relação ao comando paste -s:
- Trata corretamente arquivos no formato Windows (CR+LF)
- Lê arquivos ISO-8859-1 sem erros no Mac (o paste dá o mesmo erro do tr)
- O separador pode ser uma string, não está limitado a um caractere
- Opções -i e -f para delimitar somente um trecho a ser juntado

Opções: -d sep        Separador a ser colocado entre as linhas (padrão: Tab)
        -i, --inicio  Início do trecho a ser juntado (número ou regex)
        -f, --fim     Fim do trecho a ser juntado (número ou regex)

Uso: zzjuntalinhas [-d separador] [-i texto] [-f texto] arquivo(s)
Ex.: zzjuntalinhas arquivo.txt
     zzjuntalinhas -d @@@ arquivo.txt             # junta toda as linhas
     zzjuntalinhas -d : -i 10 -f 20 arquivo.txt   # junta linhas 10 a 20
     zzjuntalinhas -d : -i 10 arquivo.txt         # junta linha 10 em diante
     cat /etc/named.conf | zzjuntalinhas -d '' -i '^[a-z]' -f '^}'
EOT
;;

zzlblank) cat <<'EOT'
zzlblank
Elimina espaços excedentes no início, mantendo alinhamento.
por padrão transforma todos os TABs em 4 espaços para uniformização.
Um número como argumento especifica a quantidade de espaços para cada TAB.
Caso use a opção -s, apenas espaços iniciais serão considerados.
Caso use a opção -t, apenas TABs iniciais serão considerados.
 Obs.: Com as opções -s e -t não há a conversão de tabs para espaço.

Uso: zzlblank [-s|-t|<número>] arquivo.txt
Ex.: zzlblank arq.txt     # Espaços e tabs iniciais
     zzlblank -s arq.txt  # Apenas espaços iniciais
     zzlblank -t arq.txt  # Apenas tabs iniciais
     zzlblank 12 arq.txt  # Tabs são convertidos em 12 espaços
     cat arq.txt | zzlblank
EOT
;;

zzlembrete) cat <<'EOT'
zzlembrete
Sistema simples de lembretes: cria, apaga e mostra.
Uso: zzlembrete [texto]|[número [d]]
Ex.: zzlembrete                      # Mostra todos
     zzlembrete 5                    # Mostra o 5º lembrete
     zzlembrete 5d                   # Deleta o 5º lembrete
     zzlembrete Almoço com a sogra   # Adiciona lembrete
EOT
;;

zzlibertadores) cat <<'EOT'
zzlibertadores
Mostra a classificação e jogos do torneio Libertadores da América.

Nomenclatura:
 P   - Pontos Ganhos
 J   - Jogos

Obs.: Se usar a opção --atualiza, o cache usado é renovado.

Uso: zzlibertadores
Ex.: zzlibertadores            # Classificação dos grupos e jogos mata-mata.
     zzlibertadores --atualiza # Atualiza o cache.
EOT
;;

zzlimpalixo) cat <<'EOT'
zzlimpalixo
Retira linhas em branco e comentários.
Para ver rapidamente quais opções estão ativas num arquivo de configuração.
Além do tradicional #, reconhece comentários de vários tipos de arquivos.
 vim, asp, asm, ada, sql, e, bat, tex, c, css, html, cc, d, js, php, scala.
E inclui os comentários multilinhas (/* ... */), usando opção --multi.
Obs.: Aceita dados vindos da entrada padrão (STDIN).
Uso: zzlimpalixo [--multi] [arquivos]
Ex.: zzlimpalixo ~/.vimrc
     cat /etc/inittab | zzlimpalixo
EOT
;;

zzlinha) cat <<'EOT'
zzlinha
Mostra uma linha de um texto, aleatória ou informada pelo número.
Obs.: Se passado um argumento, restringe o sorteio às linhas com o padrão.
Uso: zzlinha [número | -t texto] [arquivo(s)]
Ex.: zzlinha /etc/passwd           # mostra uma linha qualquer, aleatória
     zzlinha 9 /etc/passwd         # mostra a linha 9 do arquivo
     zzlinha -2 /etc/passwd        # mostra a penúltima linha do arquivo
     zzlinha -t root /etc/passwd   # mostra uma das linhas com "root"
     cat /etc/passwd | zzlinha     # o arquivo pode vir da entrada padrão
EOT
;;

zzlinux) cat <<'EOT'
zzlinux
http://www.kernel.org/kdist/finger_banner
Mostra as versões disponíveis do Kernel Linux.
Uso: zzlinux
Ex.: zzlinux
EOT
;;

zzlinuxnews) cat <<'EOT'
zzlinuxnews
Busca as últimas notícias sobre Linux em sites em inglês.
Obs.: Cada site tem uma letra identificadora que pode ser passada como
      parâmetro, para informar quais sites você quer pesquisar:

         S)lashDot            Linux T)oday
         O)S News             Linux W)eekly News
         Linux I)nsider       Linux N)ews
         Linux J)ournal       X) LXer Linux News

Uso: zzlinuxnews [sites]
Ex.: zzlinuxnews
     zzlinuxnews ts
EOT
;;

zzlocale) cat <<'EOT'
zzlocale
Busca o código do idioma (locale) - por exemplo, português é pt_BR.
Com a opção -c, pesquisa somente nos códigos e não em sua descrição.
Uso: zzlocale [-c] código|texto
Ex.: zzlocale chinese
     zzlocale -c pt
EOT
;;

zzlorem) cat <<'EOT'
zzlorem
Gerador de texto de teste, em latim (Lorem ipsum...).
Texto obtido em http://br.lipsum.com/

Uso: zzlorem [número-de-palavras]
Ex.: zzlorem 10
EOT
;;

zzloteria) cat <<'EOT'
zzloteria
Resultados da quina megasena duplasena lotomania lotofacil federal timemania loteca lotogol sorte sete.

Se o 2º argumento for um número, pesquisa o resultado filtrando o concurso.
Se o 2º argumento for a palavra "quantidade" ou "qtde" mostra quantas vezes
 um número foi sorteado.
( Não se aplica para federal, loteca, lotogol, sorte, sete)
Se nenhum argumento for passado, todas as loterias são mostradas.

Uso: zzloteria [[loterias suportadas] [concurso|[quantidade|qtde]]
Ex.: zzloteria
     zzloteria quina megasena
     zzloteria loteca 550
     zzloteria quina qtde
EOT
;;

zzlua) cat <<'EOT'
zzlua
http://www.lua.org/manual/5.1/pt/manual.html
Lista de funções da linguagem Lua.
com a opção -d ou --detalhe busca mais informação da função
com a opção --atualiza força a atualização do cache local

Uso: zzlua <palavra|regex>
Ex.: zzlua --atualiza        # Força atualização do cache
     zzlua file              # mostra as funções com "file" no nome
     zzlua -d debug.debug    # mostra descrição da função debug.debug
     zzlua ^d                # mostra as funções que começam com d
EOT
;;

zzmacaddress) cat <<'EOT'
zzmacaddress
Mostra os MAC address disponíveis.
Uso: zzmacaddress
Ex.: zzmacaddress
EOT
;;

zzmacvendor) cat <<'EOT'
zzmacvendor
Mostra o fabricante do equipamento utilizando o endereço MAC.

Uso: zzmacvendor <MAC Address>
Ex.: zzmacvendor 88:5A:92:C7:41:40
     zzmacvendor 88-5A-92-C7-41-40
EOT
;;

zzmaiores) cat <<'EOT'
zzmaiores
Acha os maiores arquivos/diretórios do diretório atual (ou outros).
Opções: -r  busca recursiva nos subdiretórios
        -f  busca somente os arquivos e não diretórios
        -n  número de resultados (o padrão é 10)
Uso: zzmaiores [-r] [-f] [-n <número>] [dir1 dir2 ...]
Ex.: zzmaiores
     zzmaiores /etc /tmp
     zzmaiores -r -n 5 ~
EOT
;;

zzmaiusculas) cat <<'EOT'
zzmaiusculas
Converte todas as letras para MAIÚSCULAS, inclusive acentuadas.
Uso: zzmaiusculas [texto]
Ex.: zzmaiusculas eu quero gritar                # via argumentos
     echo eu quero gritar | zzmaiusculas         # via STDIN
EOT
;;

zzmariadb) cat <<'EOT'
zzmariadb
Lista alguns dos comandos já traduzidos do banco MariaDB, numerando-os.
Pesquisa detalhe dos comando, ao fornecer o número na listagem a esquerda.
E filtra a busca se fornecer um texto.

Uso: zzmariadb [ código | filtro ]
Ex.: zzmariadb        # Lista os comandos disponíveis
     zzmariadb 18     # Consulta o comando DROP USER
     zzmariadb alter  # Filtra os comandos que possuam alter na declaração
EOT
;;

zzmat) cat <<'EOT'
zzmat
Uma coletânea de funções matemáticas simples.
Se o primeiro argumento for um '-p' seguido de número sem espaço
define a precisão dos resultados ( casas decimais ), o padrão é 6
Em cada função foi colocado um pequeno help um pouco mais detalhado,
pois ficou muito extenso colocar no help do zzmat apenas.

Funções matemáticas disponíveis.
Aritméticas:               | Trigonométricas:
 mmc    mdc                |  sen   cos   tan
 media  soma  produto      |  csc   sec   cot
 log    ln    raiz         |  asen  acos  atan
 somatoria    produtoria
 pow, potencia ou elevado

Combinatória:        | Sequências:          | Funções:
 fat                 |  pa  pa2  pg  lucas  |  area  volume  r3
 arranjo  arranjo_r  |  fibonacci  ou fib   |  det   vetor   d2p
 combinacao          |  tribonacci ou trib
 combinacao_r        |  mersenne  recaman  collatz

Equações:                  | Auxiliares:
 eq2g  egr    err          |  abs  int
 egc   egc3p  ege          |  sem_zeros
 newton ou binomio_newton  |  aleatorio  random
 conf_eq                   |  compara_num

Mais detalhes: zzmat função

Uso: zzmat [-pnumero] funções [número] [número]
Ex.: zzmat mmc 8 12
     zzmat media 5[2] 7 4[3]
     zzmat somatoria 3 9 2x+3
     zzmat -p3 sen 60g
EOT
;;

zzmcd) cat <<'EOT'
zzmcd
Cria diretórios e subdiretórios, e muda diretório de trabalho (primeiro).

Opções:
     -n: Cria os diretórios, mas não muda o diretório de trabalho atual.
     -s: Apenas simula o comando mkdir com os argumentos

Uso: zzmcd [-n|-s] <dir[/subdir]> [dir[/subdir]]
Ex.: zzmcd tmp1/tmp2
EOT
;;

zzmd5) cat <<'EOT'
zzmd5
Calcula o código MD5 dos arquivos informados, ou de um texto via STDIN.
Obs.: Wrapper portável para os comandos md5 (Mac) e md5sum (Linux).

Uso: zzmd5 [arquivo(s)]
Ex.: zzmd5 arquivo.txt
     cat arquivo.txt | zzmd5
EOT
;;

zzminiurl) cat <<'EOT'
zzminiurl
Encurta uma URL utilizando o bit.ly ("https://bit.ly/").
Caso a URL já seja encurtada, será exibida a URL completa.
Obs.: Se a URL não tiver protocolo no início, será colocado http://
Uso: zzminiurl URL
Ex.: zzminiurl http://www.funcoeszz.net
     zzminiurl www.funcoeszz.net         # O http:// no início é opcional
     zzminiurl http://bit.ly/2qysTH4
EOT
;;

zzminusculas) cat <<'EOT'
zzminusculas
Converte todas as letras para minúsculas, inclusive acentuadas.
Uso: zzminusculas [texto]
Ex.: zzminusculas NÃO ESTOU GRITANDO             # via argumentos
     echo NÃO ESTOU GRITANDOO | zzminusculas     # via STDIN
EOT
;;

zzmix) cat <<'EOT'
zzmix
Mistura linha a linha 2 ou mais arquivos, mantendo a sequência.
Opções:
 -o <arquivo> - Define o arquivo de saída.
 -m - Toma como base o arquivo com menos linhas.
 -M - Toma como base o arquivo com mais linhas.
 -<numero> - Toma como base o arquivo na posição especificada.
 -p <relação de linhas> - numero de linhas de cada arquivo de origem.
   Obs1.: A relação são números de linhas de cada arquivo correspondente na
          sequência, justapostos separados por vírgula (,).
   Obs2.: Se a quantidade de linhas na relação for menor que a quantidade de
          arquivos, os arquivos excedentes adotam a último valor na relação.

Sem opção, toma como base o primeiro arquivo declarado.

Uso: zzmix [-m | -M | -<num>] [-o <arq>] [-p <relação>] arq1 arq2 [arqN] ...
Ex.: zzmix -m arquivo1 arquivo2 arquivo3  # Base no arquivo com menos linhas
     zzmix -2 arquivo1 arquivo2 arquivo3  # Base no segundo arquivo
     zzmix -o out.txt arquivo1 arquivo2   # Mixando para o arquivo out.txt
     zzmix -p 2,5,6 arq1 arq2 arq3
     # 2 linhas do arq1, 5 linhas do arq2 e 6 linhas do arq3,
     # e repete a sequência até o final.
EOT
;;

zzmoneylog) cat <<'EOT'
zzmoneylog
Consulta lançamentos do Moneylog, com pesquisa avançada e saldo total.
Obs.: Chamado sem argumentos, pesquisa o mês corrente.
Obs.: Não expande lançamentos recorrentes e parcelados.

Uso: zzmoneylog [-d data] [-v valor] [-t tag] [--total] [texto]
Ex.: zzmoneylog                       # Todos os lançamentos deste mês
     zzmoneylog mercado               # Procure por mercado
     zzmoneylog -t mercado            # Lançamentos com a tag mercado
     zzmoneylog -t mercado -d 2011    # Tag mercado em 2011
     zzmoneylog -t mercado --total    # Saldo total da tag mercado
     zzmoneylog -d 31/01/2011         # Todos os lançamentos desta data
     zzmoneylog -d 2011               # Todos os lançamentos de 2011
     zzmoneylog -d ontem              # Todos os lançamentos de ontem
     zzmoneylog -d mes                # Todos os lançamentos deste mês
     zzmoneylog -d mes --total        # Saldo total deste mês
     zzmoneylog -d 2011-0[123]        # Regex: que casa Jan/Fev/Mar de 2011
     zzmoneylog -v /                  # Todos os pagamentos parcelados
EOT
;;

zzmudaprefixo) cat <<'EOT'
zzmudaprefixo
Move os arquivos que tem um prefixo comum para um novo prefixo.
Opções:
  -a, --antigo informa o prefixo antigo a ser trocado.
  -n, --novo   informa o prefixo novo a ser trocado.
Uso: zzmudaprefixo -a antigo -n novo
Ex.: zzmudaprefixo -a "antigo_prefixo" -n "novo_prefixo"
     zzmudaprefixo -a "/tmp/antigo_prefixo" -n "/tmp/novo_prefixo"
EOT
;;

zznatal) cat <<'EOT'
zznatal
http://www.ibb.org.br/vidanet
A mensagem "Feliz Natal" em vários idiomas.
Uso: zznatal [palavra]
Ex.: zznatal                   # busca um idioma aleatório
     zznatal russo             # Feliz Natal em russo
EOT
;;

zznerdcast) cat <<'EOT'
zznerdcast
Lista os episódios do podcast NerdCast.

Opções para a listagem:
  -n <número> - Quantidade de resultados retornados (padrão = 15)
  -d <data>   - Filtra por uma data específica.
  -m <mês>    - Filtra por um mês específico. Sem o ano seleciona atual.
  -a <ano>    - Filtra por um ano em específico.

  Obs.: No lugar de -d, -m, -a pode usar --data, --mês ou --mes, --ano.
        Na opção -d, <data> pode ser "hoje", "ontem" e "anteontem".
        Na opção -n, <número> se for igual a 0, não limita a quantidade.

  Opções adicionais são consideradas termos a serem filtrados na consulta.

Uso: zznerdcast [-n <número>| -d <data> | -m <mês>| -a <ano>] [texto]
Ex.: zznerdcast
     zznerdcast -n 30
     zznerdcast -d 28.10.16
     zznerdcast -m 5/2014
     zznerdcast -a 2014 Empreendedor
     zznerdcast Terra
EOT
;;

zznome) cat <<'EOT'
zznome
http://www.significado.origem.nom.br/
Dicionário de nomes, com sua origem, numerologia e arcanos do tarot.
Pode-se filtrar por significado, origem, letra (primeira letra), tarot
marca (no mundo), numerologia ou tudo - como segundo argumento (opcional).
Por padrão lista origem e significado.

Uso: zznome nome [significado|origem|letra|marca|numerologia|tarot|tudo]
Ex.: zznome maria
     zznome josé origem
EOT
;;

zznomealeatorio) cat <<'EOT'
zznomealeatorio
Gera um nome aleatório de N caracteres, alternando consoantes e vogais.
Obs.: Se nenhum parâmetro for passado, gera um nome de 6 caracteres.
Uso: zznomealeatorio [N]
Ex.: zznomealeatorio
     zznomealeatorio 8
EOT
;;

zznomefoto) cat <<'EOT'
zznomefoto
Renomeia arquivos do diretório atual, arrumando a seqüência numérica.
Obs.: Útil para passar em arquivos de fotos baixadas de uma câmera.
Opções: -n  apenas mostra o que será feito, não executa
        -i  define a contagem inicial
        -d  número de dígitos para o número
        -p  prefixo padrão para os arquivos
        --dropbox  renomeia para data+hora da foto, padrão Dropbox
Uso: zznomefoto [-n] [-i N] [-d N] [-p TXT] arquivo(s)
Ex.: zznomefoto -n *                        # tire o -n para renomear!
     zznomefoto -n -p churrasco- *.JPG      # tire o -n para renomear!
     zznomefoto -n -d 4 -i 500 *.JPG        # tire o -n para renomear!
     zznomefoto -n --dropbox *.JPG          # tire o -n para renomear!
EOT
;;

zznoticiaslinux) cat <<'EOT'
zznoticiaslinux
Busca as últimas notícias sobre Linux em sites nacionais.
Obs.: Cada site tem uma letra identificadora que pode ser passada como
      parâmetro, para informar quais sites você quer pesquisar:

        B) Br-Linux             C) Canal Tech
        D) Diolinux             L) Linux Descomplicado
        Z) Linuxbuzz

Uso: zznoticiaslinux [sites]
Ex.: zznoticiaslinux
     zznoticiaslinux bv
EOT
;;

zznoticiassec) cat <<'EOT'
zznoticiassec
Busca as últimas notícias em sites especializados em segurança.
Obs.: Cada site tem uma letra identificadora que pode ser passada como
      parâmetro, para informar quais sites você quer pesquisar:

      C)ERT/CC            Linux T)oday - Security
      Linux S)ecurity     Security F)ocus

Uso: zznoticiassec [sites]
Ex.: zznoticiassec
     zznoticiassec cft
EOT
;;

zznumero) cat <<'EOT'
zznumero
Formata um número como: inteiro, moeda, por extenso, entre outros.
Nota: Por extenso suporta 81 dígitos inteiros e até 26 casas decimais.

Opções:
  -f <padrão|número>  Padrão de formatação do printf, incluindo %'d e %'.f
                      ou precisão se apenas informado um número
  -p <prefixo>        Um prefixo para o número, se for R$ igual a opção -m
  -s <sufixo>         Um sufixo para o número
  -m | --moeda        Trata valor monetário, sobrepondo as configurações de
                      -p, -s e -f
  -t                  Número parcialmente por extenso, ex: 2 milhões 350 mil
  --texto             Número inteiramente por extenso, ex: quatro mil e cem
  -l                  Uma classe numérica por linha, quando optar no número
                      por extenso
  --de <formato>      Formato de entrada
  --para <formato>    Formato de saída
  --int               Parte inteira do número, sem arredondamento
  --frac              Parte fracionária do número

Formatos para as opções --de e --para:
  pt ou pt-br => português (brasil)
  en          => inglês (americano)

Uso: zznumero [opções] <número>
Ex.: zznumero 12445.78                      # 12.445,78
     zznumero --texto 4567890,213           # quatro milhões, quinhentos...
     zznumero -m 85,345                     # R$ 85,34
     echo 748 | zznumero -f "%'.3f"         # 748,000
EOT
;;

zzora) cat <<'EOT'
zzora
http://ora-code.com
Retorna a descrição do erro Oracle (AAA-99999).
Uso: zzora numero_erro
Ex.: zzora 1234
EOT
;;

zzpad) cat <<'EOT'
zzpad
Preenche um texto para um certo tamanho com outra string.

Opções:
  -d, -r     Preenche à direita (padrão)
  -e, -l     Preenche à esquerda
  -a, -b     Preenche em ambos os lados
  -x STRING  String de preenchimento (padrão=" ")

Uso: zzpad [-d | -e | -a] [-x STRING] <tamanho> [texto]
Ex.: zzpad -x 'NO' 21 foo     # fooNONONONONONONONONO
     zzpad -a -x '_' 9 foo    # ___foo___
     zzpad -d -x '♥' 9 foo    # foo♥♥♥♥♥♥
     zzpad -e -x '0' 9 123    # 000000123
     cat arquivo.txt | zzpad -x '_' 99
EOT
;;

zzpais) cat <<'EOT'
zzpais
Lista os países.
Opções:
 -a: Todos os países
 -i: Informa o(s) idioma(s)
 -o: Exibe o nome do país e capital no idioma nativo
Outra opção qualquer é usado como filtro para pesquisar entre os países.
Obs.: Sem argumentos, mostra um país qualquer.

Uso: zzpais [palavra|regex]
Ex.: zzpais              # mostra um pais qualquer
     zzpais unidos       # mostra os países com "unidos" no nome
     zzpais -o nova      # mostra o nome original de países com "nova".
     zzpais ^Z           # mostra os países que começam com Z
EOT
;;

zzpalpite) cat <<'EOT'
zzpalpite
Palpites de jogos para várias loterias: quina, megasena, lotomania, etc.
Aqui está a lista completa de todas as loterias suportadas:
quina, megasena, duplasena, lotomania, lotofácil, timemania, sorte, sete, federal, loteca

Uso: zzpalpite [quina|megasena|duplasena|lotomania|lotofacil|federal|timemania|sorte|sete|loteca]
Ex.: zzpalpite
     zzpalpite megasena
     zzpalpite megasena federal lotofacil
EOT
;;

zzpascoa) cat <<'EOT'
zzpascoa
Mostra a data do domingo de Páscoa para qualquer ano.
Obs.: Se o ano não for informado, usa o atual.
Regra: Primeiro domingo após a primeira lua cheia a partir de 21 de março.
Uso: zzpascoa [ano]
Ex.: zzpascoa
     zzpascoa 1999
EOT
;;

zzpgsql) cat <<'EOT'
zzpgsql
Lista os comandos SQL no PostgreSQL, numerando-os.
Pesquisa detalhe dos comando, ao fornecer o número na listagem a esquerda.
E filtra a busca se fornecer um texto.

Uso: zzpgsql [ código | filtro ]
Ex.: zzpgsql        # Lista os comandos disponíveis
     zzpgsql 20     # Consulta o comando ALTER SCHEMA
     zzpgsql alter  # Filtra os comandos que possuam alter na declaração
EOT
;;

zzphp) cat <<'EOT'
zzphp
http://www.php.net/manual/pt_BR/indexes.functions.php
Lista completa com funções do PHP.
com a opção -d ou --detalhe busca mais informação da função
com a opção --atualiza força a atualização co cache local

Uso: zzphp <palavra|regex>
Ex.: zzphp --atualiza              # Força atualização do cache
     zzphp array                   # mostra as funções com "array" no nome
     zzphp -d mysql_fetch_object   # mostra descrição do  mysql_fetch_object
     zzphp ^X                      # mostra as funções que começam com X
EOT
;;

zzplay) cat <<'EOT'
zzplay
Toca o arquivo de áudio, escolhendo o player mais adequado instalado.
Também pode tocar lista de reprodução (playlist).
Pode-se escolher o player principal passando-o como segundo argumento.
- Os players possíveis para cada tipo são:
  wav, au, aiff        afplay, play, mplayer, cvlc, avplay, ffplay
  mp2, mp3             afplay, mpg321, mpg123, mplayer, cvlc, avplay, ffplay
  ogg                  ogg123, mplayer, cvlc, avplay, ffplay
  aac, wma, mka        mplayer, cvlc, avplay, ffplay
  pls, m3u, xspf, asx  mplayer, cvlc

Uso: zzplay <arquivo-de-áudio> [player]
Ex.: zzplay os_seminovos_escolha_ja_seu_nerd.mp3
     zzplay os_seminovos_eu_nao_tenho_iphone.mp3 cvlc   # priorizando o cvlc
EOT
;;

zzporcento) cat <<'EOT'
zzporcento
Calcula porcentagens.
Se informado um número, mostra sua tabela de porcentagens.
Se informados dois números, mostra a porcentagem relativa entre eles.
Se informados um número e uma porcentagem, mostra o valor da porcentagem.
Se informados um número e uma porcentagem com sinal, calcula o novo valor.

Uso: zzporcento valor [valor|[+|-]porcentagem%]
Ex.: zzporcento 500           # Tabela de porcentagens de 500
     zzporcento 500.0000      # Tabela para número fracionário (.)
     zzporcento 500,0000      # Tabela para número fracionário (,)
     zzporcento 5.000,00      # Tabela para valor monetário
     zzporcento 500 25        # Mostra a porcentagem de 25 para 500 (5%)
     zzporcento 500 1000      # Mostra a porcentagem de 1000 para 500 (200%)
     zzporcento 500,00 2,5%   # Mostra quanto é 2,5% de 500,00
     zzporcento 500,00 +2,5%  # Mostra quanto é 500,00 + 2,5%
EOT
;;

zzporta) cat <<'EOT'
zzporta
http://pt.wikipedia.org/wiki/Lista_de_portas_de_protocolos
Mostra uma lista das portas de protocolos usados na internet.
Se houver um número como argumento, a listagem é filtrada pelo mesmo.

Uso: zzporta [porta]
Ex.: zzporta
     zzporta 513
EOT
;;

zzpronuncia) cat <<'EOT'
zzpronuncia
Fala a pronúncia correta de uma palavra em inglês.
Uso: zzpronuncia palavra
Ex.: zzpronuncia apple
EOT
;;

zzquimica) cat <<'EOT'
zzquimica
Exibe a relação dos elementos químicos.
Pesquisa na Wikipédia se informado o número atômico ou símbolo do elemento.

Uso: zzquimica [número|símbolo]
Ex.: zzquimica       # Lista de todos os elementos químicos
     zzquimica He    # Pesquisa o Hélio na Wikipédia
     zzquimica 12    # Pesquisa o Magnésio na Wikipédia
EOT
;;

zzramones) cat <<'EOT'
zzramones
http://aurelio.net/doc/ramones.txt
Mostra uma frase aleatória, das letras de músicas da banda punk Ramones.
Obs.: Informe uma palavra se quiser frases sobre algum assunto especifico.
Uso: zzramones [palavra]
Ex.: zzramones punk
     zzramones
EOT
;;

zzrastreamento) cat <<'EOT'
zzrastreamento
http://www.correios.com.br
Acompanha encomendas via rastreamento dos Correios.
Uso: zzrastreamento <código_da_encomenda> ...
Ex.: zzrastreamento RK995267899BR
     zzrastreamento RK995267899BR RA995267899CN
EOT
;;

zzrepete) cat <<'EOT'
zzrepete
Repete um dado texto na quantidade de vezes solicitada.
Com a opção -l ou --linha cada repetição é uma nova linha.

Uso: zzrepete [-l | --linha] <repetições> <texto>
Ex.: zzrepete 15 Foo     # FooFooFooFooFooFooFooFooFooFooFooFooFooFooFoo
EOT
;;

zzromanos) cat <<'EOT'
zzromanos
Conversor de números romanos para hindu-arábicos e vice-versa.
Converte corretamente para romanos números até 3999999.
Converte corretamente para hindu-arábicos números até 4000.

Uso: zzromanos número
Ex.: zzromanos 1987                # Retorna: MCMLXXXVII
     zzromanos XLIII               # Retorna: 43
EOT
;;

zzrot13) cat <<'EOT'
zzrot13
Codifica/decodifica um texto utilizando a cifra ROT13.
Uso: zzrot13 texto
Ex.: zzrot13 texto secreto               # Retorna: grkgb frpergb
     zzrot13 grkgb frpergb               # Retorna: texto secreto
     echo texto secreto | zzrot13        # Retorna: grkgb frpergb
EOT
;;

zzrot47) cat <<'EOT'
zzrot47
Codifica/decodifica um texto utilizando a cifra ROT47.
Uso: zzrot47 texto
Ex.: zzrot47 texto secreto               # Retorna: E6IE@ D64C6E@
     zzrot47 E6IE@ D64C6E@               # Retorna: texto secreto
     echo texto secreto | zzrot47        # Retorna: E6IE@ D64C6E@
EOT
;;

zzrpmfind) cat <<'EOT'
zzrpmfind
http://rpmfind.net/linux
Procura por pacotes RPM em várias distribuições de Linux.
Obs.: A arquitetura padrão de procura é a i586.
Uso: zzrpmfind pacote [distro] [arquitetura]
Ex.: zzrpmfind sed
     zzrpmfind lilo mandr i586
EOT
;;

zzsecurity) cat <<'EOT'
zzsecurity
Mostra os últimos 5 avisos de segurança de sistemas de Linux/UNIX.
Suportados:
 Debian, Ubuntu, FreeBSD, NetBSD, Gentoo, Arch, Mageia,
 Slackware, Suse, OpenSuse, Fedora.
Uso: zzsecurity [distros]
Ex.: zzsecurity
     zzsecurity mageia
     zzsecurity debian gentoo
EOT
;;

zzsemacento) cat <<'EOT'
zzsemacento
Tira os acentos de todas as letras (áéíóú vira aeiou).
Uso: zzsemacento texto
Ex.: zzsemacento AÇÃO 1ª bênção           # Retorna: ACAO 1a bencao
     echo AÇÃO 1ª bênção | zzsemacento    # Retorna: ACAO 1a bencao
EOT
;;

zzsenha) cat <<'EOT'
zzsenha
Gera uma senha aleatória de N caracteres.
Obs.: Sem opções, a senha é gerada usando letras e números.

Opções: -p, --pro   Usa letras, números e símbolos para compor a senha
        -n, --num   Usa somente números para compor a senha
        -u, --uniq  Gera senhas com caracteres únicos (não repetidos)

Uso: zzsenha [--pro|--num] [n]     (padrão n=8)
Ex.: zzsenha
     zzsenha 10
     zzsenha --num 9
     zzsenha --pro 30
     zzsenha --uniq 10
EOT
;;

zzseq) cat <<'EOT'
zzseq
Mostra uma seqüência numérica, um número por linha, ou outro formato.
É uma emulação do comando seq, presente no Linux.
Opções:
  -f    Formato de saída (printf) para cada número, o padrão é '%d\n'
Uso: zzseq [-f formato] [número-inicial [passo]] número-final
Ex.: zzseq 10                   # de 1 até 10
     zzseq 5 10                 # de 5 até 10
     zzseq 10 5                 # de 10 até 5 (regressivo)
     zzseq 0 2 10               # de 0 até 10, indo de 2 em 2
     zzseq 10 -2 0              # de 10 até 0, indo de 2 em 2
     zzseq -f '%d:' 5           # 1:2:3:4:5:
     zzseq -f '%0.4d:' 5        # 0001:0002:0003:0004:0005:
     zzseq -f '(%d)' 5          # (1)(2)(3)(4)(5)
     zzseq -f 'Z' 5             # ZZZZZ
EOT
;;

zzsextapaixao) cat <<'EOT'
zzsextapaixao
Mostra a data da sexta-feira da paixão para qualquer ano.
Obs.: Se o ano não for informado, usa o atual.
Regra: 2 dias antes do domingo de Páscoa.
Uso: zzsextapaixao [ano]
Ex.: zzsextapaixao
     zzsextapaixao 2008
EOT
;;

zzsheldon) cat <<'EOT'
zzsheldon
Exibe aleatoriamente uma frase do Sheldon, do seriado The Big Bang Theory.

Uso: zzsheldon
Ex.: zzsheldon
EOT
;;

zzshuffle) cat <<'EOT'
zzshuffle
Desordena as linhas de um texto (ordem aleatória).
Uso: zzshuffle [arquivo(s)]
Ex.: zzshuffle /etc/passwd         # desordena o arquivo de usuários
     cat /etc/passwd | zzshuffle   # o arquivo pode vir da entrada padrão
EOT
;;

zzsigla) cat <<'EOT'
zzsigla
http://www.acronymfinder.com
Dicionário de siglas, sobre qualquer assunto (como DVD, IMHO, WYSIWYG).
Obs.: Há um limite diário de consultas por IP, pode parar temporariamente.
Uso: zzsigla sigla
Ex.: zzsigla RTFM
EOT
;;

zzsplit) cat <<'EOT'
zzsplit
Separa um arquivo linha a linha alternadamente em 2 ou mais arquivos.
Usa o mesmo nome do arquivo, colocando sufixo numérico sequencial.

Opção:
 -p <relação de linhas> - numero de linhas de cada arquivo de destino.
   Obs1.: A relação são números de linhas de cada arquivo correspondente na
          sequência, justapostos separados por vírgula (,).
   Obs2.: Se a quantidade de linhas na relação for menor que a quantidade de
          arquivos, os arquivos excedentes adotam a último valor na relação.
   Obs3.: Os números negativos na relação, saltam as linha informadas
          sem repassar ao arquivo destino.

Uso: zzsplit -p <relação> [<numero>] | <numero> <arquivo>
Ex.: zzsplit 3 arq.txt  # Separa em 3: arq.txt.1, arq.txt.2, arq.txt.3
     zzsplit -p 3,5,4 5 arq.txt  # Separa em 5 arquivos
     # 3 linhas no arq.txt.1, 5 linhas no arq.txt.2 e 4 linhas nos demais.
     zzsplit -p 3,4,2 arq.txt    # Separa em 3 arquivos
     # 3 linhas no arq.txt.1, 4 linhas no arq.txt.2 e 2 linhas no arq.txt.3
     zzsplit -p 2,-3,4 arq.txt   # Separa em 2 arquivos
     # 2 linhas no arq.txt.1, pula 3 linhas e 4 linhas no arq.txt.3
EOT
;;

zzsqueeze) cat <<'EOT'
zzsqueeze
Reduz vários espaços consecutivos vertical ou horizontalmente em apenas um.

Opções:
 -l ou --linha: Apenas linhas vazias consecutivas, se reduzem a uma.
 -c ou --coluna: Espaços consecutivos em cada linha, são unidos em um.

Obs.: Linhas inteiras com espaços ou tabulações,
       tornam-se linhas de comprimento zero (sem nenhum caractere).

Uso: zzsqueeze [-l|--linha] [-c|--coluna] arquivo
Ex.: zzsqueeze arquivo.txt
     zzsqueeze -l arq.txt   # Apenas retira linhas consecutivas em branco.
     zzsqueeze -c arq.txt   # Transforma em 1 espaço, vários espaços juntos.
     cat arquivo | zzsqueeze
EOT
;;

zzss) cat <<'EOT'
zzss
Protetor de tela (Screen Saver) para console, com cores e temas.
Temas: mosaico, espaco, olho, aviao, jacare, alien, rosa, peixe, siri.
Obs.: Aperte Ctrl+C para sair.
Uso: zzss [--rapido|--fundo] [--tema <tema>] [texto]
Ex.: zzss
     zzss fui ao banheiro
     zzss --rapido /
     zzss --fundo --tema peixe
EOT
;;

zzstr2hexa) cat <<'EOT'
zzstr2hexa
Converte string em bytes em hexadecimal equivalente.
Uso: zzstr2hexa [string]
Ex.: zzstr2hexa @MenteBrilhante    # 40 4d 65 6e 74 65 42 72 69 6c 68 61 6e…
     zzstr2hexa bin                # 62 69 6e
     echo bin | zzstr2hexa         # 62 69 6e
EOT
;;

zzsubway) cat <<'EOT'
zzsubway
Mostra uma sugestão de sanduíche para pedir na lanchonete Subway.
Obs.: Se não gostar da sugestão, chame a função novamente para ter outra.
Uso: zzsubway
Ex.: zzsubway
EOT
;;

zztabuada) cat <<'EOT'
zztabuada
Exibe a tabela de tabuada de um número.
Com 1 argumento:
 Tabuada de qualquer número inteiro de 1 a 10.

Com 2 argumentos:
 Tabuada de qualquer número inteiro de 1 ao segundo argumento.
 O segundo argumento só pode ser um número positivo de 1 até 99, inclusive.

Se não for informado nenhum argumento será impressa a tabuada de 1 a 9.

Uso: zztabuada [número [número]]
Ex.: zztabuada
     zztabuada 2
     zztabuada -176
     zztabuada 5 15  # Tabuada do 5, mas multiplicado de 1 até o 15.
EOT
;;

zztac) cat <<'EOT'
zztac
Inverte a ordem das linhas, mostrando da última até a primeira.
É uma emulação (portável) do comando tac, presente no Linux.

Uso: zztac [arquivos]
Ex.: zztac /etc/passwd
     zztac arquivo.txt outro.txt
     cat /etc/passwd | zztac
EOT
;;

zztempo) cat <<'EOT'
zztempo
Mostra previsão do tempo obtida em http://wttr.in/ por meio do comando curl.
Mostra as condições do tempo (clima) em um determinado local.
Se nenhum parâmetro for passado, é apresentada a previsão de Brasília.
As siglas de aeroporto também podem ser utilizadas.

Opções:

-l, --lang, --lingua
   Exibe a previsão em uma das línguas disponíveis: az be bg bs ca cy cs
   da de el eo es et fi fr hi hr hu hy is it  ja jv ka kk ko ky lt lv mk
   ml nl nn pt pl ro ru sk sl sr sr-lat sv sw th tr uk uz vi zh zu

-u, --us
   Retorna leitura em unidades USCS - United States customary units -
   Unidades Usuais nos Estados Unidos. Isto é: "°F" para temperatura,
   "mph" para velocidade do vento,  "mi" para visibilidade e "in" para
   precipitação.

-v, --vento
   Retorna vento em m/s ao invés de km/h ou mph.

-m, --monocromatico
   Nao utiliza comandos de cores no terminal

-s, --simples
   Retorna versão curta, com previsão de meio-dia e noite apenas.
   Utiliza 63 caracteres de largura contra os 125 da resposta completa.

-c, --completo
   Retorna versão completa, com 4 horários ao longo do dia.
   Utiliza 125 caracteres de largura.

-d, --dias
Determina o número de dias (entre 0 e 3) de previsão apresentados.
   -d 0 = apenas tempo atual. Também pode se chamado com -0
   -d 1 = tempo atual mais 1 dia. Também pode se chamado com -1
   -d 2 = tempo atual mais 2 dias. Também pode se chamado com -2
   -d 3 = tempo atual mais 3 dias. Padrão.

Uso: zztempo [parametros] <localidade>
Ex.: zztempo 'São Paulo'
     zztempo cwb
     zztempo -d 0 Curitiba
     zztempo -2 -l fr -s Miami
EOT
;;

zztestar) cat <<'EOT'
zztestar
Testa a validade do número no tipo de categoria selecionada.
Nada é ecoado na saída padrão, apenas deve-se analisar o código de retorno.
Pode-se ecoar a saída de erro usando a opção -e antes da categoria.

 Categorias:
  ano                      =>  Ano válido
  ano_bissexto | bissexto  =>  Ano Bissexto
  exp | exponencial        =>  Número em notação científica
  numero | numero_natural  =>  Número Natural ( inteiro positivo )
  numero_sinal | inteiro   =>  Número Inteiro ( positivo ou negativo )
  numero_fracionario       =>  Número Fracionário ( casas decimais )
  numero_real              =>  Número Real ( casas decimais possíveis )
  complexo                 =>  Número Complexo ( a+bi )
  dinheiro                 =>  Formato Monetário ( 2 casas decimais )
  bin | binario            =>  Número Binário ( apenas 0 e 1 )
  octal | octadecimal      =>  Número Octal ( de 0 a 7 )
  hexa | hexadecimal       =>  Número Hexadecimal ( de 0 a 9 e A até F )
  ip                       =>  Endereço de rede IPV4
  ip6 | ipv6               =>  Endereço de rede IPV6
  mac                      =>  Código MAC Address válido
  data                     =>  Data com formatação válida ( dd/mm/aaa )
  hora                     =>  Hora com formatação válida ( hh:mm )

  Obs.: ano, ano_bissextto e os
        números naturais, inteiros e reais sem separador de milhar.

Uso: zztestar [-e] categoria número
Ex.: zztestar ano 1999
     zztestar ip 192.168.1.1
     zztestar hexa 4ca9
     zztestar numero_real -45,678
EOT
;;

zztimer) cat <<'EOT'
zztimer
Mostra um cronômetro regressivo.
Opções:
  -n: Os números são ampliados para um formato de 5 linhas e 6 colunas.
  -x char: Igual a -n, mas os números são compostos pelo caracter "char".
  -y nums chars: Troca os nums por chars, igual ao comando 'y' no sed.
     Obs.: nums e chars tem que ter a mesma quantidade de caracteres.
  --centro: Centraliza tanto horizontal como verticalmente
  -c: Apenas converte o tempo em segundos.
  -s: Aguarda o tempo como sleep, sem mostrar o cronômetro.
  -p: Usa uma temporização mais precisa, porém usa mais recursos.
  --teste: Desabilita centralização (usar depois das opções -n,-x,-y).

Obs: Máximo de 99 horas.
     Opções -n, -x, -y sempre centralizada na tela, exceto se usar --teste.

Uso: zztimer [-c|-s|-n|-x char|-y nums chars] [-p] [[hh:]mm:]ss
Ex.: zztimer 90           # Cronomêtro regressivo a partir de 1:30
     zztimer 2:56         # Cronometragem regressiva simples.
     zztimer -c 2:22      # Exibe o tempo em segundos (no caso 142)
     zztimer -s 5:34      # Exibe o tempo em segundos e aguarda o tempo.
     zztimer --centro 20  # Centralizado horizontal e verticalmente
     zztimer -n 1:7:23    # Formato ampliado do número
     zztimer -x H 65      # Com números feito pela letra 'H'
     zztimer -y 0123456789 9876543210 60  # Troca os números
EOT
;;

zztool) cat <<'EOT'
zztool
Miniferramentas para auxiliar as funções.
Uso: zztool [-e] ferramenta [argumentos]
Ex.: zztool grep_var foo $var
     zztool eco Minha mensagem colorida
     zztool testa_numero $num
     zztool -e testa_numero $num || return
EOT
;;

zztop) cat <<'EOT'
zztop
Lista os computadores mais rápidos do mundo entre os 500 disponíveis.
Por padrão lista os 10 primeiros da listagem mais atual.

Pode-se pedir pela posição:
-i <número>: listando a partir dessa posição em diante.
-f <número>: listando até essa posição.

Argumentos de ajuda:
 -l: Exibe as listas disponíveis
 -g: Exibe a lista por Eficiência Energética
 -p: Exibe a lista por Gradiente de Conjugado de Alta Performance

Argumentos de listagem:
 [lista]:     Seleciona a lista, se omitida mostra mais recente.

Sem argumentos usa a listagem mais recente.

Uso: zztop [-l] [-g|-h] [-i número] [-f número] [lista]
Ex.: zztop               # Lista os 10 mais rápidos ( mais atuais ).
     zztop 23            # Lista os 10 mais rápidos em Junho de 2004
     zztop -g            # Ordenando por eficiência energética
     zztop -p            # Ordenado por alta performance
     zztop -i 5          # Lista do 5º ao 10º mais rápido
     zztop -f 270        # Lista os 270 mais rápidos
     zztop -i 2 -f 5 40  # Lista do 2º ao 5º de Novembro 2012
     zztop -l            # Exibe todas as listas disponíveis
EOT
;;

zztranspor) cat <<'EOT'
zztranspor
Trocar linhas e colunas de um arquivo, fazendo uma simples transposição.
Opções:
  -d <sep>                        define o separador de campos na entrada.
  -D, --output-delimiter <sep>  define o separador de campos na saída.

O separador na entrada pode ser 1 ou mais caracteres ou uma ER.
Se não for declarado assume-se espaços em branco como separador.
Conforme padrão do awk, o default seria FS = "[ \t]+".

Se o separador de saída não for declarado, assume o mesmo da entrada.
Caso a entrada também não seja declarada assume-se como um espaço.
Conforme padrão do awk, o default é OFS = " ".

Se o separador da entrada é uma ER, é bom declarar o separador de saída.

Uso: zztranspor [-d <sep>] [-D | --output-delimiter <sep>] <arquivo>
Ex.: zztranspor -d ":" --output-delimiter "-" num.txt
     sed -n '2,5p' num.txt | zztranspor -d '[\t:]' -D '\t'
EOT
;;

zztrim) cat <<'EOT'
zztrim
Apaga brancos (" " \t \n) ao redor do texto: direita, esquerda, cima, baixo.
Obs.: Linhas que só possuem espaços e tabs são consideradas em branco.

Opções:
  -t, --top         Apaga as linhas em branco do início do texto
  -b, --bottom      Apaga as linhas em branco do final do texto
  -l, --left        Apaga os brancos do início de todas as linhas
  -r, --right       Apaga os brancos do final de todas as linhas
  -V, --vertical    Apaga as linhas em branco do início e final (-t -b)
  -H, --horizontal  Apaga os brancos do início e final das linhas (-l -r)

Uso: zztrim [opções] [texto]
Ex.: zztrim "   foo bar   "           # "foo bar"
     zztrim -l "   foo bar   "        # "foo bar   "
     zztrim -r "   foo bar   "        # "   foo bar"
     echo "   foo bar   " | zztrim    # "foo bar"
EOT
;;

zztrocaarquivos) cat <<'EOT'
zztrocaarquivos
Troca o conteúdo de dois arquivos, mantendo suas permissões originais.
Uso: zztrocaarquivos arquivo1 arquivo2
Ex.: zztrocaarquivos /etc/fstab.bak /etc/fstab
EOT
;;

zztrocaextensao) cat <<'EOT'
zztrocaextensao
Troca a extensão dos arquivos especificados.
Com a opção -n, apenas mostra o que será feito, mas não executa.
Uso: zztrocaextensao [-n] antiga nova arquivo(s)
Ex.: zztrocaextensao -n .doc .txt *          # tire o -n para renomear!
EOT
;;

zztrocapalavra) cat <<'EOT'
zztrocapalavra
Troca uma palavra por outra, nos arquivos especificados.
Obs.: Além de palavras, é possível usar expressões regulares.
Uso: zztrocapalavra antiga nova arquivo(s)
Ex.: zztrocapalavra excessão exceção *.txt
EOT
;;

zztv) cat <<'EOT'
zztv
Mostra a programação da TV, diária ou semanal, com escolha de emissora.

Opções:
 canais - lista os canais com seus códigos para consulta.

 <código canal> - Programação do canal escolhido.
 Obs.: Seguido de "semana" ou "s": toda programação das próximas semanas.
       Se for seguido de uma data, mostra a programação da data informada.

 cod <número> - mostra um resumo do programa.
  Obs: número obtido pelas listagens da programação do canal consultado.

Programação corrente:
 doc ou documentario, esportes ou futebol, filmes, infantil, variedades
 series ou seriados, aberta, todos ou agora (padrão).

Uso: zztv [<código canal> [s | <DATA>]]  ou  zztv [cod <número> | canais]
Ex.: zztv CUL          # Programação da TV Cultura
     zztv fox 31/5     # Programação da Fox na data, se disponível
     zztv cod 3235238  # Detalhes do programa identificado pelo código
EOT
;;

zzunescape) cat <<'EOT'
zzunescape
Restaura caracteres codificados como entidades HTML e XML (&lt; &#62; ...).
Entende entidades (&gt;), códigos decimais (&#62;) e hexadecimais (&#x3E;).

Opções: --html  Restaura caracteres HTML
        --xml   Restaura caracteres XML

Uso: zzunescape [--html] [--xml] [arquivo(s)]
Ex.: zzunescape --xml arquivo.xml
     zzunescape --html arquivo.html
     cat arquivo.html | zzunescape --html
EOT
;;

zzunicode) cat <<'EOT'
zzunicode
Mostra a tabela Unicode com todos os caracteres imprimíveis.
Opções:
  -n: Exibe o nome do caractere.
  -c <número>: Define a divisão da lista em colunas.

Uso: zzunicode [-n|-c <número>] [número]
Ex.: zzunicode           # Exibe a lista de todas as classes de caracretes
     zzunicode -n 42     # Exibe os caracteres com código e nome
     zzunicode -c 4 24   # Exibe os caracteres em 4 colunas
EOT
;;

zzunicode2ascii) cat <<'EOT'
zzunicode2ascii
Converte caracteres Unicode (UTF-8) para seus similares ASCII (128).

Uso: zzunicode2ascii [arquivo(s)]
Ex.: zzunicode2ascii arquivo.txt
     cat arquivo.txt | zzunicode2ascii
EOT
;;

zzuniq) cat <<'EOT'
zzuniq
Retira as linhas repetidas, consecutivas ou não.
Obs.: Não altera a ordem original das linhas, diferente do sort|uniq.

Uso: zzuniq [arquivo(s)]
Ex.: zzuniq /etc/inittab
     cat /etc/inittab | zzuniq
EOT
;;

zzunix2dos) cat <<'EOT'
zzunix2dos
Converte arquivos texto no formato Unix (LF) para o Windows/DOS (CR+LF).
Uso: zzunix2dos arquivo(s)
Ex.: zzunix2dos frases.txt
     cat arquivo.txt | zzunix2dos
EOT
;;

zzurldecode) cat <<'EOT'
zzurldecode
http://en.wikipedia.org/wiki/Percent-encoding
Decodifica textos no formato %HH, geralmente usados em URLs (%40 → @).

Uso: zzurldecode [texto]
Ex.: zzurldecode '%73%65%67%72%65%64%6F'
     echo 'http%3A%2F%2F' | zzurldecode
EOT
;;

zzurlencode) cat <<'EOT'
zzurlencode
http://en.wikipedia.org/wiki/Percent-encoding
Codifica o texto como %HH, para ser usado numa URL (a/b → a%2Fb).
Obs.: Por padrão, letras, números e _.~- não são codificados (RFC 3986)

Opções:
  -t, --todos  Codifica todos os caracteres, sem exceção
  -n STRING    Informa caracteres adicionais que não devem ser codificados

Uso: zzurlencode [texto]
Ex.: zzurlencode http://www            # http%3A%2F%2Fwww
     zzurlencode -n : http://www       # http:%2F%2Fwww
     zzurlencode -t http://www         # %68%74%74%70%3A%2F%2F%77%77%77
     zzurlencode -t -n w/ http://www   # %68%74%74%70%3A//www
EOT
;;

zzutf8) cat <<'EOT'
zzutf8
Converte o texto para UTF-8, se necessário.
Obs.: Caso o texto já seja UTF-8, não há conversão.

Uso: zzutf8 [arquivo]
Ex.: zzutf8 /etc/passwd
     zzutf8 index-iso.html
     echo Bênção | zzutf8        # Bênção
     printf '\341\n' | zzutf8    # á
EOT
;;

zzvdp) cat <<'EOT'
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
EOT
;;

zzvds) cat <<'EOT'
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
EOT
;;

zzvira) cat <<'EOT'
zzvira
Vira um texto, de trás pra frente (rev) ou de ponta-cabeça.
Ideia original de: http://www.revfad.com/flip.html (valeu @andersonrizada)

Uso: zzvira [-X|-E] texto
Ex.: zzvira Inverte tudo             # odut etrevnI
     zzvira -X De pernas pro ar      # ɹɐ oɹd sɐuɹǝd ǝp
     zzvira -E De pernas pro ar      # pǝ dǝɹuɐs dɹo ɐɹ
EOT
;;

zzwc) cat <<'EOT'
zzwc
Contabiliza total de bytes, caracteres, palavras ou linhas de um arquivo.
Ou exibe tamanho da maior linha em bytes, caracteres ou palavras.
Opcionalmente exibe as maiores linhas, desse arquivo.
Também aceita receber dados pela entrada padrão (stdin).
É uma emulação do comando wc, que não contabiliza '\r' e '\n'.

Opções:
  -c  total de bytes
  -m  total de caracteres
  -l  total de linhas
  -w  total de palavras
  -C, -L, -W  maior linha em bytes, caracteres ou palavras respectivamente
  -p Exibe a maior linha em bytes, caracteres ou palavras,
     usado junto com as opções -C, -L e -W.

   Se as opções forem omitidas adota -l -w -c por padrão.

Uso: zzwc [-c|-C|-m|-l|-L|-w|-W] [-p] arquivo
Ex.: echo "12345"       | zzwc -c     # 5
     printf "abcde"     | zzwc -m     # 5
     printf "abc\123"   | zzwc -l     # 2
     printf "xz\n789\n" | zzwc -L     # 3
     printf "wk\n456"   | zzwc -M -p  # 456
EOT
;;

zzwikipedia) cat <<'EOT'
zzwikipedia
http://www.wikipedia.org
Procura na Wikipédia, a enciclopédia livre.
Obs.: Se nenhum idioma for especificado, é utilizado o português.

Idiomas: de (alemão)    eo (esperanto)  es (espanhol)  fr (francês)
         it (italiano)  ja (japonês)    la (latin)     pt (português)

Uso: zzwikipedia [-idioma] palavra(s)
Ex.: zzwikipedia sed
     zzwikipedia Linus Torvalds
     zzwikipedia -pt Linus Torvalds
EOT
;;

zzxml) cat <<'EOT'
zzxml
Parser simples (e limitado) para arquivos XML/HTML.
Obs.: Este parser é usado pelas Funções ZZ, não serve como parser genérico.
Obs.: Necessário pois não há ferramenta portável para lidar com XML no Unix.

Opções: --tidy        Reorganiza o código, deixando uma tag por linha
        --tag NOME    Extrai (grep) todas as tags NOME e seu conteúdo
        --notag NOME  Exclui (grep -v) todas as tags NOME e seu conteúdo
        --list        Lista sem repetição as tags existentes no arquivo
        --indent      Promove a indentação das tags
        --untag       Remove todas as tags, deixando apenas texto
        --untag=NOME  Remove apenas a tag NOME, deixando o seu conteúdo
        --unescape    Converte as entidades &foo; para caracteres normais
Obs.: --notag tem precedência sobre --tag e --untag.
      --untag tem precedência sobre --tag.

Uso: zzxml <opções> [arquivo(s)]
Ex.: zzxml --tidy arquivo.xml
     zzxml --untag --unescape arq.xml                   # xml -> txt
     zzxml --untag=item arq.xml                         # Apaga tags "item"
     zzxml --tag title --untag --unescape arq.xml       # títulos
     cat arq.xml | zzxml --tag item | zzxml --tag title # aninhado
     zzxml --tag item --tag title arq.xml               # tags múltiplas
     zzxml --notag link arq.xml                         # Sem tag e conteúdo
     zzxml --indent arq.xml                             # tags indentadas
EOT
;;

zzzz) cat <<'EOT'
zzzz
Mostra informações sobre as funções, como versão e localidade.
Opções: --atualiza  baixa a versão mais nova das funções
        --teste     testa se a codificação e os pré-requisitos estão OK
        --bashrc    instala as funções no ~/.bashrc
        --tcshrc    instala as funções no ~/.tcshrc
        --zshrc     instala as funções no ~/.zshrc
Uso: zzzz [--atualiza|--teste|--bashrc|--tcshrc|--zshrc]
Ex.: zzzz
     zzzz --teste
EOT
;;

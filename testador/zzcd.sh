# zzcd muda diretório como a função embutida cd
$ cd ~ && zzcd /var && echo $PWD #=> /var
$ zzcd ~ && zzcd /var && echo $PWD #=> /var

$ cd /usr/local && zzcd ../ && echo $PWD #=> /usr
$ zzcd /usr/local && zzcd ../ && echo $PWD #=> /usr
$

# zzcd roda também em modo interativo. Aqui passando o 2o dir da pilha.
# (parâmetro "1")
$ zzcd /usr/local && zzcd /var && zzcd -i >/dev/null <<< "1" && echo $PWD #=> /usr/local
$

# Interatividade exibe prompt quando opção -i é informada...
$ zzcd /usr/local && zzcd -i #=> --regex Ir para número:
$

# ... e somente se é informada.
$ zzcd /usr/local && zzcd #=> --regex ^(?!Ir para número:)
$
 
# Qualquer outra opção além de -h gera erro
$ zzcd -o #=> Opção inválida: -o
$ zzcd /usr/local && zzcd -1 #=> Opção inválida: -1
$

# Por tornar interatividade opcional, é possível passar o índice do diretório
# no histórico de mudanças
$ zzcd /usr/local && zzcd /var && zzcd 1 && echo $PWD #=> /usr/local
$

# zzcd resolve caminhos redundantes (não polui histórico)
$ zzcd /usr/local && zzcd /var/../var///// && echo $PWD #=> /var
$

# Validação de índice correto para seleção a partir do menu
$ zzcd /usr/local && zzcd -i >/dev/null <<<"-1" #=> Número de linha inválido: -1
$ zzcd /usr/local && zzcd -i >/dev/null <<<"100" #=> Número de linha inválido: 100
$ zzcd /usr/local && zzcd -i >/dev/null <<<"abc" #=> Número de linha inválido: abc
$ zzcd /usr/local && zzcd 100 >/dev/null #=> Número de linha inválido: 100

# Validação de diretório inválido
$ zzcd /nada/batata #=> Diretório inválido: /nada/batata

# links simbólicos para diretórios não são expandidos
$ ln -s /etc $HOME/teste && zzcd $HOME/teste && zzcd / && zzcd 1 >/dev/null && echo $PWD && rm $HOME/teste #=> --eval echo $HOME/teste

# zzcd muda diretório como a função embutida cd
$ cd ~ && zzcd /var && echo $PWD #=> /var
$ zzcd ~ && zzcd /var && echo $PWD #=> /var
$

$ cd /usr/local && zzcd ../ && echo $PWD #=> /usr
$ zzcd /usr/local && zzcd ../ && echo $PWD #=> /usr
$

# zzcd roda também em modo interativo. Aqui passando o 2o dir da pilha.
# (parâmetro "1")
$ zzcd /usr/local && zzcd /var && zzcd >/dev/null <<< "1" && echo $PWD #=> /usr/local
$

# zzcd resolve caminhos redundantes com a função embutida realpath
# (não polui histórico)
$ zzcd /usr/local && zzcd /var/../var///// && echo $PWD #=> /var
$

# Validação de índice correto para seleção a partir do menu
$ zzcd /usr/local && zzcd >/dev/null <<<"-1" #=> Número de linha inválido: -1
$ zzcd /usr/local && zzcd >/dev/null <<<"100" #=> Número de linha inválido: 100
$ zzcd /usr/local && zzcd >/dev/null <<<"abc" #=> Número de linha inválido: abc
$

## Informações das Funções ZZ

Aqui estão scripts que fornecem informações sobre alguns detalhes da funções.

Esses scripts são ferramentas auxiliares na confecção, correção, melhoria ou exclusão de uma ou mais funcionalidades.

Seu uso não é obrigatório, e nem influi em nenhuma das funcionalidades das demais funções.

```
autores_zz.sh      Listar e datar as funcoeszz e seus autores.
                   Passando um argumento, filtra a listagem de saída.
                   Ex.: ./autores_zz.sh           # Todas as funções com data de criação e autor
                   Ex.: ./autores_zz.sh Aurelio   # Apenas as funções de autoria do Aurelio

qtde_zz.sh:        Listar e quantificar as funcoeszz por autor ou ano.
                   Pode-se usar ano ou autor/autores como argumento, para definir qual o tipo de listagem.
                   Se não for usado, assume-se por padrão 'ano'.
                   Ex.: ./qtde_zz.sh        # Quantificar as funções feitas em cada ano
                   Ex.: ./qtde_zz.sh autor  # Quantificar as funções feitas por cada autor

linhas_zz.sh:      Exibe a quantidade de linhas das funcoeszz.
```
Obs.:
 Os 3 scripts acima podem ter a opção do primeiro argumento ser "off", "todas/todos".
  - Com a opção "off" as buscas são feitas nas funções desativadas
  - Com a opção "todas" ou "todos", as buscas são feitas tanto nas funções ativas como nas desativadas


```
requisitos_zz.sh:  Listar dependências e dependentes de cada função.
                   Lista as funções com suas dependẽncias e também as funções que são dependentes dela.
                   Possibilita avaliar o impacto que mudanças, rastreando aquelas funções que dependem da função alterada.
                   Se usar o argumento zztool/tool, faz-se o rastreamento das funções que dependam das ferramentas da zztool.
                   Com um segundo argumento, filtra-se apenas pela ferramenta da zztool selecionada.
```
Obs.: Apenas faz análise das funções ativas.


```
desativadas_zz.sh  Listar e datar funçoes desativadas.
                   Lista as funções desativadas, com a data do evento e o motivo.
```


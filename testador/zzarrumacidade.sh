# Volta algumas iniciais para minúsculas
$ zzarrumacidade "foo e bar"                      #→ Foo e Bar
$ zzarrumacidade "foo de bar"                     #→ Foo de Bar
$ zzarrumacidade "foo da bar"                     #→ Foo da Bar
$ zzarrumacidade "foo do bar"                     #→ Foo do Bar
$ zzarrumacidade "foo das bar"                    #→ Foo das Bar
$ zzarrumacidade "foo dos bar"                    #→ Foo dos Bar

# abreviações
$ zzarrumacidade "SP"                             #→ São Paulo
$ zzarrumacidade "RJ"                             #→ Rio de Janeiro
$ zzarrumacidade "BH"                             #→ Belo Horizonte
$ zzarrumacidade "BSB"                            #→ Brasília
$ zzarrumacidade "RIO"                            #→ Rio de Janeiro
$ zzarrumacidade "SAMPA"                          #→ São Paulo
$ zzarrumacidade "FLORIPA"                        #→ Florianópolis

# Restaura acentuação às capitais
$ zzarrumacidade "BELEM"                          #→ Belém
$ zzarrumacidade "BRASILIA"                       #→ Brasília
$ zzarrumacidade "CUIABA"                         #→ Cuiabá
$ zzarrumacidade "FLORIANOPOLIS"                  #→ Florianópolis
$ zzarrumacidade "GOIANIA"                        #→ Goiânia
$ zzarrumacidade "JOAO PESSOA"                    #→ João Pessoa
$ zzarrumacidade "MACAPA"                         #→ Macapá
$ zzarrumacidade "MACEIO"                         #→ Maceió
$ zzarrumacidade "SAO LUIS"                       #→ São Luís
$ zzarrumacidade "VITORIA"                        #→ Vitória

# Corrige capital
$ zzarrumacidade "são luis"                       #→ São Luís
$ zzarrumacidade "sao luís"                       #→ São Luís
$ zzarrumacidade "são luís"                       #→ São Luís
$ zzarrumacidade "sao luiz"                       #→ São Luís
$ zzarrumacidade "são luiz"                       #→ São Luís
$ zzarrumacidade "sao luíz"                       #→ São Luís
$ zzarrumacidade "são luíz"                       #→ São Luís

# Muitas cidades emprestam o nome do estado
$ zzarrumacidade "foo do amapa"                   #→ Foo do Amapá
$ zzarrumacidade "foo do ceara"                   #→ Foo do Ceará
$ zzarrumacidade "foo do goias"                   #→ Foo do Goiás
$ zzarrumacidade "foo do maranhao"                #→ Foo do Maranhão
$ zzarrumacidade "foo do para"                    #→ Foo do Pará
$ zzarrumacidade "foo do paraiba"                 #→ Foo do Paraíba
$ zzarrumacidade "foo do parana"                  #→ Foo do Paraná
$ zzarrumacidade "foo do piaui"                   #→ Foo do Piauí
$ zzarrumacidade "foo do rondonia"                #→ Foo do Rondônia

# O nome de alguns estados pode aparecer no início/meio
$ zzarrumacidade "amapa do sul"                   #→ Amapá do Sul
$ zzarrumacidade "espirito do sul"                #→ Espírito do Sul
$ zzarrumacidade "para do sul"                    #→ Pará do Sul
$ zzarrumacidade "paraiba do sul"                 #→ Paraíba do Sul

# Restaura acentuação de maneira genérica
$ zzarrumacidade "uberlandia"                     #→ Uberlândia
$ zzarrumacidade "rolandia"                       #→ Rolândia
$ zzarrumacidade "florianopolis"                  #→ Florianópolis
$ zzarrumacidade "virginopolis"                   #→ Virginópolis
$ zzarrumacidade "caparao"                        #→ Caparaó
$ zzarrumacidade "sao Francisco"                  #→ São Francisco
# exceção
$ zzarrumacidade "alto caparao"                   #→ Alto Caparaó
# ão várias vezes
$ zzarrumacidade "sao joao do capao ribeirao"     #→ São João do Capão Ribeirão

# Exceções pontuais
$ zzarrumacidade "morro cabeça no tempo"          #→ Morro Cabeça no Tempo
$ zzarrumacidade "passa-e-fica"                   #→ Passa-e-Fica
$ zzarrumacidade "são joão del-rei"               #→ São João del-Rei
$ zzarrumacidade "xangri-lá"                      #→ Xangri-Lá
$ zzarrumacidade "pedro ii"                       #→ Pedro II
$ zzarrumacidade "pio ix"                         #→ Pio IX
$ zzarrumacidade "pio xii"                        #→ Pio XII
$ zzarrumacidade "estrela d'oeste"                #→ Estrela d'Oeste
$ zzarrumacidade "sítio d'abadia"                 #→ Sítio d'Abadia
$ zzarrumacidade "dias d'ávila"                   #→ Dias d'Ávila
$ zzarrumacidade "são joão do pau-d'alho"         #→ São João do Pau-d'Alho
$ zzarrumacidade "olhos-d'água"                   #→ Olhos-d'Água
$ zzarrumacidade "pau-d'arco"                     #→ Pau-d'Arco

# Testar cada palavra como um argumento diferente
$ zzarrumacidade rio de janeiro                   #→ Rio de Janeiro
$ zzarrumacidade vargem grande do rio pardo       #→ Vargem Grande do Rio Pardo

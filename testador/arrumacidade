#!/usr/bin/env bash

values=1
tests=(

# Volta algumas iniciais para minúsculas
"foo e bar"		t	"Foo e Bar"
"foo de bar"		t	"Foo de Bar"
"foo da bar"		t	"Foo da Bar"
"foo do bar"		t	"Foo do Bar"
"foo das bar"		t	"Foo das Bar"
"foo dos bar"		t	"Foo dos Bar"

# abreviações
"SP"			t	"São Paulo"
"RJ"			t	"Rio de Janeiro"
"BH"			t	"Belo Horizonte"
"BSB"			t	"Brasília"
"RIO"			t	"Rio de Janeiro"
"SAMPA"			t	"São Paulo"
"FLORIPA"		t	"Florianópolis"

# Restaura acentuação às capitais
"BELEM"			t	"Belém"
"BRASILIA"		t	"Brasília"
"CUIABA"		t	"Cuiabá"
"FLORIANOPOLIS"		t	"Florianópolis"
"GOIANIA"		t	"Goiânia"
"JOAO PESSOA"		t	"João Pessoa"
"MACAPA"		t	"Macapá"
"MACEIO"		t	"Maceió"
"SAO LUIS"		t	"São Luís"
"VITORIA"		t	"Vitória"

# Corrige capital
"são luis"		t	"São Luís"
"sao luís"		t	"São Luís"
"são luís"		t	"São Luís"
"sao luiz"		t	"São Luís"
"são luiz"		t	"São Luís"
"sao luíz"		t	"São Luís"
"são luíz"		t	"São Luís"

# Muitas cidades emprestam o nome do estado
"foo do amapa"		t	"Foo do Amapá"
"foo do ceara"		t	"Foo do Ceará"
"foo do goias"		t	"Foo do Goiás"
"foo do maranhao"	t	"Foo do Maranhão"
"foo do para"		t	"Foo do Pará"
"foo do paraiba"	t	"Foo do Paraíba"
"foo do parana"		t	"Foo do Paraná"
"foo do piaui"		t	"Foo do Piauí"
"foo do rondonia"	t	"Foo do Rondônia"

# O nome de alguns estados pode aparecer no início/meio
"amapa do sul"		t	"Amapá do Sul"
"espirito do sul"	t	"Espírito do Sul"
"para do sul"		t	"Pará do Sul"
"paraiba do sul"	t	"Paraíba do Sul"

# Restaura acentuação de maneira genérica
"uberlandia"			t	"Uberlândia"
"rolandia"			t	"Rolândia"
"florianopolis"			t	"Florianópolis"
"virginopolis"			t	"Virginópolis"
"alto caparao"			t	"Alto Caparaó"    # exceção
"caparao"			t	"Caparaó"
"sao Francisco"			t	"São Francisco"
"sao joao do capao ribeirao"	t	"São João do Capão Ribeirão"    # ão várias vezes

# Exceções pontuais
"morro cabeça no tempo"		t	"Morro Cabeça no Tempo"
"passa-e-fica"			t	"Passa-e-Fica"
"são joão del-rei"		t	"São João del-Rei"
"xangri-lá"			t	"Xangri-Lá"
"pedro ii"			t	"Pedro II"
"pio ix"			t	"Pio IX"
"pio xii"			t	"Pio XII"
"estrela d'oeste"		t	"Estrela d'Oeste"
"sítio d'abadia"		t	"Sítio d'Abadia"
"dias d'ávila"			t	"Dias d'Ávila"
"são joão do pau-d'alho"	t	"São João do Pau-d'Alho"
"olhos-d'água"			t	"Olhos-d'Água"
"pau-d'arco"			t	"Pau-d'Arco"
)
. _lib


# Testar cada palavra como um argumento diferente
values=5
tests=(
rio	de	janeiro	''	''	t	"Rio de Janeiro"
vargem	grande	do	rio	pardo	t	"Vargem Grande do Rio Pardo"
)
. _lib

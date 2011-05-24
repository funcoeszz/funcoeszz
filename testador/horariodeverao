#!/usr/bin/env bash
debug=0
values=1
tests=(
1995	t	"Antes de 2008 não havia regra fixa para o horário de verão"
2007	t	"Antes de 2008 não havia regra fixa para o horário de verão"
2008	t	"19/10/2008\n15/02/2009"
2009	t	"18/10/2009\n21/02/2010"
2010	t	"17/10/2010\n20/02/2011"

# Erros
01/01/1970	t	"Ano inválido '01/01/1970'"
-2000 		t	"Ano inválido '-2000'"
0 		t	"Ano inválido '0'"
foo 		t	"Ano inválido 'foo'"

# Epoch
1		t	"Antes de 2008 não havia regra fixa para o horário de verão"
10 		t	"Antes de 2008 não havia regra fixa para o horário de verão"
100 		t	"Antes de 2008 não havia regra fixa para o horário de verão"
1969 		t	"Antes de 2008 não havia regra fixa para o horário de verão"
)
. _lib

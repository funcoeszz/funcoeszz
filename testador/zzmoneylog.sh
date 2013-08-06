#!/usr/bin/env bash
debug=0
values=7


cat > _tmp <<EOS
2009-05-01	-100	Saldo inicial da conta :(
2009-05-15	-74,23	mercado|
2009-05-15	- 1,99	nerd| Prestação do mouse 10/12
2009-05-23	-39,90	presente, livro| Livro Horóscopo dos Duendes

2009-06-03	-342,59	presente| Um Shrubbery
2009-06-11	 30,00	Ganhei a aposta com o Zé
2009-06-12	-35,00	presente, nerd| Poster colorido 3D do Tux em Ascii Art
2009-06-15	- 1,99	nerd| Prestação do mouse 11/12
2009-06-29	-95,67	mercado|

2009-07-12	-199,90	presente| Segway usado no Mercado Livre
2009-07-15	- 1,99	nerd| Prestação do mouse 12/12 (acabou!)

2009-08-20	-10,00	Carnê do Baú

# A ordem não importa, é possível deixar juntas as transações periódicas
2009-05-05	500	salario|
2009-06-05	500	salario|
2009-07-05	500	salario|
2009-08-05	500	salario|

2009-05-07	-25,00	luz|
2009-06-07	-20,00	luz|
2009-07-07	-29,00	luz|
2009-08-07	-25,00	luz|

2009-05-07	-20,00	agua|
2009-06-07	-17,80	agua|
2009-07-07	-32,37	agua|
2009-08-07	-30,00	agua|


# Transações futuras!
2009-12-31	+99,99	salario| Bônus

# Pagamentos e ganhos parcelados
2009-08-05	-500/5	nerd| Netbook usado comprado parcelado
2009-11-25	100/2	presente| Presente de Natal, metade Nov, metade Dez

# Pagamentos e ganhos recorrentes
2009-05-05	-200*6	aluguel| Aluguel da casa (seis meses)
2009-09-10	100*4	presente| O Zé vai me dar 100 pilas por mês até o fim do ano
EOS

export ZZMONEYLOG=_tmp

tests=(
# ''	''	''	''	''	''	''	r	^Uso:.*
-z	''	''	''	''	''	''	t	"Opção inválida -z"
--foo	''	''	''	''	''	''	t	"Opção inválida --foo"
-a	foo	''	''	''	''	''	t	"Não consegui ler o arquivo foo"
-a	foo/	''	''	''	''	''	t	"Não consegui ler o arquivo foo/"

--	Baú	''	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"
Baú	''	''	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"

# Data parcial (final opcional)
-d	2		Baú	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"
-d	20		Baú	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"
-d	200		Baú	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"
-d	2009		Baú	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"
-d	2009-		Baú	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"
-d	2009-0		Baú	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"
-d	2009-08		Baú	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"
-d	2009-08-	Baú	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"
-d	2009-08-2	Baú	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"
-d	2009-08-20	Baú	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"

# Data no formato brasileiro é convertida
-d	03/06/2009      ''	''	''	''	''	t	"2009-06-03	-342,59	presente| Um Shrubbery"
-d	03/06/09        ''	''	''	''	''	t	"2009-06-03	-342,59	presente| Um Shrubbery"
# Faltando zeros
-d	3/06/2009       ''	''	''	''	''	t	"2009-06-03	-342,59	presente| Um Shrubbery"
-d	03/6/2009       ''	''	''	''	''	t	"2009-06-03	-342,59	presente| Um Shrubbery"
-d	3/6/2009        ''	''	''	''	''	t	"2009-06-03	-342,59	presente| Um Shrubbery"
# Faltando zeros e ano com dois dígitos
-d	3/06/09	        ''	''	''	''	''	t	"2009-06-03	-342,59	presente| Um Shrubbery"
-d	03/6/09	        ''	''	''	''	''	t	"2009-06-03	-342,59	presente| Um Shrubbery"
-d	3/6/09	        ''	''	''	''	''	t	"2009-06-03	-342,59	presente| Um Shrubbery"
# Só mês e ano
-d	06/2009	        Shru	''	''	''	''	t	"2009-06-03	-342,59	presente| Um Shrubbery"
-d	6/2009	        Shru	''	''	''	''	t	"2009-06-03	-342,59	presente| Um Shrubbery"

# Valor informado com ponto ou vírgula
-v	10,00		''	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"
-v	10.00		''	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"
-v	-10.00		''	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"
-v	-10,00		''	''	''	''	''	t	"2009-08-20	-10,00	Carnê do Baú"

# Tag parcial (início ou fim)
-t	livro		''	''	''	''	''	t	"2009-05-23	-39,90	presente, livro| Livro Horóscopo dos Duendes"
-t	livr		''	''	''	''	''	t	"2009-05-23	-39,90	presente, livro| Livro Horóscopo dos Duendes"
-t	liv		''	''	''	''	''	t	"2009-05-23	-39,90	presente, livro| Livro Horóscopo dos Duendes"
-t	vro		''	''	''	''	''	t	"2009-05-23	-39,90	presente, livro| Livro Horóscopo dos Duendes"

# Combinação

)
. _lib

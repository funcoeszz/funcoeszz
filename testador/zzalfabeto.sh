#!/usr/bin/env bash
debug=0
values=2

saida1="A
B
C
"
saida2="Alpha
Bravo
Charlie
"
saida3="Aveiro
Bragança
Coimbra
"
saida4="Alpha
-
Bravo
.
Charlie
"
saida5="1
2
3
4
"
saida6=".
[
+
*
(
{
"

tests=(
ABC	''		t	"$saida1"
--otan	ABC		t	"$saida2"
--pt	ABC		t	"$saida3"
--otan	A-B.C		t	"$saida4"
--otan	1234		t	"$saida5"
--otan	'.[+*({'	t	"$saida6"
)
. _lib

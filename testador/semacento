#!/usr/bin/env bash

values=1
tests=(

# Caracteres que serão desacentuados

àáâãäåèéêëìíîïòóôõöùúûü t
aaaaaaeeeeiiiiooooouuuu

ÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜ t
AAAAAAEEEEIIIIOOOOOUUUU

çÇñÑß¢Ðð£Øø§µÝý¥¹²³ªº t
cCnNBcDdLOoSuYyY123ao

# Caracteres que não serão alterados

abcdefghijklmnopqrstuvwxyz t
abcdefghijklmnopqrstuvwxyz

ABCDEFGHIJKLMNOPQRSTUVWXYZ t
ABCDEFGHIJKLMNOPQRSTUVWXYZ

0123456789 t
0123456789
)
. _lib

#!/usr/bin/env bash

values=2
tests=(
''	''	r	^Uso:.*
pt-en	''	r	^Uso:.*

''	livro	t	book
pt-en	livro	t	book
pt-es	livro	t	libro
pt-fr	livro	t	livre
pt-it	livro	t	libro
pt-de	livro	t	Buch
)
. _lib

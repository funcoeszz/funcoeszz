#!/usr/bin/env bash

values=1
protected=1

tests=(
foo.txt		t	txt
foo.TXT		t	TXT
foo.bar.txt	t	txt
foo.bar.baz.txt	t	txt
../../foo.txt	t	txt
'~/foo.txt'	t	txt
'foo bar.txt'	t	txt
/etc/passwd	t	''
.vimrc		t	''
foo.		t	''
)
. _lib

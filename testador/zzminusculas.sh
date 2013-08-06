#!/usr/bin/env bash
debug=0
values=1

lower='abcdefghijklmnopqrstuvwxyzàáâãäåèéêëìíîïòóôõöùúûüçñ'
upper='ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜÇÑ'

tests=(
$upper	t	$lower
)
. _lib

#!/bin/sh
# missing.sh - Show functions not yet tested

# Go to tests folder
cd $(dirname "$0")

# All zz functions have a counterpart in the test directory?
for zz_func in ../zz/*
do
	test -f $(basename $zz_func) || echo "$zz_func"
done

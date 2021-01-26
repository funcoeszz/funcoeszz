#!/bin/sh
# missing.sh - Show functions not yet tested

# Go to tests folder
cd $(dirname "$0")

# All zz functions have a counterpart in the test directory?
for zz_path in ../zz/*
do
	zz_file=$(basename "$zz_path")
	test -f "$zz_file" || echo "$zz_file"
done

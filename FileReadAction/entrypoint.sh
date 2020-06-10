#!/bin/sh -l

echo "ReadFileContent $1"
value=Get-Content my_package.txt
echo "::set-output name=surname::$value"
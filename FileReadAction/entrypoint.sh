#!/bin/sh -l

echo "ReadFileContent $1"
value="my_package.txt"
echo "::set-output name=surname::$value"
#!/bin/sh -l

echo "ReadFileContent $1"
echo "some custom text for testing"
value="my_package.txt"
echo "::set-output name=surname::$value"
#!/bin/sh -l

echo "ReadFileContent $1"
value=`\my_package.json`
echo "::set-output name=surname::$value"

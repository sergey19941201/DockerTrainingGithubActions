#!/bin/sh -l

echo "ReadFileContent $1"
echo "some custom text for testing"

yourfilenames=`ls`
for eachfile in $yourfilenames
do
   echo $eachfile
done

echo Get-Content my_package.txt

value="my_package.txt"
echo "::set-output name=surname::$value"